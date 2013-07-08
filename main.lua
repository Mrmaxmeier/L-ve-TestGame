function love.load()
	--Vars
	lg = love.graphics
	hamster = lg.newImage("gfx/HamsterBall.png")
	hamsterwidth = hamster:getWidth()
	hamsterheight = hamster:getHeight()
	highlightX = 0
	highlightY = 0
	highlightT = 0
	
	n = 0
	rot = 0
	rspeed = 10
	
	worldRot = 0
	
	--Requires
	require "star"
	require "player"
	require "bullet"
	require "enemy"
	require "bozzenemy"
	require "util"
	require "powerup"
	require "explosion"
	
	player = player:new()
	
	stars = {}
	for i = 1, 100 do
		table.insert(stars, Star:new())
	end
	enemies = {}
	bozzenemies = {}
	bullets = {}
	powerups = {}
	explosions = {}
	
	love.graphics.setLineWidth(4)
end

function love.update(dt)
	highlightT = highlightT + dt*0.5
	n = n + dt*60
	rot = rot + rspeed * dt
	rspeed = 0.99 * (rspeed + 4000*dt*(math.random() - 0.5))
	for i, star in ipairs(stars) do
		star:update(dt)
	end
	for i, bullet in ipairs(bullets) do
		bullet:update(dt)
	end
	for i, explosion in ipairs(explosions) do
		explosion:update(dt)
	end
	for i, enemy in ipairs(enemies) do
		enemy:update(dt)
	end
	
	for i, powerup in ipairs(powerups) do
		powerup:update(dt)
	end
	
	if math.random() < dt*2 then
		table.insert(enemies,  enemy  :new(math.random(-SIZEX, 2*SIZEX)+player.x, math.random(-SIZEY, 2*SIZEY)+player.y))
		table.insert(powerups, powerup:new(math.random(-SIZEX, 2*SIZEX)+player.x, math.random(-SIZEY, 2*SIZEY)+player.y))
	elseif math.random() < dt/50 then
			table.insert(bozzenemies,  bozzenemy  :new(math.random(-SIZEX, 2*SIZEX)+player.x, math.random(-SIZEY, 2*SIZEY)+player.y))
	end
	for i, enemy in ipairs(enemies) do
		if collides(player, enemy) then
			print "TOOOOOD!!!"
			table.remove(enemies, i)
		end
	end
	for i, powerup in ipairs(powerups) do
		if collides(player, powerup) then
			print "POOOWERRRUUPPP!!!"
			player.activePowerUp = powerup.powerUpType
			table.remove(powerups, i)
		end
	end
	for ib, bullet in ipairs(bullets) do
		for ie, enemy in ipairs(enemies) do
			if collides(bullet, enemy) then
				highlightX = enemy.x
				highlightY = enemy.y
				highlightT = 0
				table.remove(bullets, ib)
				table.remove(enemies, ie)
				print("COLLISION")
				table.insert(explosions, explosion:new(bullet.x, bullet.y, 1))
			end
		end
		for ie, bozzenemy in ipairs(bozzenemies) do
			if collides(bullet, bozzenemy) then
				highlightX = bozzenemy.x
				highlightY = bozzenemy.y
				highlightT = 0
				table.remove(bullets, ib)
				--table.remove(bozzenemy, ie)
				bozzenemy.r = bozzenemy.r - 5
				print(bozzenemy.r)
				print("COLLISION")
				table.insert(explosions, explosion:new(bullet.x, bullet.y, 1))
				
				if bozzenemy.r < 6 then
					table.remove(bozzenemy, ie)
				end
			end
		end
	end
	player:update(dt)
	
	if love.keyboard.isDown("e") then worldRot = worldRot + 10*dt end
	if love.keyboard.isDown("q") then worldRot = worldRot - 10*dt end
end

