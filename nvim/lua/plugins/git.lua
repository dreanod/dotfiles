return {
	-- git and projects
	{ "sindrets/diffview.nvim" },
  { "tpope/vim-fugitive" },
  { "tpope/vim-rhubarb" },
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({})
		end,
	},
}
