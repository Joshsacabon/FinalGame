--[[
    CPE40032
    "ENDLESS CITY"
    -- PLAY STATE --
]]

PlayState = Class{__includes = BaseState}

PIPE_SPEED = 70
BUILDING_WIDTH = 175
BUILDING_HEIGHT = 720
PLANE_WIDTH = 131
PLANE_HEIGHT = 59
ATTACK_WIDTH = 34
ATTACK_HEIGHT = 9
BULLET_WIDTH = 40
BULLET_HEIGHT = 7
BOX_WIDTH = 110
BOX_HEIGHT = 110
POWERUP_WIDTH = 64
POWERUP_HEIGHT = 64
ROCKET_WIDTH = 34
ROCKET_HEIGHT = 34
BIRD_WIDTH = 38
BIRD_HEIGHT = 24
TIME = 5
PLANE_TIME = 2.5
ATTACK_TIME = 5
POWERUP_TIME = 10
ROCKET_TIME = 12
BOX_TIME = 5
RBULLET_IMAGE = love.graphics.newImage('graphics/RBullet.png')


function PlayState:init()
    self.spaceship = Spaceship()
    self.boxes = {}
    self.health = Health()
    self.planes = {}
    self.attacks = {}
    self.bullets = {}
    self.buildingPairs = {}
    self.timer = 0
    self.timer1 = 0
    self.timer2 = 0
    self.score = 0
    self.count = 10
    self.life = 3
    self.scoretimer = 0
    self.stimer = 0 
    self.start = 0 
    self.sstart = 0
    self.time = 0
    self.powerups = {}
    self.ptimer = 0
    self.ctimer = 0
    self.btimer = 0
    self.type = 0 
    self.rockets = {}
    self.rockettime = 3
    self.rocketcount = 0
    self.hit = 0
    self.hit1 = 0
    self.bonus = 0
    self.counter = 0
    self.ccounter = 0
    self.finalscore = 0
    self.lastY = -BUILDING_HEIGHT + math.random(80) + 20

    sounds['music']:setLooping(true)
    sounds['music']:play()

end

