return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    {
      "jay-babu/mason-nvim-dap.nvim",
      opts = {
        ensure_installed = { "codelldb", "python" },
        handlers = {},
      },
    },
  },
  keys = {
    { "<leader>xc", function() require("dap").continue() end, desc = "DAP Continue" },
    { "<leader>xo", function() require("dap").step_over() end, desc = "DAP Step Over" },
    { "<leader>xi", function() require("dap").step_into() end, desc = "DAP Step Into" },
    { "<leader>xO", function() require("dap").step_out() end, desc = "DAP Step Out" },
    { "<leader>xb", function() require("dap").toggle_breakpoint() end, desc = "DAP Toggle Breakpoint" },
    { "<leader>xB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "DAP Conditional Breakpoint" },
    { "<leader>xr", function() require("dap").repl.toggle() end, desc = "DAP Toggle REPL" },
    { "<leader>xl", function() require("dap").run_last() end, desc = "DAP Run Last" },
    { "<leader>xu", function() require("dapui").toggle() end, desc = "DAP Toggle UI" },
    { "<leader>xx", function() require("dap").terminate() end, desc = "DAP Terminate" },
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    dapui.setup({
      layouts = {
        {
          elements = {
            { id = "scopes", size = 0.5 },
            { id = "stacks", size = 0.5 },
          },
          size = 40,
          position = "right",
        },
      },
    })

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end
  end,
}
