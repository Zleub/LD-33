--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  main.lua
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-08-22 01:00:10
-- :ddddddddddhyyddddddddddd: Modified: 2015-08-22 09:24:44
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
	vertices = {
		{300, 300},
		{400, 300},
		{300, 400}
	}

	-- fonts = {}
	-- fonts.regular = love.graphics.newFont('Raleway/Regular.ttf', 24)
	-- love.graphics.setFont(fonts.regular)
	-- state.setcurrent('menu')
end

function love.keypressed(key, rep)
	-- state[state.current]:keypressed(key, rep)
end

rotation = 0

function love.update(dt)
	-- state[state.current]:update(dt)
	rotation = rotation + dt

	caca = {}
	for i,v in ipairs(vertices) do
		caca[i] = {}
		local x, y = v[1] - vertices[1][1], v[2] - vertices[1][2]
		table.insert(caca[i], x * math.cos(rotation) - y * math.sin(rotation))
		table.insert(caca[i], y * math.cos(rotation) +  x * math.sin(rotation))
	end
end

function love.draw()
	-- state[state.current]:draw()

	local _v = {}
	for i,v in ipairs(vertices) do
		for i, k in ipairs(v) do
			table.insert(_v, k)
		end
	end
	local _c = {}
	for i,v in ipairs(caca) do
		for i, k in ipairs(v) do
			table.insert(_c, k)
		end
	end
	love.graphics.push()
	love.graphics.translate(300, 300)
	love.graphics.rotate(rotation)
	love.graphics.translate(-300, -300)
	love.graphics.polygon("line", unpack(_v))
	love.graphics.pop()

	love.graphics.print(rotation)
	love.graphics.print(inspect(vertices), 0, 24)
	love.graphics.print(inspect(caca), 0, 84)
	love.graphics.circle('line', 300, 300, 60)
	love.graphics.polygon("line", unpack(_v))
	love.graphics.polygon("line", unpack(_c))
end
