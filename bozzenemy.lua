bozzenemy = class:new()

function bozzenemy:init(x, y)
	self.dx, self.dy = math.random(-100, 100), math.random(-100, 100)
	self.r = 200
	self.acc = 100
	self.col = getRainbowCol()
	self.x, self.y = x, y
end

function bozzenemy:update(dt)
	dist = (player.x-self.x)^2 + (player.y-self.y)^2
	self.dx = self.dx*0.9^dt + (player.x-self.x)*self.acc/dist
	self.dy = self.dy*0.9^dt + (player.y-self.y)*self.acc/dist
	self.x = self.x + self.dx*dt
	self.y = self.y + self.dy*dt
	if self.x^2 + self.y^2 > SIZEX^2 then
		--table.remove(bullets, self)
	end
end

function bozzenemy:draw()
	love.graphics.setColor(self.col[1], self.col[2], self.col[3])
	love.graphics.circle("fill", self.x, self.y, self.r, self.r)
	if math.random() < 0.5 then
		love.graphics.setColor(0, 0, 0, 255)
	else
		love.graphics.setColor(255, 255, 255, 255)
	end
	love.graphics.circle("line", self.x, self.y, self.r, self.r)
end
