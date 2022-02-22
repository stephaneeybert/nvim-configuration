local status_ok, jabs = pcall(require, "jabs")
if not status_ok then
  return
end

jabs.setup {
  position = 'center', -- center, corner
  width = 80, -- default 50
  height = 10, -- default 10
  border = 'single', -- none, single, double, rounded, solid, shadow, (or an array or chars)
  -- TODO Check if the plugin now supports a mapping to close the preview popup

  preview_position = 'right', -- top, bottom, left, right
  preview = {
    width = 80, -- default 70
    height = 30, -- default 30
    border = 'single', -- none, single, double, rounded, solid, shadow, (or an array or chars)
  },
}
