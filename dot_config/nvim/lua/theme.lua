local config_path = vim.fn.stdpath("config") .. "/lua/etc/colorscheme.txt"

-- persist colorscheme choice across restarts
local function save_colorscheme(name)
  local f = io.open(config_path, "w")
  if f then
    f:write(name)
    f:close()
  end
end

local function load_colorscheme()
  local f = io.open(config_path, "r")
  if f then
    local name = f:read("*l")
    f:close()
    if name and name ~= "" then
      pcall(vim.cmd, "colorscheme " .. name)
      return
    end
  end
  pcall(vim.cmd, "colorscheme vague")
end

load_colorscheme()

vim.keymap.set("n", "<leader>cs", function()
  require("telescope.builtin").colorscheme({
    enable_preview = true,
    attach_mappings = function(_, map)
      map("i", "<CR>", function(prompt_bufnr)
        local entry = require("telescope.actions.state").get_selected_entry()
        require("telescope.actions").close(prompt_bufnr)
        save_colorscheme(entry.value)
        vim.cmd("colorscheme " .. entry.value)
      end)
      return true
    end,
  })
end, { desc = "Pick colorscheme", noremap = true, silent = true })

-- dashboard
local splash_buf

local function splash()
  if vim.fn.argc() > 0 then
    return
  end

  local art = {
    "   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          ",
    "    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ",
    "          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     ",
    "           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ",
    "          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ",
    "   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ",
    "  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ",
    " ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ",
    " ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ ",
    "      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ",
    "       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ",
  }

  vim.cmd("enew")
  local buf = vim.api.nvim_get_current_buf()

  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].swapfile = false
  vim.bo[buf].modifiable = true

  local width = vim.api.nvim_win_get_width(0)
  local height = vim.api.nvim_win_get_height(0)

  local lines = {}
  local top = math.max(math.floor((height - #art) / 2), 0)
  for _ = 1, top do
    table.insert(lines, "")
  end
  for _, line in ipairs(art) do
    local pad = math.max(math.floor((width - vim.fn.strdisplaywidth(line)) / 2), 0)
    table.insert(lines, string.rep(" ", pad) .. line)
  end

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false

  vim.opt_local.number = false
  vim.opt_local.relativenumber = false
  vim.opt_local.signcolumn = "no"
  vim.opt_local.foldcolumn = "0"
  vim.opt_local.cursorline = false
  vim.opt_local.list = false
  vim.opt_local.fillchars = { eob = " " }

  vim.api.nvim_win_set_cursor(0, { 1, 0 })
  splash_buf = buf
end

vim.api.nvim_create_autocmd("VimEnter", {
  callback = splash,
})

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    if splash_buf and vim.api.nvim_buf_is_valid(splash_buf) and vim.api.nvim_get_current_buf() ~= splash_buf then
      vim.api.nvim_buf_delete(splash_buf, { force = true })
      splash_buf = nil
    end
  end,
})
