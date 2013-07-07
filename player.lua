require "class"

player = class:new()

function player:init()
	self.x = 0--SIZEX/2
	self.y = 0--SIZEY/2
	self.dx, self.dy = 0, 0
	self.r = 64
end


function player:update(dt)
	self.x = self.x + self.dx*dt
	self.y = self.y + self.dy*dt
	self.dx = self.dx * 0.8^dt
	self.dy = self.dy * 0.8^dt
end

function player:draw()
	love.graphics.setColor(255, 255, 255, 255)
	lg.draw(hamster, self.x, self.y, math.rad(rot), 1, 1, self.r, self.r)
end
