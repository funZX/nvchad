local dap = require("dap")

dap.adapters.gdb = {
    name = 'gdb',
    type = 'executable',
    command = '/usr/bin/gdb', -- adjust as needed, must be absolute path
    args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
}

dap.adapters.lldb = {
    type = 'executable',
    command = '/usr/bin/lldb-dap', -- adjust as needed, must be absolute path
    name = 'lldb'
}

dap.configurations.cpp = {
    {
        name = 'Remote',
        type = 'gdb',
        request = 'attach',
        target = function()
          return vim.fn.input('Host: ') .. ':2000'
        end
    },
    {
        name = 'Attach',
        type = 'gdb',
        request = 'attach',
        pid = function()
          local name = vim.fn.input('Process filter: ')
          return require("dap.utils").pick_process({filter = name})
        end
    },
    {
        name = 'Launch',
        type = 'gdb',
        --type = 'lldb',
        request = 'launch',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        args = function()
            local args_str = vim.fn.input({
                prompt = 'Arguments: ',
            })
            return vim.split(args_str, ' :')
        end,
        cwd = '${workspaceFolder}',
        stopAtBeginningOfMainSubprogram = true,
    },
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
