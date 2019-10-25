--[[
    CPE40032
    "ENDLESS CITY"
    -- START STATE --
]]

-- the "__includes" bit here means we're going to inherit all of the methods
-- that BaseState has, so it will have empty versions of all StateMachine methods
-- even if we don't override them ourselves; handy to avoid superfluous code!
StartState = Class{__includes = BaseState}

-- whether we're highlighting "Start" or "High Scores"
local highlighted = 1

function StartState:enter()
end

function StartState:init()
    sounds['music']:setLooping(true)
    sounds['music']:play()
end

function StartState:update(dt)
    -- toggle highlighted option if we press an arrow key up or down
    if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('down') then
        highlighted = highlighted == 1 and 2 or 1
        sounds['select']:play()
    end

    -- confirm whichever option we have selected to change screens
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        sounds['select']:play()

        if highlighted == 1 then
            gStateMachine:change('countdown')
        else
            love.event.quit()
        end
    end

    -- we no longer have this globally, so include here
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function StartState:render()
    -- title
    love.graphics.setFont(gFonts['title'])
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.printf("ENDLESS CITY", 1, VIRTUAL_HEIGHT / 2 - 90 + 5, VIRTUAL_WIDTH- 25, 'center')
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf("ENDLESS CITY", 0, VIRTUAL_HEIGHT / 2 - 100, VIRTUAL_WIDTH, 'center')

    -- instructions
    love.graphics.setFont(gFonts['medium'])

    -- if we're highlighting 1, render that option blue
    if highlighted == 1 then
        love.graphics.setColor(103, 255, 255, 255)
    end
    love.graphics.printf("START", 0, VIRTUAL_HEIGHT / 2 + 70,
        VIRTUAL_WIDTH, 'center')

    -- reset the color
    love.graphics.setColor(255, 255, 255, 255)

    -- render option 2 blue if we're highlighting that one
    if highlighted == 2 then
        love.graphics.setColor(103, 255, 255, 255)
    end
    love.graphics.printf("QUIT", 0, VIRTUAL_HEIGHT / 2 + 110,
        VIRTUAL_WIDTH, 'center')

    -- reset the color
    love.graphics.setColor(255, 255, 255, 255)
end