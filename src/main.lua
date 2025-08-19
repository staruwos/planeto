local Galaxy = require("galaxy")
local Portal = require("portal")
local Planet = require("planet")
local Player = require("player")

-- Lists
portals = {}
player = nil
galaxy = nil

function love.load()
	love.window.setTitle("Planeto")
	love.window.setMode(800, 600)

	local screen_width, screen_height = love.graphics.getDimensions()

	-- add Galaxy
	galaxy = Galaxy:new()

	-- Add planets
	galaxy:add_planet(Planet:new(200, 300, 50, {1, 0, 0}))
	galaxy:add_planet(Planet:new(500, 300, 80, {0, 1, 0}))
	
	--table.insert(planets, Planet:new(200, 300, 50, {1, 0, 0}))
	--table.insert(planets, Planet:new(500, 300, 80, {0, 1, 0}))

	-- Add portals
	-- red planet portal
	table.insert(portals, Portal:new(200, 350, 1, 2))
	-- green planet portal
	table.insert(portals, Portal:new(500, 380, 2, 1))

	-- Spawn player
	player = Player:new(400, 100, 10, {1, 1, 0})
end

function love.update(dt)
	galaxy:update()
	-- portals:update(dt, player)
	player:update(dt, galaxy.planets)
	for _, portal in ipairs(portals) do
		portal:update(dt, player)
	end
end

function love.draw()
	galaxy:draw()
	

	for _, portal in ipairs(portals) do
		portal:draw()
	end
	player:draw()
	love.graphics.setColor(1, 1, 1)
end

