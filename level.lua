--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  level.lua
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-08-22 03:52:18
-- :ddddddddddhyyddddddddddd: Modified: 2015-08-22 05:07:18
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

local level = {}

level.new = function ()
	local t = {}

	t.queue = {}
	t.add = function (self, params)
		if type(params) ~= 'table' then print('level.add need a table') love.event.quit() end

		if params.x and params.y and params.width and params.height then
			return table.insert(self.queue, {
				type = 'rectangle',
				x = params.x,
				y = params.y,
				width = params.width,
				height = params.height,

				draw = function (self)
					love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
				end
			})
		elseif params.x and params.y and params.radius then
			return table.insert(self.queue, {
				type = 'circle',
				x = params.x,
				y = params.y,
				radius = params.radius,

				draw = function (self)
					love.graphics.circle("line", self.x, self.y, self.radius)
				end
			})
		end
	end
	t.collides = function (self, entity)
		local bool = false
		for i,v in ipairs(self.queue) do
			if v.type == 'circle' then
				bool = bool or CircleinCircle(entity, v)
			elseif v.type == 'rectangle' then
				bool = bool or (PointinRectangle(entity, v) or RectangleinCircle(v, entity))
			end
		end
		return bool
	end
	t.move = function (self, x, y)
		for i,v in ipairs(self.queue) do
			v.x = v.x + x
			v.y = v.y + y
		end
	end
	t.draw = function (self)
		for i,v in ipairs(self.queue) do
			v:draw()
		end
	end

	return t
end

return level
