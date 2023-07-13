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
		{ i = "~/.config/lvim/config.lua" },
		{ z = "~/.zshrc" },
		{ t = "~/.tmux.conf" },
		{ a = "~/.config/alacritty/alacritty.yml" },
	}

	vim.g.startify_commands = {
		{ sy = { "Sync", ":Lazy sync" } },
	}

	vim.g.startify_session_autoload = 1
	vim.g.startify_session_delete_buffers = 0
	vim.g.startify_change_to_vcs_root = 1
	vim.g.startify_fortune_use_unicode = 1
	vim.g.startify_session_persistence = 1
	vim.g.startify_padding_left = 4

	vim.g.startify_enable_special = 0

	vim.cmd("let g:dashboard_session_directory = $HOME..'/.config/nvim/.sessions'")
end

return M
