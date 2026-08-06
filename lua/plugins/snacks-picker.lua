return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          files = {
            hidden = true,
            ignored = true,
            exclude = { "node_modules" },
          },
          grep = {
            hidden = true,
            ignored = true,
            exclude = { "node_modules" },
          },
          explorer = {
            hidden = true,
            ignored = true,
            exclude = { "node_modules" },
          },
        },
      },
    },
  },
}
