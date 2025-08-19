-- Planet "struct"
local Planet = {}
Planet.__index = Planet

function Planet:new(x, y, radius, color, mass)
    local p = {
        x = x,
        y = y,
        radius = radius,
        color = color or {1, 1, 1},
        mass = mass or radius * 10
    }
    setmetatable(p, Planet)
    return p
end

function Planet:draw()
    love.graphics.setColor(self.color)
    love.graphics.circle("fill", self.x, self.y, self.radius)
end

return Planet
