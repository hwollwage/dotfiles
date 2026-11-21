return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = function(_, opts)
      opts.file_types = { "opencode_output" } -- Paksa hanya aktif di opencode
    end,
  },
}
