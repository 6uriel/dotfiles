return {
  'saghen/blink.cmp',
  -- optional: provides snippets for the snippet source
  dependencies = { 'rafamadriz/friendly-snippets' },

  -- use a release tag to download pre-built binaries
  version = '1.*',
  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = {
      ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      ["<CR>"] = { "select_and_accept", "fallback" },
      ["<C-e>"] = { "hide", "fallback" },
    },

    appearance = {
      nerd_font_variant = 'mono'
    },
    signature = {
      enabled = false,
      window = {
        show_documentation = true,
      }
    },
    fuzzy = { implementation = "prefer_rust" },

    completion = {
      trigger = {
        show_on_insert_on_trigger_character = false,
        show_on_accept_on_trigger_character = false,
        show_on_blocked_trigger_characters = { "{", "(", ")", "}" },
      },
      documentation = { auto_show = true, auto_show_delay_ms = 0 },
      menu = {
        auto_show = true,
        scrollbar = false,
        draw = {
          columns = {
            { "kind_icon" },
            { "label",        "label_description", gap = 1 },
            { "kind",         gap = 1 },
            { "source_name",  gap = 1 },
          },
          components = {
            kind_icon = {
              ellipsis = false,
              width = { fill = true },
              text = function(ctx)
                local kind_icons = {
                  Function = "λ",
                  Method = "∂",
                  Field = "󰀫",
                  Variable = "󰀫",
                  Property = "󰀫",
                  Keyword = "k",
                  Struct = "Π",
                  Enum = "τ",
                  EnumMember = "τ",
                  Snippet = "⊂",
                  Text = "τ",
                  Module = "⌠",
                  Constructor = "∑",
                }

                local icon = kind_icons[ctx.kind]
                if icon == nil then
                  icon = ctx.kind_icon
                end
                return icon
              end,
            },
          },
        },
      },

    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer'},
      per_filetype = {
        typst = { "lsp", "buffer" },
        markdown = { "lsp", "buffer" },
      },
    },
  },
}
