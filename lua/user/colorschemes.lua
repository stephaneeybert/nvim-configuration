local colorscheme = "twilight256"
local ambiant = "dark"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

if not status_ok then
  vim.notify("The color scheme " .. colorscheme .. " was not found !")
  return
end

local status_ok, _ = pcall(vim.cmd, "set background=" .. ambiant)

if not status_ok then
  vim.notify("The color scheme ambiant " .. ambiant .. " is not allowed !")
  return
end

