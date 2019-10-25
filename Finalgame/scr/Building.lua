Building = Class{}

local BUILDING_IMAGE = love.graphics.newImage('graphics/building.png')

function Building:init(orientation, y)
    self.x = VIRTUAL_WIDTH + 64
    self.y = y
    self.width = BUILDING_WIDTH
    self.height = BUILDING_HEIGHT
    self.orientation = orientation
end

function Building:update(dt)

end

function Building:render()
    love.graphics.draw(BUILDING_IMAGE, self.x,
        (self.orientation == 'top' and self.y + BUILDING_HEIGHT or self.y),
        0, 1, self.orientation == 'top' and -1 or 1)
end