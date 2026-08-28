require("relative-motions"):setup({ show_numbers="relative", show_motion = true, enter_mode ="first" })

require('fchar'):setup {
  insensitive = true,
  skip_symbols = true,
  skip_prefix = {},
  aliases = {},
  keys = {
    start = 'f',   --  ff -> file
    ext = 'e',     --  ef -> name.fs
    word = 'F',    --  Ff -> file, also-file
    all = '<C-f>', -- ^ff -> file, also-file, twofile, elf
  },
}
