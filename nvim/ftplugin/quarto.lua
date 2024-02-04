-- wrap text, but by word no character
-- indent the wrappped line
vim.wo.wrap = true
vim.wo.linebreak = true
vim.wo.breakindent = true
vim.wo.showbreak = "|"

-- don't run vim ftplugin on top
vim.api.nvim_buf_set_var(0, "did_ftplugin", true)

vim.cmd(
  [[
  function! _EscapeText_quarto(text)
    let out = _EscapeText_r(a:text)
    return out
  endfunction
  ]]
)
