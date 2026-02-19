return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  dependencies = {
    "copilotlsp-nvim/copilot-lsp",
  },
  config = function()
    require("copilot").setup({
      -- optional: turn on logging while debugging
      logger = {
        file = vim.fn.stdpath("log") .. "/copilot-lua.log",
        file_log_level = vim.log.levels.TRACE,
        print_log_level = vim.log.levels.WARN,
        trace_lsp = "verbose",
        trace_lsp_progress = true,
        log_lsp_messages = true,
      },
    })
  end,
}

