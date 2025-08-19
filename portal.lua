-- Portal "struct
local Portal = {}
Portal.__index = Portal

function Portal:new(x, y, id,  warp_to)
	local portal = {
		x = x,
		y = y,
		id = id,
		warp_to = warp_to
	}
	setmetatable(portal, Portal)
	return portal
end

function Portal:draw()
	love.graphics.setColor(0, 0, 1)
	love.graphics.circle("fill", self.x, self.y, 10)
end

function Portal:update(dt, player)
	local dx = player.x - self.x
    local dy = player.y - self.y
    local distSq = dx * dx + dy * dy
    local dist = math.sqrt(distSq)
    if dist < 15 then
    	
    	for _, portal in ipairs(portals) do
    		if portal.id == self.warp_to then
    			
    			local out_x = portal.x
    			local out_y = portal.y
    			
    			player:move_to(out_x + 50, out_y + 10)
    			player.landed = false
    			--player.x = out_x + 10
    			--player.y = out_y + 10
    		end
    	end
    end
end
	
return Portal
