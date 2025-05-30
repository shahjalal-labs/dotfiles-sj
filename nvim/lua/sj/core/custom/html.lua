function OpenGitHubRepo()
	-- Get the current directory's git repository URL
	local git_url = vim.fn.system("git config --get remote.origin.url"):gsub("\n", "")

	-- Remove .git suffix if present
	git_url = git_url:gsub("%.git$", "")

	-- Replace SSH URL with HTTPS if needed
	git_url = git_url:gsub("^git@github%.com:", "https://github.com/")

	-- Open in Chrome
	local open_cmd = string.format("google-chrome %s", git_url)
	os.execute(open_cmd)
end

-- Optional: Set a keymapping
vim.api.nvim_set_keymap("n", "<leader>go", ":lua OpenGitHubRepo()<CR>", { noremap = true, silent = true })
