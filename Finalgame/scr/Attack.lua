Attack = Class{}

local GRAVITY12 = 30
local ATTACK_IMAGE = love.graphics.newImage('graphics/bullet1.png')

function Attack:init(x,y)
    self.x = x
    self.y = y
    self.width = ATTACK_IMAGE:getWidth()
    self.height = ATTACK_IMAGE:getHeight()
    self.dx = 0
end

function Attack:update(dt)
    self.dx = self.dx + GRAVITY12 * dt
    self.x = self.x - self.dx

end


function Attack:render()
    love.graphics.draw(ATTACK_IMAGE, self.x, self.y)
end