return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    image = {
      enabled = true,
      force = false,
      max_width = 80,
      max_height = 40,
      wo = {
        wrap = false,
        number = false,
        relativenumber = false,
        signcolumn = "no",
      },
    },
    explorer = {
      enabled = true,
    },
    picker = {
      icons = {
        git = {
          enabled = true,
          staged = "  S",
          added = "  A",
          deleted = "  D",
          ignored = "  ",
          modified = "  M",
          renamed = "  RN",
          unmerged = "  UM",
          untracked = "  U",
        },
      },
      sources = {
        files = {
          hidden = true,
          ignored = true,
        },
        explorer = {
          hidden = true,
          ignored = true,
        },
      },
    },
  },
}
