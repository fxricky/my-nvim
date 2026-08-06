-- Directories to hide from pickers while still showing dotfiles/gitignored files.
-- (node_modules/.pnpm is covered by excluding node_modules itself.)
local prune = { "node_modules" }

-- The `files` source picks a backend: fd > rg > find (snacks/picker/source/files.lua).
-- fd and rg match a bare directory name at any depth, but the `find` fallback emits
-- `-not -path <pattern>`, which is compared against the WHOLE path -- so a bare
-- "node_modules" silently matches nothing there and must be "*/node_modules/*".
-- Detect the backend so pulling this config onto a machine without fd/rg installed
-- doesn't quietly stop excluding. Run `:LazyHealth` to check for missing tools.
local fast_finder = vim.fn.executable("fd") == 1 or vim.fn.executable("fdfind") == 1 or vim.fn.executable("rg") == 1

local files_exclude = vim.tbl_map(function(dir)
  return fast_finder and dir or ("*/" .. dir .. "/*")
end, prune)

return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          files = {
            hidden = true,
            -- NOTE: `ignored` only applies to fd/rg. The `find` fallback never reads
            -- .gitignore, so without fd/rg installed everything shows regardless.
            ignored = true,
            exclude = files_exclude,
          },
          -- grep always shells out to rg, which takes the bare name.
          grep = {
            hidden = true,
            ignored = true,
            exclude = prune,
          },
          -- explorer matches globs against the full path via Snacks.picker.util.globber,
          -- which is unanchored, so the bare name works here too.
          explorer = {
            hidden = true,
            ignored = true,
            exclude = prune,
          },
        },
      },
    },
  },
}
