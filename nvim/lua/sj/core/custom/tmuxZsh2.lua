-- ╭──────────── Block Start ────────────╮

-- ╰───────────── Block End ─────────────╯

local keymap = vim.keymap

--t: Function to restore specific tmux layouts
function restore_tmux_layouts()
	vim.fn.system("tmux select-layout -t 0 '8d8d,210x44,0,0[210x27,0,0,4,210x16,0,28{104x16,0,28,5,105x16,105,28,6}]'")
	vim.fn.system("tmux select-layout -t 2 '6520,210x44,0,0[210x28,0,0,7,210x15,0,29{104x15,0,29,8,105x15,105,29,9}]'")
	vim.fn.system(
		"tmux select-layout -t 3 '2ecf,210x44,0,0[210x32,0,0,10,210x11,0,33{107x11,0,33,11,102x11,108,33,12}]'"
	)
end

keymap.set("n", "<leader>aa", ":lua restore_tmux_layouts()<CR>", { noremap = true, silent = true })

--
--
--
--
--
--
--
--t: clear tmux panes
vim.api.nvim_set_keymap("n", "<space>al", ":lua ClearOtherTmuxPanes()<CR>", { noremap = true, silent = true })
function ClearOtherTmuxPanes()
	-- Get the tmux pane ID for the current Neovim instance
	local current_pane = vim.fn.system('tmux display-message -p "#{pane_id}"'):gsub("%s+", "")

	-- Get a list of all tmux panes
	local panes = vim.fn.systemlist('tmux list-panes -F "#{pane_id}"')

	for _, pane in ipairs(panes) do
		if pane ~= current_pane then
			vim.fn.system("tmux send-keys -t " .. pane .. ' "clear" C-m')
		end
	end

	-- Notify the user
	vim.notify("Cleared all tmux panes except the active Neovim pane")
	vim.api.nvim_set_keymap("n", "<space>al", ":lua ClearOtherTmuxPanes()<CR>", { noremap = true, silent = true })

	function ClearOtherTmuxPanes()
		-- Get the tmux pane ID for the current Neovim instance
		local current_pane = vim.fn.system('tmux display-message -p "#{pane_id}"'):gsub("%s+", "")

		-- Get a list of all tmux panes
		local panes = vim.fn.systemlist('tmux list-panes -F "#{pane_id}"')

		-- Loop through each pane and clear it if it is not the current Neovim pane
		for _, pane in ipairs(panes) do
			if pane ~= current_pane then
				vim.fn.system("tmux send-keys -t " .. pane .. ' "clear" C-m')
			end
		end

		-- Clear Neovim's integrated terminal if in terminal mode
		if vim.bo.buftype == "terminal" then
			vim.api.nvim_feedkeys("i<C-u>", "n", true) -- Clear the terminal buffer
		end

		-- Notify the user
		vim.notify("Cleared all tmux panes except the active Neovim pane")
	end
end
--
--
--
--
--
--

-- update another time

vim.keymap.set("n", "<leader>gm", ":!gh repo view --web<CR>", { noremap = true, silent = true })

--
--
--
--
--
--
--
--w: yank the current projects root path
vim.keymap.set("n", "<leader>cr", function()
	vim.fn.setreg("+", vim.fn.getcwd())
	print("Copied root directory: " .. vim.fn.getcwd())
end, { desc = "Copy root directory to clipboard" })

--t: ╭──────────── Block Start ────────────╮
-- Generate clean directory tree markdown
local function generate_structure_md()
	local cwd = vim.fn.getcwd()
	local output_file = cwd .. "/structure.md"

	local handle = io.popen("tree -C -I '.git|node_modules|.DS_Store|dist'")
	if not handle then
		print("❌ Failed to run tree command.")
		return
	end

	local result = handle:read("*a")
	handle:close()

	-- Remove ANSI color codes
	result = result:gsub("\27%[[0-9;]*m", "")

	local file = io.open(output_file, "w")
	if not file then
		print("❌ Cannot open structure.md for writing.")
		return
	end

	file:write("# 📁 Project Structure\n\n")
	file:write("```bash\n")
	file:write(result)
	file:write("\n```\n")
	file:close()

	print("✅ structure.md updated successfully.")
end

vim.keymap.set("n", "<leader>ds", generate_structure_md, {
	noremap = true,
	silent = true,
	desc = "🗂️ Generate structure.md",
})
--t: ╰───────────── Block End ─────────────╯
