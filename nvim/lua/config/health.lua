--[[
--
-- This file is not required for your own configuration,
-- but helps people determine if their system is setup correctly.
--
--]]

-- Health check utility functions that can be used elsewhere
local M = {}

-- Function to check if dependencies are installed (utility for other modules)
function M.check_dependencies()
  local dependencies = {
    'git',
    'make',
    'unzip',
    'curl',
  }

  local missing = {}
  for _, dep in ipairs(dependencies) do
    if vim.fn.executable(dep) == 0 then
      table.insert(missing, dep)
    end
  end

  if #missing > 0 then
    vim.notify('Missing dependencies: ' .. table.concat(missing, ', '), vim.log.levels.WARN)
    return false
  end

  return true
end

-- Check if Nerd Font is properly configured (utility for other modules)
function M.check_nerd_font()
  if vim.g.have_nerd_font then
    -- You could add actual nerd font detection here
    vim.notify('Nerd Font enabled', vim.log.levels.INFO)
  else
    vim.notify('Nerd Font disabled - using fallback icons', vim.log.levels.INFO)
  end
end

-- Health check functions for :checkhealth
local check_version = function()
  local verstr = tostring(vim.version())
  if not vim.version.ge then
    vim.health.error(string.format("Neovim out of date: '%s'. Upgrade to latest stable or nightly", verstr))
    return
  end

  if vim.version.ge(vim.version(), '0.10-dev') then
    vim.health.ok(string.format("Neovim version is: '%s'", verstr))
  else
    vim.health.error(string.format("Neovim out of date: '%s'. Upgrade to latest stable or nightly", verstr))
  end
end

local check_external_reqs = function()
  -- Basic utils: `git`, `make`, `unzip`
  for _, exe in ipairs { 'git', 'make', 'unzip', 'rg' } do
    local is_executable = vim.fn.executable(exe) == 1
    if is_executable then
      vim.health.ok(string.format("Found executable: '%s'", exe))
    else
      vim.health.warn(string.format("Could not find executable: '%s'", exe))
    end
  end

  return true
end

-- Check if Nerd Font is properly configured
local check_nerd_font_health = function()
  if vim.g.have_nerd_font then
    vim.health.ok('Nerd Font is enabled')
  else
    vim.health.info('Nerd Font is disabled - using fallback icons')
  end
end

-- Check plugin manager status
local check_lazy = function()
  local lazy_path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
  if vim.fn.isdirectory(lazy_path) == 1 then
    vim.health.ok('Lazy.nvim plugin manager is installed')
  else
    vim.health.error('Lazy.nvim plugin manager is not installed')
  end
end

-- Health check function for :checkhealth
function M.check()
  vim.health.start 'config.nvim'

  vim.health.info [[NOTE: Not every warning is a 'must-fix' in `:checkhealth`

Fix only warnings for plugins and languages you intend to use.
  Mason will give warnings for languages that are not installed.
  You do not need to install, unless you want to use those languages!]]

  local uv = vim.uv or vim.loop
  vim.health.info('System Information: ' .. vim.inspect(uv.os_uname()))

  check_version()
  check_external_reqs()
  check_nerd_font_health()
  check_lazy()
end

return M
