function love.load()
	lg = love.graphics
	hamster = lg.newImage("gfx/HamsterBall.png")
	hamsterwidth = hamster:getWidth()
	hamsterheight = hamster:getHeight()
	n = 0
	rot = 0
	rspeed = 10
	
	require "cloud"
	require "floortile"
	
	clouds = {}
	for i = 1, 100 do
		table.insert(clouds, cloud:new())
		table.insert(clouds, floortile:new())
	end
end

function love.update(dt)
	n = n + dt*60
	rot = rot + rspeed * dt
	rspeed = 0.99 * (rspeed + 4000*dt*(math.random() - 0.5))
	for i, cloud in ipairs(clouds) do
		cloud:update(dt)
	end
end




function love.draw()
	wobbling = 0.15 * math.sin(n/50)^2
	
	love.graphics.push()
	love.graphics.translate(SIZEX/2,SIZEY/2)
	--love.graphics.rotate((math.random()-0.5)*wobbling)
	love.graphics.scale((math.random()-0.5)*wobbling+1)
	love.graphics.translate(-SIZEX/2,-SIZEY/2)
	
	--love.graphics.print('Hello World!', 400, 300)
	--love.graphics.setBackgroundColor(math.random(128), math.random(128), math.random(128))
	love.graphics.setColor(math.random(255), math.random(255), math.random(255), 255)
	x = SIZEX/2
	y = SIZEY/2
	for i = 1, 10, 2 do
		local alpha = math.rad(i / 10 * 360 + rot)
		local point1 = {x+2000*math.cos(alpha), y+2000*math.sin(alpha)}
		
		local alpha = math.rad((i+1) / 10 * 360 + rot)
		local point2 = {x+2000*math.cos(alpha), y+2000*math.sin(alpha)}
		
		love.graphics.polygon("fill", x, y, point1[1], point1[2], point2[1], point2[2])
	end
	for i, cloud in ipairs(clouds) do
		cloud:draw()
	end
	lg.setColor(255,255,255,255)
	lg.draw(hamster, 400, 300, math.rad(rot), 1, 1, hamsterwidth / 2, hamsterheight / 2)
	
	love.graphics.pop()
end
