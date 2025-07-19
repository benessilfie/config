return {
  'TobinPalmer/rayso.nvim',
  cmd = { 'Rayso' },
  config = function()
    require('rayso').setup {
      base_url = 'https://ray.so/',
      open_cmd = 'chromium',
      options = {
        background = true,
        dark_mode = true,
        logging_path = '',
        logging_file = 'rayso',
        logging_enabled = false,
        padding = 32,
        theme = 'crimson',
        title = 'Untitled',
      },
    }
    vim.keymap.set('v', '<leader>rs', require('lib.create').create_snippet)
  end,
}
