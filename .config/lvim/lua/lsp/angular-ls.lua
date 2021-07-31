local util = require("lspconfig/util")

require("lspconfig").angularls.setup({
	cmd = { DATA_PATH .. "/lspinstall/angular/node_modules/@angular/language-server/bin/ngserver", "--stdio" },
	root_dir = util.root_pattern("angular.json", ".git"),
	filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx" },
	on_attach = require("lsp").common_on_attach,
})
