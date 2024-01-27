local openTerminal = function(command)
  local Terminal  = require('toggleterm.terminal').Terminal
  local term = Terminal:new({
      cmd = command,
      direction = 'horizontal'
  })
  term:toggle()
end

local path = vim.fn.getcwd() .. '/.compile'

local run = function()
  local file_exists = os.rename(path, path)
  
  if file_exists then
    openTerminal(
      'echo "Directory: $(pwd)"; echo "Compilation started at $(date +"%H:%M:%S")"; echo; '
      .. 'bash ' .. path ..
      '; echo; echo "Compilation finished at $(date +"%H:%M:%S")"; read'
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
  run()
end)
