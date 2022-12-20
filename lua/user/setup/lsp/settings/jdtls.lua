local status_ok, jdtls = pcall(require, "jdtls")
if not status_ok then
  return
end

local config = {
  cmd = {
    "java",
    "-jar",
    os.getenv("HOME") ..
        "/.local/share/nvim/lsp_servers/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",
    -- depending on the OS - ../config_linux - change to one of the following OS options: linux win mac
    "-configuration", os.getenv("HOME") .. "/.local/share/nvim/lsp_servers/jdtls/config_linux",
  },
  settings = {
    java = {
    }
  },
  init_options = {
    bundles = {
      vim.fn.glob(os.getenv("HOME") ..
        "/programs/java-debug/com.microsoft.java.debug.repository/target/repository/plugins/com.microsoft.java.debug.plugin_0.36.0.jar") }
  },
}

jdtls.start_or_attach(config)
