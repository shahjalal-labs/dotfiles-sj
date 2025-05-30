return {
	{
		"Shatur/neovim-session-manager",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		event = "VeryLazy", -- Load after startup
		config = function()
			local Path = require("plenary.path")
			local config = require("session_manager.config")

			require("session_manager").setup({
				-- Directory to store session files
				sessions_dir = Path:new(vim.fn.stdpath("data"), "sessions"),

				-- Autoload behavior when nvim starts
				autoload_mode = {
					config.AutoloadMode.CurrentDir,
					config.AutoloadMode.LastSession,
				},

				-- Session autosaving
				autosave_last_session = true,
				autosave_ignore_not_normal = true,
				autosave_ignore_dirs = {
					-- Add directories you want to ignore
					-- e.g., "/tmp",
					-- e.g., "~/Projects/Temp",
				},

				-- Ignore these filetypes when saving session
				autosave_ignore_filetypes = {
					"gitcommit",
					"gitrebase",
					"help",
					"qf", -- quickfix window
					"notify",
				},

				-- Ignore these buftypes when saving session
				autosave_ignore_buftypes = {
					"terminal",
					"nofile",
				},

				-- Only autosave if there's already an active session
				autosave_only_in_session = false,

				-- Path display options
				max_path_length = 80,

				-- Whether to include current session in load_session menu
				load_include_current = false,
			})

			-- Keymaps
			local keymap = vim.keymap.set
			keymap("n", "<leader>,s", "<cmd>SessionManager save_current_session<CR>", { desc = "Save session" })
			keymap("n", "<leader>,l", "<cmd>SessionManager load_session<CR>", { desc = "Load session" })
			keymap("n", "<leader>,d", "<cmd>SessionManager delete_session<CR>", { desc = "Delete session" })

			-- Optional: Auto-save session on buffer write
			local session_manager = require("session_manager")
			local config_group = vim.api.nvim_create_augroup("SessionManagerGroup", { clear = true })

			-- Auto-save session on buffer write
			vim.api.nvim_create_autocmd({ "BufWritePre" }, {
				group = config_group,
				callback = function()
					for _, buf in ipairs(vim.api.nvim_list_bufs()) do
						-- Don't save while there's any 'nofile' buffer open
						if vim.api.nvim_get_option_value("buftype", {

							buf = buf,
						}) == "nofile" then
							return
						end
					end
					session_manager.save_current_session()
				end,
			})

			-- Optional: Auto-open file tree (e.g., nvim-tree) when loading a session
			vim.api.nvim_create_autocmd({ "User" }, {
				pattern = "SessionLoadPost",
				group = config_group,
				callback = function()
					-- Uncomment if you use nvim-tree
					-- require('nvim-tree.api').tree.toggle(false, true)
				end,
			})
		end,
	},
}
