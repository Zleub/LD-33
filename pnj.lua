--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  pnj.lua
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-08-22 03:49:20
-- :ddddddddddhyyddddddddddd: Modified: 2015-08-23 04:23:37
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

local pnj = {}

pnj.new = function ()
	local t = {}

	t.queue = {}
	t.add = function (self, params)
		if type(params) ~= 'table'then print('pnj.add need a table') love.event.quit() end

		return table.insert(self.queue, copy(params))
	end
	t.update = function (self, dt)
		for i,v in ipairs(self.queue) do
			v:update(dt)
		end
	end
	t.collides = function (self, entity)
		for i,v in ipairs(self.queue) do
			if v.rotated_vertices then
				local shape = love.physics.newPolygonShape(unpack(v.rotated_vertices))

				if shape:testPoint(0,0, 0, entity.x, entity.y) then
					v.caca = 'caca'
				else
					v.caca = ''
				end

			end
		end
	end
	t.move = function (self, x, y)
		for i,v in ipairs(self.queue) do
			for j,_v in ipairs(v.path) do
				_v.x = _v.x + x
				_v.y = _v.y + y
			end
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

return pnj
