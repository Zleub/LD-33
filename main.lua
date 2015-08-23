--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  main.lua
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-08-22 01:00:10
-- :ddddddddddhyyddddddddddd: Modified: 2015-08-23 05:20:54
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

inspect = require 'inspect'
lib = require 'lib'
color = require 'color'
quadlist = require 'quadlist'
collision = require 'collision'
level = require 'level'
pnj = require 'pnj'
state = require 'state'

function setupSpriteBatch(spriteBatch, image, scale)
	spriteBatch:clear()
	local maxX = math.ceil(love.window.getWidth()  / image:getWidth())  + 2
	local maxY = math.ceil(love.window.getHeight() / image:getHeight()) + 2

	print(maxX, maxY)

	for y = 0, maxY do
		for x = 0, maxX do
			local xPos = x * image:getWidth() * scale
			local yPos = y * image:getHeight() * scale

			spriteBatch:add(xPos, yPos, 0, scale, scale)
		end
	end
	return spriteBatch
end

function love.debug(...)
	print(inspect({...}))
end

function love.load()
	player_image = love.graphics.newImage('Entity.png')
	player_image:setFilter('nearest')

	floor_image = love.graphics.newImage('const.jpg')
	floor_image:setFilter('nearest')

	canvas = love.graphics.newCanvas(640, 480)
	love.graphics.setCanvas(canvas)
		canvas:clear()
		-- love.graphics.setBlendMode('alpha')
		local i, j = 0, 0
		while i < love.window.getWidth() do
			j = 0
			while j < love.window.getHeight() do
				love.graphics.setColor(0, love.math.random(128, 200), 0, 255)
				love.graphics.rectangle('fill', i, j, 8, 8)
				j = j + 8
			end
			i = i + 8
		end
	love.graphics.setCanvas()

	fonts = {}
	fonts.regular = love.graphics.newFont('Raleway/Regular.ttf', 24)
	love.graphics.setFont(fonts.regular)
	state.setcurrent('menu')
end

function love.keypressed(key, rep)
	state[state.current]:keypressed(key, rep)
end

rotation = 0

function love.update(dt)
	state[state.current]:update(dt)
end

shader = love.graphics.newShader[[
	vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coord)
	{
		vec4 t_color = Texel(texture, texture_coords);

		t_color.r = 1 - t_color.r;
		t_color.g = 1 - t_color.g;
		t_color.b = 1 - t_color.b;
		return color * t_color;
	}
]]

function love.draw()
	-- love.graphics.rectangle("fill", 0, 0, love.window.getDimensions())
	-- love.graphics.setShader(shader)
	state[state.current]:draw()
	-- love.graphics.draw(canvas)
	-- love.graphics.setShader()
end
