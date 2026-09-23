-- nvim-ts-autotag only closes tags in razor when the cursor is already inside an
-- html element; at the top level or directly in @if/@foreach blocks the razor
-- grammar parses an unclosed tag as ERROR. Own `>` here: try autotag first, then
-- fall back to a guarded regex.
require("lazy").load({ plugins = { "nvim-ts-autotag" } })
local internal = require("nvim-ts-autotag.internal")
local bufnr = vim.api.nvim_get_current_buf()
internal.attach(bufnr)

local void_elements = {
  area = true, base = true, br = true, col = true, embed = true, hr = true, img = true,
  input = true, link = true, meta = true, param = true, source = true, track = true, wbr = true,
}

local function fallback_close(row, col)
  local line = vim.api.nvim_get_current_line()
  local before, after = line:sub(1, col + 1), line:sub(col + 2)
  -- `<` must start the line or follow whitespace, `>`, `(` or `@` so C# generics
  -- like `List<int>` don't match
  local prefix, tag, attrs = before:match("(.?)<(%a[%w%-%.:]*)([^<>]*)>$")
  if not tag or not (prefix == "" or prefix:match("[%s>(@]")) then
    return
  end
  if void_elements[tag:lower()] or attrs:match("/$") or attrs:match("[;&|]") then
    return
  end
  if attrs ~= "" and not attrs:match("^%s") then
    return
  end
  if after:match("^</" .. vim.pesc(tag) .. ">") then
    return
  end
  vim.api.nvim_buf_set_text(bufnr, row - 1, col + 1, row - 1, col + 1, { "</" .. tag .. ">" })
end

vim.keymap.set("i", ">", function()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  vim.api.nvim_buf_set_text(bufnr, row - 1, col, row - 1, col, { ">" })
  local before = vim.api.nvim_get_current_line()
  pcall(internal.close_tag)
  if vim.api.nvim_get_current_line() == before then
    fallback_close(row, col)
  end
  vim.api.nvim_win_set_cursor(0, { row, col + 1 })
end, { buffer = bufnr, noremap = true, silent = true, desc = "Razor autotag close" })
