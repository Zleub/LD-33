--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  pnj.lua
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-08-22 03:49:20
-- :ddddddddddhyyddddddddddd: Modified: 2015-08-22 06:07:44
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

		local t = copy(params)
		t.draw = function (self)
			love.graphics.circle("line", self.x, self.y, self.radius)
		end
		return table.insert(self.queue, t)
	end
	t.update = function (self, dt)
		for i,v in ipairs(self.queue) do
			v:update(dt)
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
