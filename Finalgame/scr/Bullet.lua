Bullet = Class{}

local GRAVITY12 = -30
local BULLET_IMAGE = love.graphics.newImage('graphics/bullets.png')

function Bullet:init(x,y)
    self.x = x
    self.y = y

    self.width = BULLET_IMAGE:getWidth()
    self.height = BULLET_IMAGE:getHeight()

    self.dx = 0
    
end

function Bullet:update(dt)
    self.dx = self.dx + GRAVITY12 * dt
    self.x = self.x - self.dx
end

function Bullet:collides(plane)
    if (self.x + 2) + (self.width - 4) >= plane.x and self.x + 2 <= plane.x + PLANE_WIDTH  then
        if (self.y + 2) + (self.height - 4) >= plane.y and self.y + 2 <= plane.y + PLANE_HEIGHT then
            return true
        end
    end

    return false
end

function Bullet:bcollides(box)
    if (self.x + 2) + (self.width - 4) >= box.x and self.x + 2 <= box.x + BOX_WIDTH  then
        if (self.y + 2) + (self.height - 4) >= box.y and self.y + 2 <= box.y + BOX_HEIGHT then
            return true
        end
    end

    return false
end

function Bullet:render()
    love.graphics.draw(BULLET_IMAGE, self.x, self.y)
end