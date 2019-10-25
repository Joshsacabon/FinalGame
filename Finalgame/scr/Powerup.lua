Powerup = Class{}

local POWERUP_IMAGE = love.graphics.newImage('graphics/powerup.png')

function Powerup:init()
    self.x = math.random(100,700)
    self.y = math.random(100,500)

    self.width = POWERUP_IMAGE:getWidth()
	self.height = POWERUP_IMAGE:getHeight()
	
	self.startupTimer = 0
	self.blinkTimer = 0
	self.timer = 0
	self.visible = true
	self.randomizer = 0 
end

function Powerup:update(dt)
	if self.startupTimer <= 5 then
		self.startupTimer = self.startupTimer + dt
		self.visible = true
	else
		if self.timer < 3.4285 then
			self.timer = self.timer + dt
			self.blinkTimer = self.blinkTimer + dt
			if self.blinkTimer > 0.4285 then
				self.blinkTimer = self.blinkTimer - 0.4285
				self.visible = not self.visible
			end
		else
			self.visible = false
		end
	end
end

function Powerup:render()
	if self.visible == true then
		love.graphics.draw(POWERUP_IMAGE, self.x, self.y)
	end
end