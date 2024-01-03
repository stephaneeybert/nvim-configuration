local status_ok, neo_tree = pcall(require, "neo-tree")
if not status_ok then
  return
end

neo_tree.setup {
  window = {
    width = 40,
    mappings = {
      ["l"] = "open",
    }
  },
  filesystem = {
    follow_current_file = {
      enabled = {
        true,
      }
    }
  }
}

