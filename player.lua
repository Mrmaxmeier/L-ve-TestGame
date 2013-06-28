require "class"

player = class:new()

function player:init()
	self.x = SIZEX/2
	self.y = SIZEY/2
	self.speed = 400
	self.r = 64
end


function player:update(dt)
	if love.keyboard.isDown("up") then self.y = self.y - self.speed*dt end
	if love.keyboard.isDown("down") then self.y = self.y + self.speed*dt end
	if love.keyboard.isDown("left") then self.x = self.x - self.speed*dt end
	if love.keyboard.isDown("right") then self.x = self.x + self.speed*dt end
end

function player:draw()
	love.graphics.setColor(255, 255, 255, 255)
	lg.draw(hamster, self.x, self.y, math.rad(rot), 1, 1, self.r, self.r)
end
