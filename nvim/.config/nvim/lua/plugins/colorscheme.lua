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
        custom_highlights = function(colors)
          return {
            WinSeparator = { fg = "#F5A9B8", style = { "bold" } },
          }
        end,
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
