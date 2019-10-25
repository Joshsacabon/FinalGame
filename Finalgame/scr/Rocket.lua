Rocket = Class{}


local ROCKET_IMAGE = love.graphics.newImage('graphics/rocket.png')
function Rocket:init()
    self.x = VIRTUAL_WIDTH - 48
    self.y = VIRTUAL_HEIGHT / 2 - math.random(-300,300)

    self.width = ROCKET_IMAGE:getWidth()
    self.height = ROCKET_IMAGE:getHeight()
    
    self.dx = 0
end

function Rocket:update(dt,timer)
    self.dx = self.dx - timer * dt
    self.x = self.x + self.dx
end

function Rocket:render()
	love.graphics.draw(ROCKET_IMAGE, self.x, self.y)
end