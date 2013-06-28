require "class"

cloud = class:new()

function cloud:init()
	z = 1/(math.random()+0.05)*0.7
	self.dx = 40*z
	self.dy = 20*z
	self.rot = math.random(360)
	self.y = 50*z
	self.speed = math.random(10,50)
end

function cloud:update(dt)
	self.rot = self.rot + self.speed*dt
end

function cloud:draw()
	love.graphics.setColor(255, 255, 255, 125)
	love.graphics.push()
	love.graphics.translate(highlightX, highlightY)
	love.graphics.rotate(math.rad(self.rot))
	x, y = -self.dx/2, self.y
	x2, y2 = self.dx/2, y+self.dy
	love.graphics.polygon("fill", x, y, x, y2, x2, y2, x2, y)
	love.graphics.pop()
end
