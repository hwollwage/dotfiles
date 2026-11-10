return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    image = {
      enabled = true,
    },
    explorer = {
      enabled = true,
    },
    picker = {
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
