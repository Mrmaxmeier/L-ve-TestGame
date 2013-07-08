require "class"

Star = class:new()

function Star:init()
	self.x, self.y = math.random(1000), math.random(1000)
	self.dx, self.dy = math.random(-100, 100), math.random(-100, 100)
	self.r = 5
	self.col = getRainbowCol()
end

function Star:update(dt)
	self.x = self.x + self.dx*dt
	self.y = self.y + self.dy*dt
end

function Star:draw()
	love.graphics.setColor(self.col[1], self.col[2], self.col[3], 255)
	x = (self.x - player.x) % SIZEX + player.x - SIZEX/2
	y = (self.y - player.y) % SIZEY + player.y - SIZEY/2
	love.graphics.circle("fill", x, y, self.r)
end