local project = string.gsub(vim.fn.system("basename $(pwd)"), "%s+", "")

local tmux_sk = function(cmds, session, window, pane) 
  local where = session .. ":" .. window .. "." .. pane
  for _, cmd in ipairs(cmds) do
    cmd = string.gsub(cmd, '"', '\\"')
    cmd = string.gsub(cmd, "%$", [[\$]])
    cmd = string.gsub(cmd, "`", '\\`')
    local call = 'tmux send-keys -t ' .. where .. ' "' .. cmd .. '" ENTER'
    vim.fn.system(call)
  end
end

--------------------------------------------------------------------------------

local send_to_console = function(cmds)
  tmux_sk(cmds, project, "1", "3")
end

local send_to_terminal = function(cmds)
  tmux_sk(cmds, project, "1", "2")
end

--------------------------------------------------------------------------------

local get_text_object_line = function()
  local line_start = vim.fn.line("'[")
  local line_end = vim.fn.line("']")
  if (line_start ~= nil and line_end ~= nil) then
    local text = vim.fn.getline(line_start, line_end)
    return text
  end
end

local get_text_object_char = function()
  vim.cmd('normal `["zyv`]')
  return vim.fn.getreg("z")
end

local get_selected_text = function()
  local line_start = vim.fn.line("v")
  local line_end = vim.fn.line(".")
  if (line_start ~= nil and line_end ~= nil) then
    local text = {""}
    if (line_start ~= line_end) then
      text = vim.fn.getline(line_start, line_end)
    else
      vim.cmd('normal "zy')
      text = {vim.fn.getreg("z")}
    end
    return text
  end
end

--------------------------------------------------------------------------------

local send_r_line = function()
  local cmd = vim.api.nvim_get_current_line()
  send_to_console({ cmd })
  vim.cmd("norm! j")
end

local send_r_region = function()
  local text = get_selected_text()
  send_to_console(text)
  vim.api.nvim_input("<esc>")
end

local get_r_help = function()
  vim.cmd('normal "zyiw')
  send_to_console({ "?" .. vim.fn.getreg("z")})
end

function SendRTextObject(motion)
  if motion == nil then
    vim.fn.setpos("'z", {vim.fn.bufnr(""), vim.fn.line("."), vim.fn.col("."), 0})
    vim.go.operatorfunc = "v:lua.SendRTextObject"
    return "g@"
  end

  if motion == "char" then
    local cmd = get_text_object_char()
    send_to_console({ cmd })
    vim.cmd("normal `z")
  end

  if motion == "line" then
    local cmd = get_text_object_line()
    send_to_console(cmd)
    vim.cmd("normal `z")
  end
end

local function starts_with_hash_dollar(str)
    return string.sub(str, 1, 2) == "#$"
end

local function remove_starting_hash_dollar(str)
  local new_str = str:gsub("^#%$ *", "")
  return new_str
end

local send_r_comment_line = function()
  local cmd = vim.api.nvim_get_current_line()
  send_to_console({ remove_starting_hash_dollar(cmd) })
end

function SendCommentedRTextObject(motion)
  if motion == nil then
    vim.fn.setpos("'z", {vim.fn.bufnr(""), vim.fn.line("."), vim.fn.col("."), 0})
    vim.go.operatorfunc = "v:lua.SendCommentedRTextObject"
    return "g@"
  end

  if motion == "char" then
    local cmd = get_text_object_char()
    send_to_console({ cmd })
    vim.cmd("normal `z")
  end

  if motion == "line" then
    local cmds = get_text_object_line()
    for _, cmd in ipairs(cmds) do
      if starts_with_hash_dollar(cmd) then
        send_to_console({ remove_starting_hash_dollar(cmd) })
      end
    end
    vim.cmd("normal `z")
  end
end

local restart_r = function()
  send_to_console({"C-c", "q()", "clear", "R --quiet"})
end

local source_r_file = function()
  restart_r()
  local cmd = 'source(\'' .. vim.api.nvim_buf_get_name(0) .. '\', echo = TRUE, spaced = FALSE)'
  send_to_console({ cmd })
end

local reload_r_package = function()
  restart_r()
  send_to_console({ "devtools::load_all()" })
end

local test_r_package = function()
  send_to_terminal({ "Rtest" }) 
end

local check_r_package = function()
  send_to_console({ "devtools::check()" }) 
end

local build_r_package_doc = function()
  send_to_console({ "devtools::document()" })
end

local build_r_package = function()
  send_to_console({ "devtools::build()" })
end

local install_r_package = function()
  build_r_package_doc()
  send_to_console({ "devtools::install()" })
end

local ns = vim.api.nvim_create_namespace("test_results")

