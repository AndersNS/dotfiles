local map = vim.keymap.set
local unmap = vim.keymap.del
local is_available = astronvim.is_available

map("t", "<leader><esc>", "<c-\\><c-n>", { desc = "Terminal normal mode" })
map("t", "<esc><esc>", "<c-\\><c-n>:q<cr>", { desc = "Terminal quit" })

-- dapui
map("n", "duc", function()
	require("dapui").close()
end, { desc = "Dap UI: Close" })
map("n", "dut", function()
	require("dapui").toggle()
end, { desc = "Dap UI: Toggle" })

-- resize with arrows
map("n", "<Up>", function()
	require("smart-splits").resize_up(2)
end, { desc = "Resize split up" })
map("n", "<Down>", function()
	require("smart-splits").resize_down(2)
end, { desc = "Resize split down" })
map("n", "<Left>", function()
	require("smart-splits").resize_left(2)
end, { desc = "Resize split left" })
map("n", "<Right>", function()
	require("smart-splits").resize_right(2)
end, { desc = "Resize split right" })
