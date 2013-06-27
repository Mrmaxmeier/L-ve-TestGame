bullet = class:new()

function bullet:init(dx, dy)
	self.dx, self.dy = dx, dy
	self.r = 15
	self.x, self.y = hamsterX, hamsterY
end

function bullet:update(dt)
	self.x = self.x + self.dx*dt
	self.y = self.y + self.dy*dt
	if self.x^2 + self.y^2 > 2*SIZEX^2 then
		for i, bu in ipairs(bullets) do
			if bu == self then
				table.remove(bullets, i)
				print("bullet removed!")
				return
			end
		end
	end
end

function bullet:draw()
	setRainbowCol()
	love.graphics.circle("fill", self.x, self.y, self.r, self.r)
	love.graphics.setColor(0, 0, 0, 255)
	--love.graphics.circle("line", self.x, self.y, self.r, self.r)
end
