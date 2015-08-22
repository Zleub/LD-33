--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  main.lua
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-08-22 01:00:10
-- :ddddddddddhyyddddddddddd: Modified: 2015-08-22 04:32:27
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

inspect = require 'inspect'
color = require 'color'
collision = require 'collision'
level = require 'level'
state = require 'state'

function love.debug(...)
	print(inspect({...}))
end

function love.load()
	fonts = {}
	fonts.regular = love.graphics.newFont('Raleway/Regular.ttf', 24)
	love.graphics.setFont(fonts.regular)
	state.setcurrent('menu')
end

function love.keypressed(key, rep)
	state[state.current]:keypressed(key, rep)
end

function love.update(dt)
	state[state.current]:update(dt)
end

function love.draw()
	state[state.current]:draw()
end
