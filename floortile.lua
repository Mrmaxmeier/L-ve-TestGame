require "class"

floortile = class:new()

function floortile:init()
	self.z = 1
	self.color = {0,0,0}
	while self.color[1]==0 and self.color[2]==0 and self.color[3]==0 or self.color[1]==255 and self.color[2]==255 and self.color[3]==255 do
		self.color = {math.random(0,1)*255, math.random(0,1)*255, math.random(0,1)*255}
	end
	self.dz = 2
	self.y = math.random(5, 50)
	self.dx = 100
	self.x = math.random(-SIZEX, SIZEX)
	self.speed = 1.5^math.random(1, 5)
end

function floortile:update(dt)
	self.z = self.z * self.speed^dt
	if self.x > SIZEX or self.x < -SIZEX or self.y * self.z > SIZEY/2 then
		self:init()
	end
end

function floortile:draw()
	love.graphics.setColor(self.color[1], self.color[2], self.color[3], 125)
	z1, z2 = self.z, self.z*self.dz
	x1, y = self.x, self.y
	x2 = x1+self.dx
	love.graphics.translate(SIZEX/2, SIZEY/2)
	love.graphics.polygon("fill", x1*z1, y*z1, x2*z1, y*z1, x2*z2, y*z2, x1*z2, y*z2)
	love.graphics.translate(-SIZEX/2, -SIZEY/2)
end
