-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(function(bufnr) require("astronvim.utils.buffer").close(bufnr) end)
      end,
      desc = "Pick to close",
    },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },
    ["<leader>x"] = { name = "Clangd" },
    ["<leader>xs"] = {
      function()
        require("clangd_extensions.switch_source_header").switch_source_header()
      end,
      desc = "Switch Source/Header",
    },
    ["<leader>xl"] = {
      function()
        require("clangd_extensions.inlay_hints").toggle_inlay_hints()
      end,
      desc = "Toggle Inlay Hints",
    },
    ["<leader>xa"] = {
      function()
        require("clangd_extensions.ast").display_ast(vim.api.nvim_win_get_cursor(0)[1], unpack(vim.api.nvim_win_get_cursor(0)))
      end,
      desc = "Display AST",
    },
    ["<leader>xi"] = {
      function()
        require("clangd_extensions.symbol_info").show_symbol_info()
      end,
      desc = "Symbol Info",
    },
    ["<leader>xh"] = {
      function()
        require("clangd_extensions.type_hierarchy").show_hierarchy()
      end,
      desc = "Type Hierarchy",
    },
    ["<leader>xm"] = {
      function()
        require("clangd_extensions.memory_usage").show_memory_usage()
      end,
      desc = "Memory Usage",
    },
    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
    ["<leader>fp"] = {
      function()
        require('telescope').extensions.neoclip.default()
      end,
      desc = "Find paste history"
    },
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
}
