local status_ok, dap = pcall(require, "dap")
if not status_ok then
  print("The dap extension could not be loaded")
  return
end

dap.set_log_level("DEBUG")

dap.adapters.node2 = {
  type = "executable",
  command = "node",
  args = { os.getenv("HOME") .. "/apps/vscode-node-debug2/out/src/nodeDebug.js" },
}
dap.adapters.chrome = {
  type = "executable",
  command = "node",
  args = { os.getenv("HOME") .. "/dev/dap-debugger/vscode-js-debug/out/src/debugServerMain.js", "45635" },
}
dap.configurations.typescript = {
  {
    type = "chrome",
    request = "attach",
    program = "${file}",
    debugServer = 45635,
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    port = 9222,
    webRoot = "${workspaceFolder}",
  }
}

dap.adapters.java = {
  type = 'server', -- executable: launch the remote debug adapter - server: connect to an already running debug adapter
  --  command = os.getenv('HOME') .. '/.virtualenvs/tools/bin/python', -- command to launch the debug adapter - used only on executable type
  --  args = { '-m', 'debugpy.adapter' }, -- arguments to the command to launch the debug adapter
  host = '127.0.0.1',
  port = 8080,
}
dap.configurations.java_remote = {
  {
    type = 'java',
    request = 'attach',
    name = "Debug (Attach) - Remote",
    hostName = "127.0.0.1",
    port = 5005,
  }
}
dap.configurations.java_test = {
  {
    --  name = string.format("Debug (Launch %d) - %s - %s", index, project_name, main_class),
    --  projectName = project_name,
    type = 'java',
    request = 'launch',
    --  javaExec = "/home/stephane/.asdf/shims/java",
    modulePaths = {},
    --  classPaths = vim.tbl_flatten(class_paths),
  }
}


dap.adapters.php = {
  type = 'executable',
  command = 'node',
  args = { '/path/to/vscode-php-debug/out/phpDebug.js' },
}
dap.configurations.php = {
  {
    type = 'php',
    request = 'launch',
    name = 'Listen for Xdebug',
    port = 9000,
  }
}

local status_ok, dapui = pcall(require, "dapui")
if not status_ok then
  return
end
