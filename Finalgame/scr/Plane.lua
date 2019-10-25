Plane = Class{}

local GRAVITY1 = 400
PLANE_IMAGE = love.graphics.newImage('graphics/plane.png')

function Plane:init(x,y)
    self.x = VIRTUAL_WIDTH - 48
    self.y = VIRTUAL_HEIGHT / 2 - math.random(-300,300)

    self.width = PLANE_WIDTH
    self.height = PLANE_HEIGHT

    self.dx = 0
    self.dy = 0
    self.pltime = 0
    self.xSpeed = 0
    self.ySpeed = 0

    self.angle=0

end

function Plane:update(dt,spaceship)
    if self.pltime <= 1 then
        self.pltime = self.pltime + dt
        self.dx = self.dx - 5* dt
        self.x = self.x + self.dx
    elseif self.pltime > 1 then
        self.xSpeed = math.sin(math.rad (60)) *  GRAVITY1 
        self.ySpeed = math.cos(math.rad (60)) *  GRAVITY1 - 100
        if (self.x - spaceship.x) > 10 then
            if (self.y - spaceship.y) > 10 then
                self.y = self.y - self.ySpeed * dt
                self.x = self.x - self.xSpeed * dt
                self.angle = 0.1
            elseif (self.y - spaceship.y) < -10 then
                self.y = self.y + self.ySpeed * dt
                self.x = self.x - self.xSpeed * dt
                self.angle = -0.1
            else
                self.x = self.x - GRAVITY1 * dt
                self.angle = 0
            end
        else
            self.x = self.x - self.xSpeed * dt
        end
    end
end

function Plane:render()
    love.graphics.draw(PLANE_IMAGE, self.x, self.y)
end