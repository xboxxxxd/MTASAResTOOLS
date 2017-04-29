MaxRocketPack = 1
RocketPack = 0

addCommandHandler("fbattery",
function(lp)
if RocketPack < MaxRocketPack then
	local RocketCount=0
	RocketPack=RocketPack+1
	local randomRockets=math.random(135,150)
	local x,y,z=getElementPosition(lp)

	local Palett=createObject(1615,x,y,z-1,0,90,0)

	setTimer(function()

	setTimer(function()
		local Rocket=createObject(2020,x,y,z-2,0,-90,0)
		moveObject(Rocket,16000, x+math.random(0,30), y+math.random(0,25), z+math.random(300,350), 0, 0, math.random(17000,18000))
		triggerClientEvent(root, "startSilvesterRocket6", root, "start6", x, y, z)
	setTimer(function()
	destroyElement(Rocket)
end,1500,1)
end,4185,1)

	setTimer(function()
		local Rocket=createObject(2020,x,y,z-2,0,-90,0)
		moveObject(Rocket,16000, x+math.random(0,30), y+math.random(0,25), z+math.random(300,350), 0, 0, math.random(17000,18000))
		triggerClientEvent(root, "startSilvesterRocket6", root, "start6", x, y, z)
	setTimer(function()
	destroyElement(Rocket)
end,2100,1)
end,4430,1)

		local Rocket=createObject(2020,x,y,z-2,0,-90,0)
		moveObject(Rocket,16000, x+math.random(0,30), y+math.random(0,25), z+math.random(300,350), 0, 0, math.random(17000,18000))
		triggerClientEvent(root, "startSilvesterRocket6", root, "start6", x, y, z)
		setTimer(function()
			local xr,yr,zr=getElementPosition(Rocket)
			destroyElement(Rocket)
			RocketCount=RocketCount+1
			if RocketCount == randomRockets then
				destroyElement(Palett)
				RocketPack=RocketPack-1
			end
		end,5000,1)

	end,math.random(116,4116)/math.random(1.0,6.5),randomRockets)
end
end)