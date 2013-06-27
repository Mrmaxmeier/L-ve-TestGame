function love.load()
	--Vars
	lg = love.graphics
	hamster = lg.newImage("gfx/HamsterBall.png")
	
	n = 0
	rot = 0
	rspeed = 10
	
	worldRot = 0
	
	--Requires
	require "player"
	require "cloud"
	require "floortile"
	require "bullet"
	
	
	player = playerInit()
	
	clouds = {}
	for i = 1, 100 do
		table.insert(clouds, cloud:new())
	end
	floortiles = {}
	for i = 1, 100 do
		table.insert(floortiles, floortile:new())
	end
	bullets = {}
end

function love.update(dt)
	n = n + dt*60
	rot = rot + rspeed * dt
	rspeed = 0.99 * (rspeed + 4000*dt*(math.random() - 0.5))
	for i, cloud in ipairs(clouds) do
		cloud:update(dt)
	end
	for i, floortile in ipairs(floortiles) do
		floortile:update(dt)
	end
	for i, bullet in ipairs(bullets) do
		bullet:update(dt)
	end
	
	--PlayerMovement
	if love.keyboard.isDown("left") then player.x = player.x - player.speed*dt end
	if love.keyboard.isDown("right") then player.x = player.x + player.speed*dt end
	if love.keyboard.isDown("up") then player.y = player.y - player.speed*dt end
	if love.keyboard.isDown("down") then player.y = player.y + player.speed*dt end
	
	
	if love.keyboard.isDown("e") then worldRot = worldRot + 10*dt end
	if love.keyboard.isDown("q") then worldRot = worldRot - 10*dt end
end

function love.mousepressed(x, y, bu)
	table.insert(bullets, bullet:new(x-player.x, y-player.y))
end





function love.draw()
	wobbling = 0.15 * math.sin(n/50)^2
	
	love.graphics.push()
	love.graphics.translate(SIZEX/2,SIZEY/2)
	--love.graphics.rotate((math.random()-0.5)*wobbling)
	love.graphics.scale((math.random()-0.5)*wobbling+1)
	love.graphics.translate(-SIZEX/2,-SIZEY/2)
	
	for i, floortile in ipairs(floortiles) do
		floortile:draw()
	end
	--love.graphics.print('Hello World!', 400, 300)
	--love.graphics.setBackgroundColor(math.random(128), math.random(128), math.random(128))
	love.graphics.setColor(math.random(255), math.random(255), math.random(255), 255)
	--x = SIZEX/2
	--y = SIZEY/2
	x = player.x
	y = player.y
	for i = 1, 14, 2 do
		local alpha = math.rad(i / 14 * 360 + rot)
		local point1 = {x+2000*math.cos(alpha), y+2000*math.sin(alpha)}
		
		local alpha = math.rad((i+1) / 14 * 360 + rot)
		local point2 = {x+2000*math.cos(alpha), y+2000*math.sin(alpha)}
		
		love.graphics.polygon("fill", x, y, point1[1], point1[2], point2[1], point2[2])
	end
	for i, cloud in ipairs(clouds) do
		cloud:draw()
	end
	
	
	for i, bullet in ipairs(bullets) do
		bullet:draw()
	end
	
	love.graphics.setColor(255, 255, 255, 255)
	lg.draw(hamster, player.x, player.y, math.rad(rot), 1, 1, hamster:getWidth() / 2, hamster:getHeight() / 2)
	
	--Minimap
	love.graphics.setColor(100, 150, 255, 200)
	love.graphics.circle( "fill", 100, 100, 100, 180 )
	love.graphics.setColor(255, 150, 255, 240)
	lg.line(100,100,100+100*math.sin(math.rad(worldRot)),100+100*math.cos(math.rad(worldRot)))
	--
	love.graphics.pop()
end

function getRainbowCol()
	r = 0
	g = 255
	b = math.random(255)
	choices = {{r,g,b}, {b,r,g}, {g,b,r}, {r,b,g}, {b,g,r}, {g,r,b}}
	return choices[math.random(6)]
end
function setRainbowCol()
	col = getRainbowCol()
	love.graphics.setColor(col[1], col[2], col[3])
end
