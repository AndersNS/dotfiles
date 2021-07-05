-- :LspInstall angular
require'lspconfig'.angularls.setup {
    cmd = {DATA_PATH .. "/lspinstall/angular/node_modules/@angular/language-server/bin/ngserver", "--stdio", "--tsProbeLocations", "", "--ngProbeLocations", ""},
    on_attach = require'lsp'.common_on_attach,
}
