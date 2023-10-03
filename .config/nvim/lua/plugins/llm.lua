-- vim.lsp.set_log_level("debug")

return {
  {
    "huggingface/llm.nvim",
    enabled = false, -- TODO Waiting for https://github.com/huggingface/llm-ls/issues/17
    opts = {
      enable_suggestions_on_startup = true,
      lsp = {
        bin_path = "/Users/andersns/source/llm-ls/target/release/llm-ls",
      },
      api_token = nil, -- cf Install paragraph
      model = "http://0.0.0.0:14567/completions", -- can be a model ID or an http(s) endpoint
      tokens_to_clear = { "<EOT>" },
      fim = {
        enabled = true,
        prefix = "<PRE> ",
        middle = " <MID>",
        suffix = " <SUF>",
      },
      context_window = 4096,
      tokenizer = {
        repository = "codellama/CodeLlama-13b-hf",
      },
      tls_skip_verify_insecure = true,
    }, -- cf Setup
  },
}
