local unchecked_checkbox = "%[ %]"

local checked_checkbox = function(char)
  return "%[" .. char .. "%]"
end

local line_contains_unchecked = function(line)
  return line:find(unchecked_checkbox)
end

local line_contains_checked = function(line, char)
  return line:find(checked_checkbox(char))
end

local line_with_checkbox = function(line, char)
  return line:find("^%s*- " .. checked_checkbox(char))
    or line:find("^%s*- " .. unchecked_checkbox)
    or line:find("^%s*%d%. " .. checked_checkbox(char))
    or line:find("^%s*%d%. " .. unchecked_checkbox)
end

local checkbox = {
  check = function(line, char)
    return line:gsub(unchecked_checkbox, checked_checkbox(char), 1)
  end,

  uncheck = function(line, char)
    return line:gsub(checked_checkbox(char), unchecked_checkbox, 1)
  end,

  make_checkbox = function(line)
    if not line:match("^%s*-%s.*$") and not line:match("^%s*%d%s.*$") then
      -- "xxx" -> "- [ ] xxx"
      return line:gsub("(%S+)", "- [ ] %1", 1)
    else
      -- "- xxx" -> "- [ ] xxx", "3. xxx" -> "3. [ ] xxx"
      return line:gsub("(%s*- )(.*)", "%1[ ] %2", 1):gsub("(%s*%d%. )(.*)", "%1[ ] %2", 1)
    end
  end,
}

local M = {}

M.checked_character = "x"

M.toggle_checked = function(fchar)
  local bufnr = vim.api.nvim_buf_get_number(0)
  local cursor = vim.api.nvim_win_get_cursor(0)
  local start_line = cursor[1] - 1
  local current_line = vim.api.nvim_buf_get_lines(bufnr, start_line, start_line + 1, false)[1] or ""

  local char = M.checked_character
  if fchar ~= nil then
    char = fchar
  end
  -- If the line contains a checked checkbox then uncheck it.
  -- Otherwise, if it contains an unchecked checkbox, check it.
  local new_line = ""
  if not line_with_checkbox(current_line, char) then
    new_line = checkbox.make_checkbox(current_line)
  elseif line_contains_unchecked(current_line) then
    new_line = checkbox.check(current_line, char)
  elseif line_contains_checked(current_line, char) then
    new_line = checkbox.uncheck(current_line, char)
  end

  vim.api.nvim_buf_set_lines(bufnr, start_line, start_line + 1, false, { new_line })
  vim.api.nvim_win_set_cursor(0, cursor)
end

return M
