-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  -- Language Packs
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.python" },
  -- nvim ui
  { import = "astrocommunity.editing-support.rainbow-delimiters-nvim" },
}
