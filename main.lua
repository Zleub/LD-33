--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  main.lua
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-08-22 01:00:10
-- :ddddddddddhyyddddddddddd: Modified: 2015-08-22 06:37:42
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

inspect = require 'inspect'
lib = require 'lib'
color = require 'color'
collision = require 'collision'
level = require 'level'
pnj = require 'pnj'
state = require 'state'

function love.debug(...)
	print(inspect({...}))
end

function love.load()
	-- vertices = {
	-- 	{100, 100},
	-- 	{200, 100},
	-- 	{100, 200}
	-- }

	fonts = {}
	fonts.regular = love.graphics.newFont('Raleway/Regular.ttf', 24)
	love.graphics.setFont(fonts.regular)
	state.setcurrent('menu')
end

function love.keypressed(key, rep)
	state[state.current]:keypressed(key, rep)
end

function love.update(dt)
	-- local x, y = 100, 100
	-- dist = (x*x) + (y*y);
	-- angle = math.atan(math.abs(x) / math.abs(y));
	-- angle = angle + dt;

	-- for i,v in ipairs(vertices) do
	-- 	v[1] = math.sin(angle*math.pi/180);
	-- 	v[2] = math.cos(angle*math.pi/180);
	-- end

	state[state.current]:update(dt)
end

function love.draw()
	state[state.current]:draw()

	-- local _v = {}
	-- for i,v in ipairs(vertices) do
	-- 	for i, k in ipairs(v) do
	-- 		table.insert(_v, k)
	-- 	end
	-- end
	-- love.graphics.polygon("line", unpack(_v))
end
