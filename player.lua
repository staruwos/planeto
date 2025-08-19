-- Player "struct"
local Player = {}
Player.__index = Player

function Player:new(x, y, radius, color)
    local pl = {
        x = x,
        y = y,
        radius = radius,
        color = color or {1, 1, 0},
        vx = 0,
        vy = 0,
        mass = 1,
        landed = false,
        landedPlanet = nil,
        angle = 0 -- angle around planet when landed
    }
    setmetatable(pl, Player)
    return pl
end

function Player:update(dt, planets)
    local G = 1000

    if self.landed then
        -- Move around planet using left/right
        if love.keyboard.isDown("left") then
            self.angle = self.angle - 1.5 * dt
        elseif love.keyboard.isDown("right") then
            self.angle = self.angle + 1.5 * dt
        end

        -- Update position based on angle
        if self.landedPlanet then
            local p = self.landedPlanet
            local distanceFromCenter = p.radius + self.radius
            self.x = p.x + math.cos(self.angle) * distanceFromCenter
            self.y = p.y + math.sin(self.angle) * distanceFromCenter
        end

        -- Option to "jump" off planet
        if love.keyboard.isDown("space") then
            self.landed = false
            self.landedPlanet = nil
            -- Give small upward velocity from surface
            self.vx = math.cos(self.angle) * 50
            self.vy = math.sin(self.angle) * 50
        end
        return
    end

    -- If not landed, apply gravity
    for _, planet in ipairs(planets) do
        local dx = planet.x - self.x
        local dy = planet.y - self.y
        local distSq = dx * dx + dy * dy
        local dist = math.sqrt(distSq)

        -- Collision -> Land
        if dist < self.radius + planet.radius then
            self.landed = true
            self.landedPlanet = planet
            self.angle = math.atan2(self.y - planet.y, self.x - planet.x)
            self.vx = 0
            self.vy = 0
            return
        else
            if dist > 0 then
                local force = G * (self.mass * planet.mass) / distSq
                local nx = dx / dist
                local ny = dy / dist
                self.vx = self.vx + (force / self.mass) * nx * dt
                self.vy = self.vy + (force / self.mass) * ny * dt
            end
        end
    end

    -- Update position when flying
    self.x = self.x + self.vx * dt
    self.y = self.y + self.vy * dt
end

function Player:draw()
    love.graphics.setColor(self.color)
    love.graphics.circle("fill", self.x, self.y, self.radius)
end

function Player:move_to(x, y)
	self.x = x
	self.y = y
end

return Player
