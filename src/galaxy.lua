local Galaxy = {}
Galaxy.__index = Galaxy

local Planet = require("planet")

screen_width, screen_height = love.graphics.getDimensions()

function Galaxy:new()
	local g = {
		stars = {},
		planets = {}
	}
	
	-- add stars to galaxy
	local max_stars = 100
	
	for i = 1, 100 do
		local x = love.math.random(5, screen_width - 5)
		local y = love.math.random(5, screen_height - 5)
		g.stars[i] = {x, y}
	end	
	
	setmetatable(g, Galaxy)
	return g
end

function Galaxy:update()
	for i = 1, 100 do
		-- move the stars
		self.stars[i] = {self.stars[i][1] + 1, self.stars[i][2] +1}
		
		-- reset stars if they are out of screen
		if self.stars[i][1] > screen_width then
			self.stars[i][1] = 0
		elseif self.stars[i][2] > screen_height then
			self.stars[i][2] = 0
		end
	end
end


function Galaxy:draw()
	-- draw stars
	for i, star in ipairs(self.stars) do
		love.graphics.points(star[1], star[2])
	end	
	
	-- draw planets
	for _, planet in ipairs(self.planets) do
		planet:draw()
	end

end

function Galaxy:add_planet(planet)
	table.insert(self.planets, planet)
end

return Galaxy
