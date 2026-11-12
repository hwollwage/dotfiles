return {
  "r-pletnev/pdfreader.nvim",
  dependencies = {
    "folke/snacks.nvim",
    "nvim-telescope/telescope.nvim",
  },
  ft = "pdf",
  config = function()
    require("pdfreader").setup()
  end,
}
