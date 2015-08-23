--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  state_game.lua
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-08-23 01:08:14
-- :ddddddddddhyyddddddddddd: Modified: 2015-08-23 05:23:05
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

local state_start = {
	name = "game",

	rate = 200,
	keypressed = function (self, key, rep)
		-- print(self.name, key, rep)
		state.stdkeypressed(self, key, rep)
		-- if key == 'end' then
		-- 	self.level:add()
		-- end
	end,

	start = function (self)
		print(self.name, 'start')

		self.player = {
			rate = 3,
			quadsindex = 1,
			quads = quadlist.new({image = player_image, width = 32, height = 32}),
			x = love.window.getWidth() / 2,
			y = love.window.getHeight() / 2,
			radius = 10,
			time = 0,
			update = function (self, dt, rate)
				time = 0
				if love.keyboard.isDown('up', 'down', 'left', 'right', 'a', 's', 'd', 'w') then
					self.time = self.time + dt * self.rate
					self.quadsindex = (math.floor(self.time) % 2) + 2
				else
					self.quadsindex = 1
				end
				local mx,my = love.mouse.getPosition()
				self.rotation = math.atan2(self.y - my, self.x - mx) + 3 * math.pi / 2
			end,
			draw = function (self)
				love.graphics.draw(self.quads[0], self.quads[self.quadsindex], self.x, self.y, self.rotation, 2, 2, 16, 16)
			end
		}
		self.level = level.new()

		-- self.level:add({
		-- 	x = 0,
		-- 	y = 0,
		-- 	batch = setupSpriteBatch(love.graphics.newSpriteBatch(floor_image, 200), floor_image, 0.1)
		-- })
		self.level:add({
			x = 0,
			y = 0,
			canvas = makegrass(love.window.getWidth() * 2, love.window.getHeight() * 2)
		})

		self.level:add({
			x = 42,
			y = 21,
			width = 100,
			height = 100
		})
		self.level:add({
			x = 64,
			y = 48,
			radius = 50
		})

		self.pnj = pnj.new()
		self.pnj:add(dofile('stdpnj.lua'))
		local p = dofile('stdpnj.lua')
		p.x = 15
		p.y = 0
		p.path[1].x, p.path[1].y = 15, 0
		love.debug(p)
		self.pnj:add(p)
	end,
	update = function (self, dt)
		local movement = { x = 0, y = 0 }

		if love.keyboard.isDown('up', 'w') then
			movement.y = movement.y + dt * self.rate end
		if love.keyboard.isDown('down', 's') then
			movement.y = movement.y - dt * self.rate end
		if love.keyboard.isDown('left', 'a') then
			movement.x = movement.x + dt * self.rate end
		if love.keyboard.isDown('right', 'd') then
			movement.x = movement.x - dt * self.rate end


		self.player:update(dt)

		self.level:move(movement.x, movement.y)
		if self.level:collides(self.player) then
			self.level:move(-movement.x, -movement.y)
			movement.x = 0
			movement.y = 0
		end

		self.pnj:move(movement.x, movement.y)

		local ttt = { x = love.mouse.getX(), y = love.mouse.getY()}
		self.pnj:collides(self.player)
		self.pnj:update(dt)
	end,
	draw = function (self)
		self.level:draw()
		self.player:draw()
		love.graphics.setColor({0, 0, 0, 255})
		self.pnj:draw()
		love.graphics.setColor({255, 255, 255, 255})
	end,
	quit = function (self) print(self.name, 'quit') end
}

return state_start
