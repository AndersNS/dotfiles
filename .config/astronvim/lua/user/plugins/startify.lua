local M = {}

M.config = function()
	vim.g.startify_session_dir = "~/.config/nvim/session"

	vim.g.startify_lists = {
		{ type = "sessions", header = { "   Sessions" } },
		{ type = "files", header = { "   Files" } },
		{ type = "dir", header = { "   Files " .. vim.fn.getcwd() } },
		{ type = "bookmarks", header = { "   Bookmarks" } },
		{ type = "commands", header = { "    Commands" } },
	}

	vim.g.startify_bookmarks = {
		{ i = "~/.config/astronvim/lua/user/init.lua" },
		{ z = "~/.zshrc" },
		{ t = "~/.tmux.conf" },
		{ a = "~/.config/alacritty/alacritty.yml" },
		{ k = "~/.config/kitty/kitty.conf" },
		{ n = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/andersns" },
	}

	vim.g.startify_commands = {
		{ up = { "Update Plugins", ":PackerUpdate" } },
		{ cp = { "Clean up Plugins", ":PackerClean" } },
		{ co = { "Compile plugins", ":PackerCompile" } },
	}

	vim.g.startify_session_autoload = 1
	vim.g.startify_session_delete_buffers = 0
	vim.g.startify_change_to_vcs_root = 1
	vim.g.startify_fortune_use_unicode = 1
	vim.g.startify_session_persistence = 1
	vim.g.startify_padding_left = 4

	vim.g.startify_enable_special = 0

	vim.cmd("let g:dashboard_session_directory = $HOME..'/.config/nvim/.sessions'")

	vim.cmd("let plugins_loaded = len(globpath('~/.local/share/nvim/site/pack/packer/start/', '*', 0, 1))")
	vim.cmd("let plugins_count = len(globpath('~/.local/share/nvim/site/pack/packer/start', '*', 0, 1)) + len(globpath('~/.local/share/nvim/site/pack/packer/opt', '*', 0, 1))")

	vim.api.nvim_exec(
		[[
    let g:startify_custom_footer = ['    Loaded '..plugins_loaded..' and has '..plugins_count..' plugins  ']
]],
		false
	)
end

return M
