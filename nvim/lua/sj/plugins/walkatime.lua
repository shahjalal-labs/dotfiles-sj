return {
	"wakatime/vim-wakatime",
	keys = {
		{
			"<leader>wd",
			"<cmd>lua vim.fn.system('xdg-open https://wakatime.com/dashboard')<cr>",
			desc = "Open WakaTime Dashboard",
		},
	},
	lazy = false,
}
