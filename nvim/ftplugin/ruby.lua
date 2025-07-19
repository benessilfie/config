-- Ruby file-specific configuration

-- Only add Ruby-specific keymaps and commands when Ruby LSP is attached
vim.api.nvim_create_autocmd('LspAttach', {
  buffer = vim.api.nvim_get_current_buf(),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if not client or client.name ~= 'ruby_lsp' then
      return
    end

    local bufnr = event.buf

    -- Add Ruby dependencies command
    vim.api.nvim_buf_create_user_command(bufnr, 'ShowRubyDeps', function(opts)
      local params = vim.lsp.util.make_text_document_params()
      local showAll = opts.args == 'all'

      client.request('rubyLsp/workspace/dependencies', params, function(error, result)
        if error then
          print('Error showing deps: ' .. error)
          return
        end

        local qf_list = {}
        for _, item in ipairs(result) do
          if showAll or item.dependency then
            table.insert(qf_list, {
              text = string.format('%s (%s) - %s', item.name, item.version, item.dependency),
              filename = item.path,
            })
          end
        end

        vim.fn.setqflist(qf_list)
        vim.cmd 'copen'
      end, bufnr)
    end, {
      nargs = '?',
      complete = function()
        return { 'all' }
      end,
    })

    -- Ruby-specific keymaps
    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = bufnr, desc = 'Ruby: ' .. desc })
    end

    map('<leader>Rd', '<cmd>ShowRubyDeps<cr>', 'Show Dependencies')
    map('<leader>Ra', '<cmd>ShowRubyDeps all<cr>', 'Show All Dependencies')
  end,
})
