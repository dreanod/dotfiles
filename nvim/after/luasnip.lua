local ls = require('luasnip')

ls.config.set_config({
  history = true,
  updateevents = "TextChanged, TextChangedI",
  enable_autosnippets = true
})

vim.keymap.set("n", "<leader>es", require("luasnip.loaders").edit_snippet_files)
