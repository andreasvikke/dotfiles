return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      size = 20,
      open_mapping = false, -- disable default mapping
      direction = "float",
    },
    keys = {
      { "<leader>t", "<cmd>ToggleTerm<cr>", mode = "n", desc = "Toggle terminal" },
      { "<Esc>",     [[<C-\><C-n>]],        mode = "t", desc = "Exit terminal mode" },
    },
  },
}