local display_test_results = function(results)
  vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
  local failed = {}
  for _, result in ipairs(results) do
    if result.result == "expectation_success" then
      vim.api.nvim_buf_set_extmark(0, ns, result.line_number - 1, 0, { virt_text = { { ""} } })
    elseif result.result == "expectation_failure" then
      table.insert(failed, {
        bufnr = 0,
        lnum = result.line_number - 1,
        col = 0,
        severity = vim.diagnostic.severity.ERROR,
        message = result.message,
        source = "testthat",
        user_data = {}
      })
      -- vim.api.nvim_buf_set_extmark(0, ns, result.line_number - 1, 0, { virt_text = { { "FAIL"} } })
    end
  end
  vim.diagnostic.set(ns, 0, failed, {})
end

local test_local_R = function()
  local content = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local capture = false
  local test_nb = 1
  for i, line in ipairs(content) do
    if string.match(line, "^#'") then
      if capture then
        content[i] = string.gsub(line, "^#'", "")
      else
        if string.match(line, "@tests") then
          capture = true
          content[i] = "test_that(\"test " .. test_nb .. "\", {"
          test_nb = test_nb + 1
        else
          content[i] = ""
        end
      end
    else
      if capture then
        content[i] = "})"
        capture = false
      else
        content[i] = ""
      end
    end
  end
  local outfn = vim.api.nvim_buf_get_name(0)
  outfn = vim.fs.dirname(outfn) .. '/.test-' .. vim.fs.basename(outfn)
  vim.fn.writefile(content, outfn)
  vim.fn.jobstart(
    "R --slave -e 'testpackage::test_logger(\"" .. outfn .. "\")'",
    { on_exit = function() 
        local s = io.open(outfn .. ".json"):read("*a")
        local results = vim.fn.json_decode(s)
        display_test_results(results)
        vim.fn.system({ "rm", outfn })
      end 
    }
  )
end

local start_shiny_app = function()
  restart_r()
  reload_r_package()
  local app_fun = vim.api.nvim_exec('!grep % -o -e "^\\(mod\\|run\\)_.*_app" -m 1', true)
  local cmd = app_fun:sub(1, -2) .. "()"
  send_to_console({ cmd })
end

local get_filename = function()
  return vim.api.nvim_buf_get_name(0)
end

local save_buffer = function()
  vim.cmd("normal :w")
end

local render_quarto = function()
  save_buffer()
  local cmds = {
    "quarto render " .. get_filename(),
    "open " .. get_filename():gsub("qmd$", "pdf")
  }
  send_to_terminal(cmds)
end

vim.keymap.set("n", "<cr>", SendRTextObject, { noremap = true, expr = true, desc = "Execute Text Object" })
vim.keymap.set("n", "<cr><cr>", send_r_line, { noremap = true, expr = false, desc = "Execute R line" })
vim.keymap.set("v", "<cr>", send_r_region, { noremap = true, expr = false, desc = "Execute R Region"})
vim.keymap.set("n", "<bs>l", reload_r_package, { noremap = true, expr = false, desc = "Reload R package" })
vim.keymap.set("n", "<bs>r", restart_r, { noremap = true, expr = false, desc = "Restart R session" })
vim.keymap.set("n", "<bs>t", test_r_package, { noremap = true, expr = false, desc = "Test R Package" })
vim.keymap.set("n", "<bs>b", build_r_package, { noremap = true, expr = false, desc = "Test R Package" })
vim.keymap.set("n", "<bs>d", build_r_package_doc, { noremap = true, expr = false, desc = "Build R Package Documentation" })
vim.keymap.set("n", "<bs>i", install_r_package, { noremap = true, expr = false, desc = "Install R Package" })
vim.keymap.set("n", "<bs>e", check_r_package, { noremap = true, expr = false, desc = "Check R Package" })
vim.keymap.set("n", "<bs>s", source_r_file, { noremap = true, expr = false, desc = "Source R file"})
vim.keymap.set("n", "<bs>?", get_r_help, { noremap = true, expr = false, desc = "Get R Help"})
vim.keymap.set("n", "<bs>a", start_shiny_app, { noremap = true, expr = false, desc = "Start Shiny app"})
vim.keymap.set("n", "<bs>q", render_quarto, { noremap = true, expr = false, desc = "Render Quarto"})


vim.keymap.set("n", "<leader>ek", "<C-w>s:e ~/repos/dotfiles/nvim/lua/config/r_keymap.lua<cr>", { noremap = true, expr = false, desc = "Edit Keymaps"})

  vim.keymap.set("n", "<S-CR>", SendCommentedRTextObject, { noremap = true, expr = true, desc = "Send R Commented Line"})
vim.keymap.set("n", "<S-CR><S-CR>", send_r_comment_line, { noremap = true, expr = false, desc = "Send R Commented Line"})

vim.keymap.set("n", "<bs>w", test_local_R, { noremap = true, expr = false, desc = "Test Current R File"})
