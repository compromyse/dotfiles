local openTerminal = function(command)
  local Terminal  = require('toggleterm.terminal').Terminal
  local term = Terminal:new({
      cmd = command,
      direction = 'horizontal'
  })
  term:toggle()
end

local compilePath = vim.fn.getcwd() .. '/.compile'
local runPath = vim.fn.getcwd() .. '/.run'

local checkGetFileContent = function(path, typ)
  local file_exists = os.rename(path, path)
  
  if file_exists then
    openTerminal(
      'echo "Directory: $(pwd)"; echo "' .. typ .. ' started at $(date +"%H:%M:%S")"; echo; '
      .. 'bash ' .. path ..
      '; echo; echo "' .. typ .. ' finished at $(date +"%H:%M:%S")"; read'
    )
    return
  end

  local file = io.open(path, 'w')

  file:seek('set')
  file:write([[#!/bin/sh
set -xe
]]
  )
  file:close()
  print('Created ' .. path)
  return nil
end

vim.keymap.set('n', 'zz', function()
  checkGetFileContent(
    compilePath,
    'Compilation'
  )
end)
vim.keymap.set('n', 'zx', function()
  checkGetFileContent(
    runPath,
    'Run'
  )
end)
