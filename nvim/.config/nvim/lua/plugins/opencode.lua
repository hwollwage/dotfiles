return {
  "sudo-tee/opencode.nvim",
  dependencies = {
    "MeanderingProgrammer/render-markdown.nvim",
  },
  config = function()
    require("opencode").setup({})
  end,
}
