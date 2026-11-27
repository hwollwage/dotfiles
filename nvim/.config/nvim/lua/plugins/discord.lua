return {
  "vyfor/cord.nvim",
  build = ":Cord update",
  opts = {
    hooks = {
      post_activity = function(opts, activity)
        activity.assets.small_text = "go fuck yourself"
      end,
    },
    display = {
      theme = "atom",
      flavor = "dark",
    },
  },
}
