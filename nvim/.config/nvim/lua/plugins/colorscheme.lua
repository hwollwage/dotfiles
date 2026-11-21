return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "macchiato",
        color_overrides = {
          macchiato = {
            text = "#FFFFFF",
            blue = "#F5A9B8",
            sky = "#F5A9B8",
            surface2 = "#F5A9B8",
          },
        },
      })
    end,
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-macchiato",
    },
  },
}
