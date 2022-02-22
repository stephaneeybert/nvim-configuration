local status_ok, comment = pcall(require, "Comment")
if not status_ok then
  return
end

comment.setup {
  toggler = {
    -- Line comment toggle keymap
    line = '<A-c>',
  },

  opleader = {
    -- visual mode block comment keymap
    line = '<A-b>',
  },
}
