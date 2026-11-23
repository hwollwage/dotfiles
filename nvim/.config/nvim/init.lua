require("config.lazy")

require("lspconfig").lua_ls.setup({
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim", "hl" },
      },
    },
  },
})
