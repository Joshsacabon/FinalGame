--[[
    CPE40032
    "ENDLESS CITY"
    -- SCORE STATE --


    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a building, rocket, and/or plane.
]]

ScoreState = Class{__includes = BaseState}

--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
local HighScore = 0
local PLANE_ICON = love.graphics.newImage('graphics/plane2.png')
local BONUS_ICON = love.graphics.newImage('graphics/box2.png')

function ScoreState:enter(params)
    self.finalscore = params.finalscore
    self.score = params.score
    self.hit = params.hit
    self.hit1 = params.hit1
    self.distance = params.distance
end
function ScoreState:init()
    sounds['gameover']:setLooping(true)
    sounds['gameover']:play()
    self.timer = 0
end

function ScoreState:update(dt)
    PIPE_SPEED = 70
    TIME = 6
    BACKGROUND_SCROLL_SPEED = 30
    GROUND_SCROLL_SPEED = 50
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end

    self.timer = self.timer + dt
end

function ScoreState:render()
    -- simply render the score to the middle of the screen
    love.graphics.setColor( 0, 0, 0, 127)
    love.graphics.rectangle('fill', 38, 35, 1200, 650)

    if self.timer > 0.75 then
        love.graphics.setFont(gFonts['huge'])
        love.graphics.setColor(0, 0, 0, 255)
        love.graphics.printf('Game Over!', 0, 135 , VIRTUAL_WIDTH - 25, 'center')
        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.printf('Game Over!', 0, 120 , VIRTUAL_WIDTH, 'center')
    end

    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.setFont(gFonts['small'])

    if self.timer > 1.5 then
        love.graphics.printf('Distance          ' .. tostring(self.distance) .. ' m', VIRTUAL_WIDTH/2-200, 250, VIRTUAL_WIDTH, 'left')
    end

    if self.timer > 2 then
        love.graphics.printf('Buildings           x ' .. tostring(self.score), VIRTUAL_WIDTH/2-200, 300, VIRTUAL_WIDTH, 'left')

    end

    if self.timer > 2.5 then
        love.graphics.draw(PLANE_ICON,VIRTUAL_WIDTH/2-100, 350)
        love.graphics.printf('x ' .. tostring(self.hit), VIRTUAL_WIDTH/2+100, 350, VIRTUAL_WIDTH, 'left')        
    end

    if self.timer > 3 then
        love.graphics.draw(BONUS_ICON,VIRTUAL_WIDTH/2-80, 400)
        love.graphics.printf('x ' .. tostring(self.hit1), VIRTUAL_WIDTH/2+100, 400, VIRTUAL_WIDTH, 'left')
    end

    if HighScore < self.finalscore then
        HighScore = self.finalscore
    end 

    love.graphics.setFont(gFonts['medium'])

    if self.timer > 3.5 then
        love.graphics.printf('Score: ' .. tostring(self.finalscore), 0, 480, VIRTUAL_WIDTH-90, 'center')
    end

    if self.timer > 4 then
        love.graphics.printf('High Score: ' .. tostring(HighScore), 0, 530, VIRTUAL_WIDTH-90, 'center')
    end

    if self.timer > 4.5 and self.timer % 1.5 < 0.75 then
        love.graphics.setFont(gFonts['medium'])
        love.graphics.printf('Press Enter to Play Again!', 0, VIRTUAL_HEIGHT-100, VIRTUAL_WIDTH, 'center')
    end

end