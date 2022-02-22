local colorscheme = "orbital"
local ambiant_name = "ambiant"
local ambiant_value = "dark"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("The color scheme " .. colorscheme .. " was not found !")
  return
end

status_ok, _ = pcall(vim.cmd, "let " .. ambiant_name .. "='" .. ambiant_value .. "'")
if not status_ok then
  vim.notify("The color scheme ambiant_value " .. ambiant_value .. " is not allowed !")
  return
end
