function love.load()
	n = 0
end

function love.update()
	n = n + 1
end

function love.draw()
	--love.graphics.print('Hello World!', 400, 300)
	--love.graphics.setBackgroundColor(math.random(128), math.random(128), math.random(128))
	love.graphics.setColor(math.random(255), math.random(255), math.random(255), 255)
	for i = 1, 10, 2 do
		local alpha = math.rad(i / 10 * 360 + n)
		local point1 = {400+2000*math.cos(alpha), 300+2000*math.sin(alpha)}
		
		local alpha = math.rad((i+1) / 10 * 360 + n)
		local point2 = {400+2000*math.cos(alpha), 300+2000*math.sin(alpha)}
		
		love.graphics.polygon("fill", 400, 300, point1[1], point1[2], point2[1], point2[2])
	end
end
