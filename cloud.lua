require "class"

cloud = class:new()

function cloud:init()
	z = 1/(math.random()+0.1)
	self.dx = 40*z
	self.dy = 20*z
	self.x = math.random(-SIZEX, SIZEX)
	self.y = (SIZEY/2-self.dy) - 50*z
	self.speed = z * 60
end

function cloud:update(dt)
	self.x = self.x + self.speed*dt
	if self.x > SIZEX then
		self.x = self.x - 2*SIZEX
	end
end

function cloud:draw()
	love.graphics.setColor(255, 255, 255, 125)
	x, y = self.x, self.y
	x2, y2 = x+self.dx,y+self.dy
	love.graphics.polygon("fill", x, y, x, y2, x2, y2, x2, y)
end