function love.mousepressed(x, y, bu)
	if player.activePowerUp == "multishot" then
		table.insert(bullets, bullet:new(player.dx + (x-SIZEX/2)*5, player.dy + (y-SIZEY/2)*5 - 90))
		table.insert(bullets, bullet:new(player.dx + (x-SIZEX/2)*5 + 90, player.dy + (y-SIZEY/2)*5))
		table.insert(bullets, bullet:new(player.dx + (x-SIZEX/2)*5 - 90, player.dy + (y-SIZEY/2)*5))
		table.insert(bullets, bullet:new(player.dx + (x-SIZEX/2)*5, player.dy + (y-SIZEY/2)*5 + 90))
	elseif player.activePowerUp == "multipower" then
		table.insert(bullets, bullet:new(player.dx + (x-SIZEX/2)*15, player.dy + (y-SIZEY/2)*15))
		table.insert(bullets, bullet:new(player.dx + (x-SIZEX/2)*10, player.dy + (y-SIZEY/2)*10))
		table.insert(bullets, bullet:new(player.dx + (x-SIZEX/2)*5, player.dy + (y-SIZEY/2)*5))
		table.insert(bullets, bullet:new(player.dx + (x-SIZEX/2)*2, player.dy + (y-SIZEY/2)*2))
	else
		table.insert(bullets, bullet:new(player.dx + (x-SIZEX/2)*5, player.dy + (y-SIZEY/2)*5))
	end
	player.dx = player.dx + (x-SIZEX/2)*-0.2
	player.dy = player.dy + (y-SIZEY/2)*-0.2
end





function love.draw()
	wobbling = 0.05 / (1+highlightT)
	if wobbling < 0.03 then wobbling = 0 end
	
	love.graphics.push()
	love.graphics.translate(SIZEX/2, SIZEY/2)
	love.graphics.translate(-player.x, -player.y)
	love.graphics.translate(highlightX, highlightY)
	--love.graphics.rotate((math.random()-0.5)*wobbling)
	love.graphics.scale((math.random()-0.5)*wobbling+1)
	love.graphics.translate(-highlightX,-highlightY)
	
	for i, star in ipairs(stars) do
		star:draw()
	end
	
	--love.graphics.print('Hello World!', 400, 300)
	--love.graphics.setBackgroundColor(math.random(128), math.random(128), math.random(128))
	love.graphics.setColor(math.random(255), math.random(255), math.random(255), 255*math.max(0, 1-highlightT))
	--x = SIZEX/2
	--y = SIZEY/2
	x = highlightX
	y = highlightY
	for i = 1, 14, 2 do
		local alpha = math.rad(i / 14 * 360 + rot)
		local point1 = {x+2000*math.cos(alpha), y+2000*math.sin(alpha)}
		
		local alpha = math.rad((i+1) / 14 * 360 + rot)
		local point2 = {x+2000*math.cos(alpha), y+2000*math.sin(alpha)}
		
		love.graphics.polygon("fill", x, y, point1[1], point1[2], point2[1], point2[2])
	end
	
	
	for i, bullet in ipairs(bullets) do
		bullet:draw()
	end
	for i, enemy in ipairs(enemies) do
		enemy:draw()
	end
	for i, bozzenemy in ipairs(bozzenemies) do
		bozzenemy:draw()
	end
	for i, explosion in ipairs(explosions) do
		explosion:draw()
	end
	player:draw()
	
	for i, powerup in ipairs(powerups) do
		powerup:draw()
	end
	
	--Minimap
	--love.graphics.setColor(100, 150, 255, 200)
	--love.graphics.circle( "fill", 100, 100, 100, 180 )
	--love.graphics.setColor(255, 150, 255, 240)
	--lg.line(100,100,100+100*math.sin(math.rad(worldRot)),100+100*math.cos(math.rad(worldRot)))
	--
	
	love.graphics.pop()
	
	love.graphics.setColor(255,255,255, 255)
	
	lg.print(player.activePowerUp, 0, 0, 0, 4)
end
