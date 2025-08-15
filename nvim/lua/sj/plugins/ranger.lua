return {
	"kelly-lin/ranger.nvim",

	config = function()
		local ranger_nvim = require("ranger-nvim")
		ranger_nvim.setup({
			replace_netrw = true,
		})

		-- Normal open (current window)
		vim.api.nvim_set_keymap("n", "<leader>e,", "", {
			noremap = true,
			callback = function()
				ranger_nvim.open(true)
			end,
		})

		-- Vertical split open
		vim.api.nvim_set_keymap("n", "<leader>ev", "", {
			noremap = true,
			callback = function()
				ranger_nvim.open(true, ranger_nvim.OPEN_MODE.vsplit)
			end,
		})
	end,
}
