enemy = class:new()

function enemy:init(x, y)
	self.dx, self.dy = math.random(-100, 100), math.random(-100, 100)
	self.r = 30
	self.acc = 1000
	self.col = getRainbowCol()
	self.x, self.y = x, y
end

function enemy:update(dt)
	dist = (hamsterX-self.x)^2 + (hamsterY-self.y)^2
	self.dx = self.dx*0.99^dt + (hamsterX-self.x)*self.acc/dist
	self.dy = self.dy*0.99^dt + (hamsterY-self.y)*self.acc/dist
	self.x = self.x + self.dx*dt
	self.y = self.y + self.dy*dt
	if self.x^2 + self.y^2 > SIZEX^2 then
		--table.remove(bullets, self)
	end
end

function enemy:draw()
	love.graphics.setColor(self.col[1], self.col[2], self.col[3])
	love.graphics.circle("fill", self.x, self.y, self.r, self.r)
	love.graphics.setColor(0, 0, 0, 255)
	--love.graphics.circle("line", self.x, self.y, self.r, self.r)
end
