return {
	"barrett-ruth/import-cost.nvim",
	build = "sh install.sh yarn", -- or 'npm' if you use npm
	config = function()
		require("import-cost").setup({
			auto_start = true, -- auto run on file open
			format = {
				virtual_text = "compact", -- or 'multiline'
			},
			languages = {
				javascript = true,
				typescript = true,
				javascriptreact = true,
				typescriptreact = true,
			},
		})
	end,
}
