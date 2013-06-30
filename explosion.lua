require "class"

explosion = class:new()

explosion.cols = {
	{128,255,255},
	{255,255,0},
	{255,128,0},
	{255,0,0}
}

function explosion:init(x, y, stage)
	self.stage, self.r = stage, 100/stage
	self.time = 1
	self.col = explosion.cols[stage]
	self.points = {}
	local function point()
		local function f() return math.random(-self.r, self.r) end
		repeat dx, dy = f(), f()
		until dx^2 + dy^2 <= self.r^2
		return {x=x+dx, y=y+dy, dx=f()/2, dy=f()/2}
	end
	for i = 1, 12/stage do
		self.points[i] = point()
	end
end

function explosion:update(dt)
	self.time = self.time + dt
	for i, p in ipairs(self.points) do
		p.x = p.x + p.dx*dt
		p.y = p.y + p.dy*dt
	end
	if self.stage < 4 then
		for i, p in ipairs(self.points) do
			if not p.hasChild and math.random() < dt*4 then
				if math.random() < 0.5 then
					table.insert(explosions, explosion:new(p.x, p.y, self.stage+1))
				end
				p.hasChild = true
			end
		end
	end
	if math.random() < dt*0.3*self.stage then
		table.remVal(explosions, self)
	end
end

function explosion:draw()
	love.graphics.setColor(self.col[1], self.col[2], self.col[3], 255/self.time)
	love.graphics.polygon("fill", self:getCoords())
end

function explosion:getCoords()
	res = {}
	for i, point in ipairs(self.points) do
		table.insert(res, point.x)
		table.insert(res, point.y)
	end
	return res
end
