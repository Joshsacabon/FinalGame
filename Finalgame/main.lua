--[[
    CPE40032
    "ENDLESS CITY"
]]

push = require 'scr/push'
Class = require 'scr/class'

-- a basic StateMachine class which will allow us to transition to and from
-- game states smoothly and avoid monolithic code in one file
require 'scr/StateMachine'
require 'states/BaseState'
require 'states/CountdownState'
require 'states/PlayState'
require 'states/ScoreState'
require 'states/StartState'
require 'scr/Powerup'
require 'scr/Rocket'
require 'scr/Box'
require 'scr/Bullet'
require 'scr/Attack'
require 'scr/Plane'
require 'scr/Health'
require 'scr/Spaceship'
require 'scr/Building'
require 'scr/BuildingPair'

-- physical screen dimensions
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- virtual resolution dimensions
VIRTUAL_WIDTH = 1280
VIRTUAL_HEIGHT = 720
SPACESHIP_SPEED = 250

local background = love.graphics.newImage('graphics/b1.png')
local backgroundScroll = 0

BACKGROUND_SCROLL_SPEED = 30
local BACKGROUND_LOOPING_POINT = 1014

local ground = love.graphics.newImage('graphics/b2.png')
local groundScroll = 0

GROUND_SCROLL_SPEED = 50
local GROUND_LOOPING_POINT = 1014

-- global variable we can use to scroll the map
scrolling = true

function love.load()
    -- initialize our nearest-neighbor filter
    love.graphics.setDefaultFilter('nearest', 'nearest')
    
    -- seed the RNG
    math.randomseed(os.time())

    -- app window title
    love.window.setTitle('ENDLESS CITY')

    -- initialize our nice-looking retro text fonts
    gFonts = {
        ['small'] = love.graphics.newFont('font/Real Young.ttf', 35),
        ['medium'] = love.graphics.newFont('font/Real Young.ttf', 46),
        ['large'] = love.graphics.newFont('font/Real Young.ttf', 80),
        ['huge'] = love.graphics.newFont('font/Real Young.ttf', 130),
        ['title'] = love.graphics.newFont('font/Real Young.ttf', 150),
    }
    love.graphics.setFont(gFonts['large'])

    -- initialize our table of sounds
    sounds = {
        ['jump'] = love.audio.newSource('sounds/jump.wav', 'static'),
        ['explosion'] = love.audio.newSource('sounds/explosion.wav', 'static'),
        ['hurt'] = love.audio.newSource('sounds/hurt.wav', 'static'),
        ['score'] = love.audio.newSource('sounds/score.wav', 'static'),
        ['select'] = love.audio.newSource('sounds/select.wav', 'static'),
        ['recover'] = love.audio.newSource('sounds/recover.wav', 'static'),
        ['death'] = love.audio.newSource('sounds/death.wav', 'static'),
        ['shoot'] = love.audio.newSource('sounds/laser1.wav', 'static'),
        ['gameover'] = love.audio.newSource('sounds/gameover.mp3', 'static'),
        ['powerup'] = love.audio.newSource('sounds/Powerup.wav', 'static'),
        ['coin'] = love.audio.newSource('sounds/Coin 1.wav', 'static'),
        ['music'] = love.audio.newSource('sounds/Fighting.mp3', 'static')
    }

    -- initialize our virtual resolution
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })

    -- initialize state machine with all state-returning functions
    gStateMachine = StateMachine {
        ['start'] = function() return StartState() end,
        ['countdown'] = function() return CountdownState() end,
        ['play'] = function() return PlayState() end,
        ['score'] = function() return ScoreState() end,
        ['enter-high-score'] = function() return EnterHighScoreState() end,
        ['high-scores'] = function() return HighScoreState() end
    }
    gStateMachine:change('start')

    -- initialize input table
    love.keyboard.keysPressed = {}
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    -- add to our table of keys pressed this frame
    love.keyboard.keysPressed[key] = true

    if key == 'escape' then
        love.event.quit()
    end
end

function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end

function love.update(dt)
    if scrolling then
        backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT
    end
    if scrolling then
        groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt) % GROUND_LOOPING_POINT
    end

    gStateMachine:update(dt)
    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()
    love.graphics.draw(ground, -groundScroll, 0)
    love.graphics.draw(background, -backgroundScroll, 0)
    gStateMachine:render()
    push:finish()
end