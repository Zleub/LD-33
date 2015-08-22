--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  state.lua
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-08-22 01:17:13
-- :ddddddddddhyyddddddddddd: Modified: 2015-08-22 04:40:27
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

local state = {}

state.setcurrent = function (newstate)
	if state[state.current] then state[state.current]:quit() end
	if state[newstate] then
		state.current = newstate
	else
		print('no '..newstate..' newstate')
	end
	state[state.current]:start()
end

state.stdkeypressed = function (_state, key, rep)
	if key == 'return' then
		love.debug(_state)
	elseif key == 'escape' then
		love.event.quit()
	end
end

state.menu = {
	name = "menu",

	keypressed = function (self, key, rep)
		state.stdkeypressed(self, key, rep)
		if key == 'up' then self.count = self.count + 1
		elseif key == 'down' then self.count = self.count - 1
		elseif key == 'return' or key == 'space' then
			if self.count % 2 == 0 then
				state.setcurrent('game')
			elseif self.count % 2 == 1 then
				love.event.quit()
			end
		end
	end,

	start = function (self)
		self.count = 0
	end,
	update = function (self, dt)
		print(self.name, 'update')
	end,
	print = function (text, width, height)
		if not width and not height then
			love.graphics.print(text, love.window.getWidth() / 2 - #text * 8, love.window.getHeight() / 4)
		elseif width and height then
			love.graphics.print(text, width - #text * 8, height)
		elseif width then
			love.graphics.print(text, width - #text * 8, love.window.getHeight() / 4)
		elseif height then
			love.graphics.print(text, love.window.getWidth() / 2 - #text * 6, height)
		end
	end,
	draw = function (self)

		self.print('Boogeyman', love.window.getWidth() / 2, love.window.getHeight() / 4)

		love.graphics.rectangle('fill', 0, (love.window.getHeight() / 2) + 42 * (self.count % 2), love.window.getWidth(), 30)

		love.graphics.setColor({255, 255, 255, 255})
		if (self.count % 2) == 0 then love.graphics.setColor({0, 0, 0, 255}) end
		self.print('Play', love.window.getWidth() / 2, love.window.getHeight() / 2)

		love.graphics.setColor({255, 255, 255, 255})
		if (self.count % 2) == 1 then love.graphics.setColor({0, 0, 0, 255}) end
		self.print('Quit', love.window.getWidth() / 2, love.window.getHeight() / 2 + 42)
		love.graphics.setColor({255, 255, 255, 255})

	end,
	quit = function (self) print(self.name, 'quit') end
}

state.game = {
	name = "game",

	rate = 200,
	keypressed = function (self, key, rep)
		print(self.name, key, rep)
		state.stdkeypressed(self, key, rep)
		-- if key == 'end' then
		-- 	self.level:add()
		-- end
	end,

	start = function (self)
		print(self.name, 'start')
		self.player = {
			x = love.window.getWidth() / 2,
			y = love.window.getHeight() / 2,
			radius = 10,
			update = function (self, dt, rate) end,
			draw = function (self)
				love.graphics.circle('line', self.x, self.y, self.radius)
			end
		}
		self.level = level.new()
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
		self.pnj = {}
	end,
	update = function (self, dt)
		local movement = { x = 0, y = 0 }

		if love.keyboard.isDown('up') then
			movement.y = movement.y + dt * self.rate end
		if love.keyboard.isDown('down') then
			movement.y = movement.y - dt * self.rate end
		if love.keyboard.isDown('left') then
			movement.x = movement.x + dt * self.rate end
		if love.keyboard.isDown('right') then
			movement.x = movement.x - dt * self.rate end

		print(self.level:collides(self.player))
		self.level:move(movement.x, movement.y)
	end,
	draw = function (self)
		self.player:draw()
		self.level:draw()
	end,
	quit = function (self) print(self.name, 'quit') end
}

return state
