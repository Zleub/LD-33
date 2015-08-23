--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  collision.lua
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-08-22 04:08:29
-- :ddddddddddhyyddddddddddd: Modified: 2015-08-23 01:48:58
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

local grain = 100

function CircleinCircle(circle1, circle2)
	return (circle2.x - circle1.x)^2 + (circle2.y - circle1.y)^2 <= (circle2.radius + circle1.radius)^2
end

function PointinRectangle(point, rectangle)
	return (
		(point.x >= rectangle.x and point.x <= rectangle.x + rectangle.width) and
		(point.y >= rectangle.y and point.y <= rectangle.y + rectangle.height)
		)
end

function RectangleinCircle(rectangle, circle)
	local x_coef = rectangle.width / grain
	local y_coef = rectangle.height / grain

	local x,y = rectangle.x, rectangle.y
	while x ~= rectangle.x + rectangle.width do
		if CircleinCircle({x=x, y=y, radius=1}, circle) then
			return true
		end
		x = x + x_coef
	end
	local x,y = rectangle.x, rectangle.y + rectangle.height
	while x ~= rectangle.x + rectangle.width do
		if CircleinCircle({x=x, y=y, radius=1}, circle) then
			return true
		end
		x = x + x_coef
	end
	local x,y = rectangle.x, rectangle.y
	while y ~= rectangle.y + rectangle.width do
		if CircleinCircle({x=x, y=y, radius=1}, circle) then
			return true
		end
		y = y + y_coef
	end
	local x,y = rectangle.x + rectangle.width, rectangle.y
	while y ~= rectangle.y + rectangle.width do
		if CircleinCircle({x=x, y=y, radius=1}, circle) then
			return true
		end
		y = y + y_coef
	end
	return false
end

function SameSide(p1,p2, a,b)
	local vecA = Vector2.new(a, b)
	local vecB = Vector2.new(a, p1)
	local vecC = Vector2.new(a, p2)

	local cp1 = Vector2.crossproduct(vecA, vecB)
	local cp2 = Vector2.crossproduct(vecA, vecC)

	if Vector2.dotproduct(cp1, cp2) >= 0 then return true
	else return false end
end

function PointinTriangle(p, a, b, c)
	if SameSide(p,a, b,c) and SameSide(p,b, a,c)
		and SameSide(p,c, a,b) then return true
	else return false end
end
