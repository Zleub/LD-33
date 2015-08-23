return {
	rate = 3,
	quadsindex = 1,
	quads = guard_quad,

	x = 300,
	y = 100,
	radius = 10,
	rate = 2,

	position = 1,
	path = {
		{x = 300, y = 100},
		{x = 300, y = 200}
	},

	rotation = math.pi / 4,
	vertices = {
		{  0,   0},
		{75, 200},
		{200, 75}
	},
			-- rotated_vertices = {},

	time = 0,
	update = function (self, dt)
		local destination = ((self.position) % #self.path) + 1
		self.rotation = math.atan2(self.y - self.path[destination].y, self.x - self.path[destination].x) + 2.4

		local x_coef = (self.path[destination].x - self.path[self.position].x) / self.rate
		local y_coef = (self.path[destination].y - self.path[self.position].y) / self.rate

		self.x = self.x + dt * x_coef
		self.y = self.y + dt * y_coef

		if CircleinCircle(self, {
				x = self.path[destination].x,
				y = self.path[destination].y,
				radius = 10
			}) then
			self.position = destination
		end

		-- self.time = self.time + dt
		-- self.rotation = (math.floor(self.time) * math.pi) / 12
		-- self.rotation = self.rotation + dt
		self.rotated_vertices = {}
		for i,v in ipairs(self.vertices) do
			for j, k in ipairs(v) do
				if j == 1 then
					_tmp = {}
					k = v[1] * math.cos(self.rotation) - v[2] * math.sin(self.rotation)
					table.insert(self.rotated_vertices, k + self.x)
					table.insert(_tmp, k)
				elseif j == 2 then
					k = v[2] * math.cos(self.rotation) + v[1] * math.sin(self.rotation)
					table.insert(self.rotated_vertices, k + self.y)
					table.insert(_tmp, k)
				end
			end
		end
	end,
	draw = function (self)
		-- love.graphics.circle("line", self.x, self.y, self.radius)
		love.graphics.draw(self.quads[0], self.quads[1], self.x, self.y, self.rotation + 2.4, 2, 2, 16, 16)
		if self.caca == "caca" then
			love.graphics.setColor({255, 0, 0, 255})
			love.graphics.polygon("fill", unpack(self.rotated_vertices))
			love.graphics.setColor({255, 255, 255, 255})
		-- else
		-- 	love.graphics.setColor({0, 255, 0, 255})
		end
	end

}
