local function configureDap()
  local status_ok, dap = pcall(require, "dap")
  if not status_ok then
    print("The dap extension could not be loaded")
    return
  end

  dap.set_log_level("DEBUG")

  vim.highlight.create('DapBreakpoint', { ctermbg = 0, guifg = '#993939', guibg = '#31353f' }, false)
  vim.highlight.create('DapLogPoint', { ctermbg = 0, guifg = '#61afef', guibg = '#31353f' }, false)
  vim.highlight.create('DapStopped', { ctermbg = 0, guifg = '#98c379', guibg = '#31353f' }, false)

  vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint',
    numhl = 'DapBreakpoint' })
  vim.fn.sign_define('DapBreakpointCondition',
    { text = 'ﳁ', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
  vim.fn.sign_define('DapBreakpointRejected',
    { text = '', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
  vim.fn.sign_define('DapLogPoint', { text = '', texthl = 'DapLogPoint', linehl = 'DapLogPoint', numhl = 'DapLogPoint' })
  vim.fn.sign_define('DapStopped', { text = '', texthl = 'DapStopped', linehl = 'DapStopped', numhl = 'DapStopped' })

  return dap
end

local function configureUI(dap)
  local status_ok, dapui = pcall(require, "dapui")
  if not status_ok then
    print("The dap-ui extension could not be loaded")
    return
  end

  dapui.setup {
  }

  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
  end
end

local function configureExtensions()
  local status_vt_ok, dap_virtual_text = pcall(require, "nvim-dap-virtual-text")
  if not status_vt_ok then
    print("The dap-virtual-text extension could not be loaded")
    return
  end

  dap_virtual_text.setup {
  }
end

local function configureDebuggerAngular(dap)
  dap.adapters.chrome = {
    -- executable: launch the remote debug adapter - server: connect to an already running debug adapter
    type = "executable",
    -- command to launch the debug adapter - used only on executable type
    command = "node",
    args = { os.getenv("HOME") .. "/.local/share/nvim/lsp-debuggers/vscode-chrome-debug/out/src/chromeDebug.js" }
  }
  -- The configuration must be named: typescript
  dap.configurations.typescript = {
    {
      name = "Debug (Attach) - Remote",
      type = "chrome",
      request = "attach",
      -- program = "${file}",
      -- cwd = vim.fn.getcwd(),
      sourceMaps = true,
      --      reAttach = true,
      trace = true,
      -- protocol = "inspector",
      -- hostName = "127.0.0.1",
      port = 9222,
      webRoot = "${workspaceFolder}"
    }
  }
end

local function configureDebuggerJava(dap)
  dap.adapters.java = {
    type = "executable",
    command = "java",
    args = { "-jar",
      os.getenv("HOME") .. "/.local/share/nvim/lsp-debuggers/jdtls/com.microsoft.java.debug.plugin-0.37.0.jar" }
  }
  -- The configuration must be named: java
  dap.configurations.java = {
    {
      name = "Debug (Attach) - Remote",
      type = "java",
      request = "attach",
      hostName = "127.0.0.1",
      port = 5005,
    }
  }

  --[[ TODO some Java test config to fix some day
  dap.configurations.java_test = {
    {
      --  name = string.format("Debug (Launch %d) - %s - %s", index, project_name, main_class),
      --  projectName = project_name,
      type = "java",
      request = "launch",
      --  javaExec = "/home/stephane/.asdf/shims/java",
      modulePaths = {},
      --  classPaths = vim.tbl_flatten(class_paths),
    }
  }
  --]]
end

--[[ TODO some config
dap.adapters.node2 = function(cb, config)
  local cb_input = {
    type = ‘executable’;
    command = ‘/usr/bin/node’;
    args = { os.getenv(‘HOME’) .. ‘/.local/share/nvim/dapinstall/jsnode/vscode-node-debug2/out/src/nodeDebug.js’ };
  };
  if config.request == ‘attach’ and config.mode == ‘remote’ then
    local _, port = start_devenv_debug_session()
    cb_input.enrich_config = function(config, on_config)
      local f_config = vim.deepcopy(config)
      f_config.port = tonumber(port)
      on_config(f_config)
    end;
  elseif config.mode == ‘test’ then
    if config.request == ‘attach’ then
      local _, port = start_devenv_debug_session();
      local host = get_devenv_host();
      vim.fn.input(‘\n[Optional] test filter: ‘);
      vim.fn.system({batch_mocha_script});
      cb_input.enrich_config = function(config, on_config)
        local f_config = vim.deepcopy(config)
        f_config.port = tonumber(port)
        f_config.host = host;
        on_config(f_config)
      end;
    elseif config.request == ‘launch’ then
      cb_input.enrich_config = function(config, on_config)
        local f_config = vim.deepcopy(config)
        local grepFilter = vim.fn.input(‘\n[Optional] test filter: ‘);
        if grepFilter ~= ‘’ then
          table.insert(f_config.args, 1, string.format(“—grep=%s”, grepFilter));
        end
        print(utils.debug_print(f_config));
        on_config(f_config);
      end;
    end
  end
  cb(cb_input);
  program = ‘’
end

dap.configurations.typescript = {
  {
    type = ‘node2’;
    request = ‘launch’;
    program = ‘${workspaceFolder}/node_modules/jest/bin/jest.js’;
    args = {
      “—verbose”,
      “—runInBand”,
      “—forceExit”,
      “—config”,
      “jest-unit.config.json”,
      “${file}”
      };
    cwd = vim.fn.getcwd();
    sourceMaps = true;
    restart = true;
    protocol = ‘inspector’;
    console = ‘integratedTerminal’;
  },
}
--]]


local function configure()
  local dap = configureDap()

  if nil == dap then
    print("The DAP core debugger could not be set")
  end

  configureDebuggerAngular(dap)
  configureDebuggerJava(dap)
  configureExtensions()
  configureUI(dap)
end

configure()
