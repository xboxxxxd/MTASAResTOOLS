MaxRocketPack = 1
RocketPack = 0

addCommandHandler("sbattery",
function(lp)
if RocketPack < MaxRocketPack then
	local RocketCount=0
	RocketPack=RocketPack+1
	local randomRockets=math.random(1,1)
	local x,y,z=getElementPosition(lp)

		local Rocket=createObject(1615,x,y,z-1,0,90,0)
		local flare=createObject(354,x,y,z)
		attachElements(flare,Rocket,0,0,0)

	setTimer(function()
		triggerClientEvent(root, "startSilvesterRocket1", root, "start1", x, y, z)

		setTimer(function()
		
			local xr,yr,zr=getElementPosition(Rocket)
			triggerClientEvent(root, "startSilvesterRocket1", root, "finish1", xr, yr, zr, scale, r, g, b, a)
			
			destroyElement(flare)

			RocketCount=RocketCount+1
			if RocketCount == randomRockets then
				destroyElement(Rocket)
				RocketPack=RocketPack-1
			end
		end,9500,1)

	end,2016/math.random(1.0,2.5),randomRockets)
end
end)