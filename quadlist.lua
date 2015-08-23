--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  quadlist.lua
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-06-04 02:39:33
-- :ddddddddddhyyddddddddddd: Modified: 2015-08-23 03:16:59
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

local quadlist = {}

function quadlist.new(tileset)
	local i = 0
	local j = 0

	tileset[0] = tileset.image
	while j < tileset[0]:getHeight() do
		i = 0
		while i < tileset[0]:getWidth() do
			table.insert(tileset,
				love.graphics.newQuad(i, j, tileset.width, tileset.height,
					tileset[0]:getWidth(), tileset[0]:getHeight()))
			i = i + tileset.width
		end
		j = j + tileset.height
	end
	return tileset
end

return quadlist
