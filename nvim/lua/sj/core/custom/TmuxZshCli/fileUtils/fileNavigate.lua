-- w: ╭──────────── Block Start ────────────╮
-- w: ╰───────────── Block End ─────────────╯

-- w: ╭──────────── Block Start ────────────╮
-- go to package.json file
vim.keymap.set("n", "<leader>np", function()
	local package_json_path = vim.fn.findfile("package.json", ".;")
	if package_json_path ~= "" then
		vim.cmd("edit " .. package_json_path)
	else
		print("No package.json file found in the current project.")
	end
end, { noremap = true, silent = true, desc = "Open package.json" })
-- w: ╰───────────── Block End ─────────────╯

--
--w: ╭──────────── Block Start ────────────╮
-- Open css file for react/nextJs projects
vim.keymap.set("n", "<leader>nc", function()
	-- First: search src/index.css
	local index_css_path = vim.fn.findfile("src/index.css", ".;")
	if index_css_path ~= "" then
		vim.cmd("edit " .. index_css_path)
		print("Opened: " .. index_css_path)
		return
	end

	-- Fallback: src/app/globals.css
	local globals_css_path = vim.fn.findfile("src/app/globals.css", ".;")
	if globals_css_path ~= "" then
		vim.cmd("edit " .. globals_css_path)
		print("Opened fallback: " .. globals_css_path)
	else
		print("No src/index.css or src/app/globals.css found in the current project.")
	end
end, { noremap = true, silent = true, desc = "Open css file for react/nextJs" })
--w: ╰───────────── Block End ─────────────╯
--
--
--
-- w: ╭──────────── Block Start ────────────╮
-- go to router.jsx file for react projects
local function goToRouterJsx()
	local paths = {
		"src/router.jsx",
		"src/router/router.jsx",
		"router.jsx",
	}

	-- Try direct common paths first
	for _, path in ipairs(paths) do
		if vim.fn.filereadable(path) == 1 then
			vim.cmd("edit " .. path)
			print("Opened: " .. path)
			return
		end
	end

	-- Fallback to search via `find`
	local result = vim.fn.systemlist("find . -type f -name 'router.jsx'")
	if #result > 0 then
		vim.cmd("edit " .. result[1])
		print("Found and opened: " .. result[1])
	else
		print("router.jsx not found.")
	end
end
vim.keymap.set("n", "<leader>nn", goToRouterJsx, { desc = "Open router.jsx" })
-- w: ╰───────────── Block End ─────────────╯
--
--
--
-- w: ╭──────────── Block Start ────────────╮
-- go to main.jsx/layout.jsx/tsx/js/ts file for react/nextJs projects
local function goToMainOrLayout()
	local function open_file(path)
		vim.cmd("edit " .. path)
		print("Opened: " .. path)
	end

	-- 1️⃣ First: Check for main.jsx in current directory
	if vim.fn.filereadable("main.jsx") == 1 then
		open_file("main.jsx")
		return
	end

	-- 2️⃣ Second: Check specifically src/app/layout.{js,ts,jsx,tsx}
	local layout_variants = {
		"src/app/layout.js",
		"src/app/layout.ts",
		"src/app/layout.jsx",
		"src/app/layout.tsx",
	}
	for _, file in ipairs(layout_variants) do
		if vim.fn.filereadable(file) == 1 then
			open_file(file)
			return
		end
	end

	-- 3️⃣ Third: Fallback - search project for layout file
	local search_cmd =
		"find . -maxdepth 4 -type f \\( -name 'layout.js' -o -name 'layout.ts' -o -name 'layout.jsx' -o -name 'layout.tsx' \\)"
	local result = vim.fn.systemlist(search_cmd)
	if #result > 0 then
		open_file(result[1])
	else
		print("No main.jsx or layout file found.")
	end
end
-- Bind to <leader>nm
vim.keymap.set("n", "<leader>nm", goToMainOrLayout, { desc = "Open main.jsx" })
-- w: ╰───────────── Block End ─────────────╯

--
--
--
-- w: ╭──────────── Block Start ────────────╮
-- Lua function to open the README.md file from the project root
local function openProjectReadme()
	local util = require("lspconfig.util") -- Neovim LSP util for root detection

	-- Detect root dir using common project markers
	local root_dir = util.root_pattern("package.json", "README.md")(vim.fn.expand("%:p"))

	if root_dir then
		local readme_path = root_dir .. "/README.md"
		if vim.fn.filereadable(readme_path) == 1 then
			vim.cmd("edit " .. readme_path)
		else
			vim.notify("README.md not found in project root.", vim.log.levels.WARN)
		end
	else
		vim.notify("Project root not found.", vim.log.levels.ERROR)
	end
end

-- Optional: map it to a keybinding (like <leader>rd)
vim.keymap.set("n", "<leader>nr", openProjectReadme, { desc = "Open project root README.md" })
-- w: ╰───────────── Block End ─────────────╯
-- w: ╭──────────── Block Start ────────────╮
-- Go to .env or .env.local in the project root
vim.keymap.set("n", "<leader>ne", function()
	local candidates = { ".env", ".env.local" }

	for _, file in ipairs(candidates) do
		if vim.fn.filereadable(file) == 1 then
			vim.cmd("edit " .. file)
			print("Opened: " .. file)
			return
		end
	end

	print("No .env or .env.local found in current directory.")
end, { noremap = true, silent = true, desc = "Open .env or .env.local" })
-- w: ╰───────────── Block End ─────────────╯
-- w: ╭──────────── Block Start ────────────╮
-- From Neovim: open textNvim.md in tmux session alwaysNvim
vim.keymap.set("n", "<leader>nw", function()
	local file = "/run/media/sj/developer/web/L1B11/textNvim.md"
	local session = "alwaysNvim"

	-- Check if tmux is running
	if vim.fn.exists("$TMUX") == 0 then
		vim.notify("Not inside tmux!", vim.log.levels.ERROR)
		return
	end

	-- Build tmux command
	local cmd = string.format(
		"tmux has-session -t %s 2>/dev/null "
			.. "|| tmux new-session -ds %s 'nvim --cmd \"autocmd VimEnter * startinsert\" %s'; "
			.. "tmux switch-client -t %s",
		session,
		session,
		file,
		session
	)

	vim.fn.system(cmd)
end, { noremap = true, silent = true, desc = "Switch to alwaysNvim session with textNvim.md" })
-- w: ╰───────────── Block End ─────────────╯

-- Function to open your Tracker.md file
local function openTracker()
	local tracker_path = "/run/media/sj/developer/web/L1B11/career/JobDocuments/Tracker/Tracker.md"
	if vim.fn.filereadable(tracker_path) == 1 then
		vim.cmd("edit " .. tracker_path)
	else
		vim.notify("Tracker.md not found at " .. tracker_path, vim.log.levels.WARN)
	end
end

-- Map it to <leader>nt
vim.keymap.set("n", "<leader>nt", openTracker, { desc = "Open Tracker.md" })
