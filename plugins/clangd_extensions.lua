return {
  {
    "p00f/clangd_extensions.nvim", -- install lsp plugin
    init = function()
      -- load clangd extensions when clangd attaches
      local augroup = vim.api.nvim_create_augroup("clangd_extensions", { clear = true })
      vim.api.nvim_create_autocmd("LspAttach", {
        group = augroup,
        desc = "Load clangd_extensions with clangd",
        callback = function(args)
          if assert(vim.lsp.get_client_by_id(args.data.client_id)).name == "clangd" then
            require("clangd_extensions").setup({
              inlay_hints = {
                  inline = vim.fn.has("nvim-0.10") == 1,
                  -- Options other than `highlight' and `priority' only work
                  -- if `inline' is disabled
                  -- Only show inlay hints for the current line
                  only_current_line = false,
                  -- Event which triggers a refresh of the inlay hints.
                  -- You can make this { "CursorMoved" } or { "CursorMoved,CursorMovedI" } but
                  -- not that this may cause  higher CPU usage.
                  -- This option is only respected when only_current_line and
                  -- autoSetHints both are true.
                  only_current_line_autocmd = { "CursorHold" },
                  -- whether to show parameter hints with the inlay hints or not
                  show_parameter_hints = true,
                  -- prefix for parameter hints
                  parameter_hints_prefix = "<- ",
                  -- prefix for all the other hints (type, chaining)
                  other_hints_prefix = "=> ",
                  -- whether to align to the length of the longest line in the file
                  max_len_align = false,
                  -- padding from the left if max_len_align is true
                  max_len_align_padding = 1,
                  -- whether to align to the extreme right or not
                  right_align = false,
                  -- padding from the right if right_align is true
                  right_align_padding = 7,
                  -- The color of the hints
                  highlight = "Comment",
                  -- The highlight group priority for extmark
                  priority = 100,
              },
              ast = {
                  -- These are unicode, should be available in any font
                  role_icons = {
                      type = "🄣",
                      declaration = "🄓",
                      expression = "🄔",
                      statement = ";",
                      specifier = "🄢",
                      ["template argument"] = "🆃",
                  },
                  kind_icons = {
                      Compound = "🄲",
                      Recovery = "🅁",
                      TranslationUnit = "🅄",
                      PackExpansion = "🄿",
                      TemplateTypeParm = "🅃",
                      TemplateTemplateParm = "🅃",
                      TemplateParamObject = "🅃",
                  },
                  --[[ These require codicons (https://github.com/microsoft/vscode-codicons)
                      role_icons = {
                          type = "",
                          declaration = "",
                          expression = "",
                          specifier = "",
                          statement = "",
                          ["template argument"] = "",
                      },

                      kind_icons = {
                          Compound = "",
                          Recovery = "",
                          TranslationUnit = "",
                          PackExpansion = "",
                          TemplateTypeParm = "",
                          TemplateTemplateParm = "",
                          TemplateParamObject = "",
                      }, ]]

                  highlights = {
                      detail = "Comment",
                  },
              },
              memory_usage = {
                  border = "single",
              },
              symbol_info = {
                  border = "single",
              },
            })
            -- add more `clangd` setup here as needed such as loading autocmds
            require("clangd_extensions.inlay_hints").setup_autocmd()
            require("clangd_extensions.inlay_hints").set_inlay_hints()
            vim.api.nvim_del_augroup_by_id(augroup) -- delete auto command since it only needs to happen once
          end
        end,
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "setup clangd_extensions on clangd attach",
        callback = function(args)
          if assert(vim.lsp.get_client_by_id(args.data.client_id)).name == "clangd" then
            require("clangd_extensions.inlay_hints").setup_autocmd()
            require("clangd_extensions.inlay_hints").set_inlay_hints()
          end
        end,
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "clangd" }, -- automatically install lsp
    },
  },
}
