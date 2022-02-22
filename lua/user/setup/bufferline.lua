local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
  return
end

bufferline.setup {
  options = {
    numbers = "none",
    close_command = "Bwipeout! %d",
    right_mouse_command = "Bwipeout! %d",
    left_mouse_command = "buffer %d",
    middle_mouse_command = nil,
    buffer_close_icon = '',
    modified_icon = "●",
    close_icon = '',
    left_trunc_marker = "",
    right_trunc_marker = "",
    name_formatter = function(buf) -- remove some file extensions
      if buf.name:match('[%.md|%.lua]') then
        return vim.fn.fnamemodify(buf.name, ':t:r')
      end
    end,
    max_name_length = 30,
    max_prefix_length = 30,
    tab_size = 20,
    diagnostics = false,
    diagnostics_update_in_insert = false,
    offsets = {
      {
        filetype = "neo-tree",
        text = "",
        padding = 1
      }
    },
    show_buffer_icons = false,
    show_buffer_close_icons = false,
  },
}
