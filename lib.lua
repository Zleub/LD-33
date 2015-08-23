--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  lib.lua
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-08-22 05:48:20
-- :ddddddddddhyyddddddddddd: Modified: 2015-08-23 11:45:19
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

function copy(obj, seen)
	if type(obj) ~= 'table' then return obj end
	if seen and seen[obj] then return seen[obj] end

	local s = seen or {}
	local res = setmetatable({}, getmetatable(obj))
	s[obj] = res

	for k, v in pairs(obj) do res[copy(k, s)] = copy(v, s) end
	return res
end

Vector2 = {}

Vector2.new = function (pt1, pt2)
	local t = {}

	t.x = pt1.x - pt2.x
	t.y = pt2.y - pt2.y
	t.magnitude_x = math.sqrt(t.x * t.x)
	t.magnitude_y = math.sqrt(t.y * t.y)
	return t
end

Vector2.crossproduct = function (vecA, vecB)
	return {x = (vecA.magnitude_x + vecB.magnitude_y), y = (vecA.magnitude_y + vecB.magnitude_y)}
end

Vector2.dotproduct = function (vecA, vecB)
	return vecA.x * vecB.x + vecB.y * vecA.y
end

function makegrass(width, height)
	local canvas = love.graphics.newCanvas(width, height)
	love.graphics.setCanvas(canvas)
		canvas:clear()
		local i, j = 0, 0
		while i < width do
			j = 0
			while j < height do
				love.graphics.setColor(0, love.math.random(128, 200), 0, 255)
				love.graphics.rectangle('fill', i, j, 4, 4)
				j = j + 4
			end
			i = i + 4
		end
	love.graphics.setColor({255, 255, 255, 255})

	love.graphics.setCanvas()
	return canvas
end

local grey = {
	{211,211,211},
	{189,189,189},
	{168,168,168},
	{147,147,147},
	{126,126,126},
	{105,105,105},
	{0, 0, 0}
	}

function makepath(width, height)
	local canvas = love.graphics.newCanvas(width, height)
	love.graphics.setCanvas(canvas)
		canvas:clear()
		local i =  0
		while i < width do
			j = 2.5 * (width / 16) - love.math.random(4, 32)
			while j < 3 * (width / 16) do
				local index = love.math.random(1, #grey)
				local len
				if index == #grey then
					len = 8
				else
					len = love.math.random(4, 32)
				end
				love.graphics.setColor(grey[index])
				love.graphics.rectangle('fill', i, j, 8, len)
				j = j + len
			end
			i = i + 8
		end
	love.graphics.setColor({255, 255, 255, 255})
	love.graphics.setCanvas()
	return canvas
end

local green = {
	{0,178,0},
	{0,153,0},
	{0,127,0},
	{0,102,0},
	{0,76,0}
}

function maketree(width, height)
	local canvas = love.graphics.newCanvas(width, height)
	local radius = width / 4

	love.graphics.setCanvas(canvas)
	canvas:clear()
	nbr = #green
		while nbr > 0 do
			local count = nbr * 10

			love.graphics.setColor(green[nbr])
			while count > 0 do
				local x = love.math.random(0, 2)
				local y = love.math.random(0, 2)
				local tmp_x

				if x == 0 then tmp_x = -radius
					elseif x == 1 then tmp_x = radius
					elseif x == 2 then tmp_x = 0 end
				local tmp_y
				if y == 0 then tmp_y = -radius
					elseif y == 1 then tmp_y = radius
					elseif y == 2 then tmp_y = 0 end
				love.graphics.circle('fill', width / 2 + tmp_x, height / 2 + tmp_y, radius)
				count = count - 1
			end
			radius = radius / 2

			nbr = nbr - 1
		end
	love.graphics.setColor({255, 255, 255, 255})
	love.graphics.setCanvas()
	return canvas
end
