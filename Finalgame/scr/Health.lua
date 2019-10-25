Health= Class{}

local HEALTH_IMAGE = love.graphics.newImage('graphics/health21.png')

function Health:init()
    self.x = 1100
    self.y = 20
    self.width = HEALTH_IMAGE:getWidth()
    self.height = HEALTH_IMAGE:getHeight()
    self.life = 3
end


function Health:update(lifeleft)
    if lifeleft == 3 then
        HEALTH_IMAGE = love.graphics.newImage('graphics/health21.png')
    elseif lifeleft == 2 then
        HEALTH_IMAGE = love.graphics.newImage('graphics/health22.png')
    elseif lifeleft == 1 then
        HEALTH_IMAGE = love.graphics.newImage('graphics/health23.png')
    end
end

function Health:render()
    love.graphics.draw(HEALTH_IMAGE, self.x, self.y)
end