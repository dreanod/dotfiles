vim.cmd(
  [[
  function! _EscapeText_r(text)
    if len(split(a:text, "\n")) > 1
      let cwd = getcwd()
      call system("cat > " . cwd . "/.slime_r", a:text)
      return ["\rsource('" . cwd . "/.slime_r', echo = TRUE, max.deparse.length = 4095, spaced = FALSE)\r\r"]
    else
      return [a:text]
    endif
  endfunction
  ]]
)