function PlayState:update(dt)
    -- update timer for building spawning
    self.type = math.random(1,2)
    self.timer = self.timer + dt
    self.ptimer = self.ptimer + dt
    self.ctimer = self.ctimer + dt
    self.btimer = self.btimer + dt
    self.timer1 = self.timer1 + dt
    self.timer2 = self.timer2 + dt
    self.scoretimer = self.scoretimer + 3 * dt 
    self.stimer = math.floor(self.scoretimer)
    self.finalscore = self.stimer + (self.hit * 10) + (self.score * 20) + (self.hit1 * 50)

    if self.stimer >= 570 and self.stimer < 640 then
        
        POWERUP_TIME = 3

        if self.btimer > BOX_TIME then

            table.insert(self.boxes, Box())

            self.btimer = 0
        end

        for k, box in pairs(self.boxes) do
            for l, bullet in pairs(self.bullets) do
                if bullet:bcollides(box) then
                    sounds['coin']:play()
                    self.hit1 = self.hit1 + 1
                    table.remove(self.bullets, k)

                end
            end
        end
        for k, box in pairs(self.boxes) do
            box:update(dt)
        end
    else
        POWERUP_TIME = 10
    end
        
    if self.stimer > 650 then
        ROCKET_TIME = 7
        ATTACK_TIME = 3.5
        self.rockettime = 6
    end

    if self.stimer >= 10 then
        if self.timer > TIME then
            local y = math.max(-BUILDING_HEIGHT + 100,
                math.min(self.lastY + math.random(-350, 350), VIRTUAL_HEIGHT - 300 - BUILDING_HEIGHT))
                self.lastY = y  
            if self.stimer >= 550 and self.stimer < 650 then
                TIME = 2
            else
                table.insert(self.buildingPairs, BuildingPair(y))
            end
            self.timer = 0
        end

        for k, pair in pairs(self.buildingPairs) do
            for l, building in pairs(pair.buildings) do
               
                if self.spaceship:collides(building) then
                    sounds['explosion']:play()
                    sounds['hurt']:play()
                    self.life = self.life - 1 
                    table.remove(self.buildingPairs, k)
                    if self.life <= 0 then
                        gStateMachine:change('score', {
                            finalscore = self.finalscore, 
                            score = self.score,
                            distance = self.stimer,
                            hit = self.hit,
                            hit1 = self.hit1,
                        })
                    end
                end
            end
        end

        if self.stimer >= 80 then
            if self.ctimer > ROCKET_TIME then
                if self.stimer >= 550 and self.stimer < 650 then
                    TIME = 2
                else
                    table.insert(self.rockets, Rocket())
                end
                self.ctimer = 0
            end

            for k, rocket in pairs(self.rockets) do
                if self.spaceship:ccollides(rocket) then
                    sounds['explosion']:play()
                    sounds['hurt']:play()
                    self.life = self.life - 1 
                    table.remove(self.rockets, k)


                    if self.life <= 0 then
                        gStateMachine:change('score', {
                            finalscore = self.finalscore, 
                            score = self.score,
                            distance = self.stimer,
                            hit = self.hit,
                            hit1 = self.hit1,
                        })
                    end
                end
            end
        end
    end

    
    if self.count > 0 then 
        if love.keyboard.wasPressed('space') then
            sounds['shoot']:play()
           self.count = self.count - 1
            table.insert(self.bullets, Bullet(self.spaceship.x + 32, self.spaceship.y + 36))
        end
    end

    if self.ptimer > POWERUP_TIME then
        table.insert(self.powerups, Powerup())
        self.ptimer = 0
    end

    for k, powerup in pairs(self.powerups) do
        if self.spaceship:pcollides(powerup) then
            sounds['powerup']:play()
            if powerup.visible == true then
                self.count = self.count + 10
            end
            table.remove(self.powerups, k)
        end
    end    
    
    if self.stimer >= 200 then
        TIME = 4

        if self.timer1 > PLANE_TIME then
            if self.stimer >= 550 and self.stimer < 650 then
                TIME = 2
            else
                table.insert(self.planes, Plane())
            end
            self.timer1 = 0
        end
       
        if self.stimer >= 300 then
            if self.timer2 > ATTACK_TIME then
                if self.stimer >= 550 and self.stimer < 650 then
                    TIME = 2
                else
                    for k, plane in pairs(self.planes) do
                        table.insert(self.attacks, Attack(plane.x,plane.y))
                    end
                end
                self.timer2 = 0
            end
        end

        for k, plane in pairs(self.planes) do
            if self.spaceship:collides1(plane) then
                sounds['explosion']:play()
                sounds['hurt']:play()
                self.life = self.life - 1 
                table.remove(self.planes, k)
                
                if self.life <= 0 then
                    gStateMachine:change('score', {
                        finalscore = self.finalscore, 
                        score = self.score,
                        distance = self.stimer,
                        hit = self.hit,
                        hit1 = self.hit1,
                    })
                end
            end
            plane:update(dt,self.spaceship)
        end

        for k, attack in pairs(self.attacks) do
            if self.spaceship:collides2(attack) then
                sounds['explosion']:play()
                sounds['hurt']:play()
                self.life = self.life - 1 
                table.remove(self.attacks, k)
                
                if self.life <= 0 then
                    gStateMachine:change('score', {
                        finalscore = self.finalscore, 
                            score = self.score,
                            distance = self.stimer,
                            hit = self.hit,
                            hit1 = self.hit1,
                    })
                end
            end
        end

        for k, bullet in pairs(self.bullets) do
            for l, plane in pairs(self.planes) do
                if bullet:collides(plane) then
                    sounds['explosion']:play()
                    self.hit = self.hit + 1
                    table.remove(self.bullets, k)
                    table.remove(self.planes, l)
                end
            end        
        end
    end

    if self.life == 0 then
        sounds['death']:play()
        sounds['music']:stop()
        sounds['death']:play()
    end

    if self.stimer ~= 0 then
        if self.stimer % 100 == 0 then
            sounds['recover']:play()
            if self.life < 3 then 
                self.life = self.life + 1
            end
        end
    end

    self.health:update(self.life)
    
    for k, attack in pairs(self.attacks) do
        attack:update(dt)
    end
    for k, bullet in pairs(self.bullets) do
        bullet:update(dt)
    end
    for k, powerup in pairs(self.powerups) do
        powerup:update(dt)
    end
    for k, powerup in pairs(self.powerups) do
        powerup:update(dt)
    end
    for k, rocket in pairs(self.rockets) do
        rocket:update(dt,self.rockettime)
    end

    for k, pair in pairs(self.buildingPairs) do
        if not pair.scored then
            if pair.x + BUILDING_WIDTH < self.spaceship.x then
                self.score = self.score + 1
                        
                if TIME > 1 then
                    TIME = TIME - 0.01
                elseif TIME == 1.3 then
                    TIME = 1
                end
                
                pair.scored = true
            end
        end
        pair:update(dt)
    end

    for k, pair in pairs(self.buildingPairs) do
        if pair.remove then
            table.remove(self.buildingPairs, k)
        end
    end    

    self.spaceship:update(dt)

    if self.score % 5 == 1 then
        BACKGROUND_SCROLL_SPEED = BACKGROUND_SCROLL_SPEED + 0.25
        GROUND_SCROLL_SPEED = GROUND_SCROLL_SPEED + 0.25
        PIPE_SPEED = PIPE_SPEED + 0.75
    end

      if self.spaceship.y > VIRTUAL_HEIGHT - 15 then
        sounds['explosion']:play()
        sounds['hurt']:play()

        gStateMachine:change('score', {
            finalscore = self.finalscore, 
            score = self.score,
            distance = self.stimer,
            hit = self.hit,
            hit1 = self.hit1,
        })
        end

end
function PlayState:render()
    for k, bullet in pairs(self.bullets) do
        bullet:render()
    end   

    love.graphics.setFont(gFonts['medium'])

    if self.stimer >= 570 and self.stimer < 640 then
        for k, box in pairs(self.boxes) do
            box:render()
        end
    end

    if self.stimer >= 10 then
        for k, pair in pairs(self.buildingPairs) do
            pair:render()
        end
    end

    for k, powerup in pairs(self.powerups) do
        powerup:render()
    end

    for k, rocket in pairs(self.rockets) do
        rocket:render()
    end

    if self.stimer >= 200 then
        if self.stimer >= 300 then
            for k, attack in pairs(self.attacks) do
                attack:render()
            end
        end
        
        for k, plane in pairs(self.planes) do
            plane:render()
        end
    end  

    self.health:render() 
    love.graphics.draw(RBULLET_IMAGE, 20, 70)
    love.graphics.print('x ' .. tostring(self.count), 100, 75)
    love.graphics.print('Distance: ' .. tostring(self.stimer).. ' m', 20, 20)
    self.spaceship:render()

end

function PlayState:enter()
    scrolling = true
end

function PlayState:exit()
    scrolling = false
end