--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  lib.lua
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-08-22 05:48:20
-- :ddddddddddhyyddddddddddd: Modified: 2015-08-23 05:23:17
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
		-- love.graphics.setBlendMode('alpha')
		local i, j = 0, 0
		while i < width do
			j = 0
			while j < height do
				love.graphics.setColor(0, love.math.random(128, 200), 0, 255)
				love.graphics.rectangle('fill', i, j, 8, 8)
				j = j + 8
			end
			i = i + 8
		end
	love.graphics.setCanvas()
	return canvas
end
