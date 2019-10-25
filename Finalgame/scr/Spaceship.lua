Spaceship = Class{}

local GRAVITY = 20

function Spaceship:init()
    self.image = love.graphics.newImage('graphics/spaceship.png')
    self.x = 8
    self.y = VIRTUAL_HEIGHT / 2 - 8

    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.time = 0
    self.dy = 0
end

function Spaceship:collides(building)
    if (self.x + 2) + (self.width - 4) >= building.x and self.x + 2 <= building.x + BUILDING_WIDTH then
        if (self.y + 2) + (self.height - 4) >= building.y and self.y + 2 <= building.y + BUILDING_HEIGHT then
            return true
        end
    end

    return false
end

function Spaceship:collides1(plane)
    if (self.x + 2) + (self.width - 4) >= plane.x and self.x + 2 <= plane.x + PLANE_WIDTH  then
        if (self.y + 2) + (self.height - 4) >= plane.y and self.y + 2 <= plane.y + PLANE_HEIGHT then
            return true
        end
    end
    return false
end

function Spaceship:collides2(attack)
    if (self.x + 2) + (self.width - 4) >= attack.x and self.x + 2 <= attack.x + ATTACK_WIDTH then
        if (self.y + 2) + (self.height - 4) >= attack.y and self.y + 2 <= attack.y + ATTACK_HEIGHT then
            return true
        end
    end
    return false
end

function Spaceship:pcollides(powerup)
    if (self.x + 2) + (self.width - 4) >= powerup.x and self.x + 2 <= powerup.x + POWERUP_WIDTH then
        if (self.y + 2) + (self.height - 4) >= powerup.y and self.y + 2 <= powerup.y + POWERUP_HEIGHT then
            return true
        end
    end
    return false
end

function Spaceship:ccollides(rocket)
    if (self.x + 2) + (self.width - 4) >= rocket.x and self.x + 2 <= rocket.x + ROCKET_WIDTH then
        if (self.y + 2) + (self.height - 4) >= rocket.y and self.y + 2 <= rocket.y + ROCKET_HEIGHT then
            return true
        end
    end
    return false
end

function Spaceship:update(dt)
    if love.keyboard.isDown('left') or love.keyboard.isDown('a') then
        self.dx = -SPACESHIP_SPEED
    elseif love.keyboard.isDown('right') or love.keyboard.isDown('d') then
        self.dx = SPACESHIP_SPEED
    else
        self.dx = 0
    end

    if love.keyboard.isDown('up') or love.keyboard.isDown('w')  then
        self.dy = -SPACESHIP_SPEED
    elseif love.keyboard.isDown('down') or love.keyboard.isDown('s') then
        self.dy = SPACESHIP_SPEED
    else
        self.dy = 0
    end

    if self.dx < 0 then
        self.x = math.max(0, self.x + self.dx * dt)
    else
        self.x = math.min(VIRTUAL_WIDTH - self.width, self.x + self.dx * dt)
    end
    if self.dy < 0 then
        self.y = math.max(0, self.y + self.dy * dt)
    else
        self.y = math.min(VIRTUAL_HEIGHT - self.width, self.y + self.dy * dt)
    end

    self.time = math.random(1,2)
    if self.time == 1 then
        self.image = love.graphics.newImage('graphics/spaceship.png')
    elseif self.time == 2 then
        self.image = love.graphics.newImage('graphics/spaceship1.png')
    end

end

function Spaceship:render()
    love.graphics.draw(self.image, self.x, self.y)
end