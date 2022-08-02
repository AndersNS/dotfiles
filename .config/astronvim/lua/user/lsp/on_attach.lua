return function(client)
	if
		vim.tbl_contains({
			"solargraph",
			"gopls",
			"sqls",
			"remark_ls",
			"rust_analyzer",
			"sumneko_lua",
		}, client.name)
	then
		astronvim.lsp.disable_formatting(client)
	end
end
