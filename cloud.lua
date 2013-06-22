require "class"

cloud = class:new()

function cloud:init()
	self.x = math.random(-SIZEX, SIZEX)
	self.y = math.random(SIZEY/2)-50
	self.speed = math.random(50, 200)
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
	x2, y2 = x+100,y+50
	love.graphics.polygon("fill", x, y, x, y2, x2, y2, x2, y)
end
