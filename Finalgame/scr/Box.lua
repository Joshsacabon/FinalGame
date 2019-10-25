Box = Class{}

local BOX_IMAGE = love.graphics.newImage('graphics/box1.png')

function Box:init()
    self.x = VIRTUAL_WIDTH * 3 / 4
    self.y = VIRTUAL_HEIGHT / 3
    self.width = BOX_IMAGE:getWidth()
    self.height = BOX_IMAGE:getHeight()
end

function Box:update(dt)
end

function Box:render()
    love.graphics.draw(BOX_IMAGE, self.x, self.y)
end