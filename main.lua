function love.load()
	n = 0
	
	require "cloud"
	
	clouds = {}
	for i = 1, 100 do
		table.insert(clouds, cloud:new())
	end
end

function love.update(dt)
	n = n + dt*60
	for i, cloud in ipairs(clouds) do
		cloud:update(dt)
	end
end

function love.draw()
	--love.graphics.print('Hello World!', 400, 300)
	--love.graphics.setBackgroundColor(math.random(128), math.random(128), math.random(128))
	love.graphics.setColor(math.random(255), math.random(255), math.random(255), 255)
	x = SIZEX/2
	y = SIZEY/2
	for i = 1, 10, 2 do
		local alpha = math.rad(i / 10 * 360 + n)
		local point1 = {x+2000*math.cos(alpha), y+2000*math.sin(alpha)}
		
		local alpha = math.rad((i+1) / 10 * 360 + n)
		local point2 = {x+2000*math.cos(alpha), y+2000*math.sin(alpha)}
		
		love.graphics.polygon("fill", x, y, point1[1], point1[2], point2[1], point2[2])
	end
	for i, cloud in ipairs(clouds) do
		cloud:draw()
	end
end
