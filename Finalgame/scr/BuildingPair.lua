BuildingPair = Class{}

local GAP_HEIGHT =  math.random(80,250)

function BuildingPair:init(y)
    self.scored = false
    self.x = VIRTUAL_WIDTH + 32
    self.y = y
    self.buildings = {
        ['upper'] = Building('top', self.y),
        ['lower'] = Building('bottom', self.y + BUILDING_HEIGHT + GAP_HEIGHT)
    }
    self.remove = false
end

function BuildingPair:update(dt)
    if self.x > -BUILDING_WIDTH then
        self.x = self.x - PIPE_SPEED * dt
        self.buildings['lower'].x = self.x
        self.buildings['upper'].x = self.x
        self.y = self.y + 1
    else
        self.remove = true
    end
end

function BuildingPair:render()
    for l, building in pairs(self.buildings) do
        building:render()
    end
end