MaxRocketPack = 1
RocketPack = 0

addCommandHandler("lbattery",
function(lp)
if RocketPack < MaxRocketPack then
	local RocketCount=0
	RocketPack=RocketPack+1
	local randomRockets=math.random(1,1)
	local x,y,z=getElementPosition(lp)
			triggerClientEvent(root, "startSilvesterRocket7", root, "finish7", xr, yr, zr, scale, r, g, b, a)
		local Rocket=createObject(1615,x,y,z-1,0,90,0)
	setTimer(function()
		local Rocket1=createObject(2024,x,y,z-7.5,90,0,0)
	setTimer(function()
	destroyElement(Rocket1)
end,22000,1)
end,1500,1)
	setTimer(function()
		local Rocket2=createObject(2024,x,y,z-6.5,90,0,0)
	setTimer(function()
	destroyElement(Rocket2)
end,21000,1)
end,2500,1)
	setTimer(function()
		triggerClientEvent(root, "startSilvesterRocket5", root, "start5", x, y, z)
	setTimer(function()
		local Rocket4=createObject(2024,x,y,z-5.5,90,0,0)
	setTimer(function()
	destroyElement(Rocket4)
end,20000,1)
end,6500,1)
	setTimer(function()
		local Rocket5=createObject(2024,x,y,z-4.5,90,0,0)
	setTimer(function()
	destroyElement(Rocket5)
end,18000,1)
end,7000,1)
		setTimer(function()
	setTimer(function()
		local Rocket7=createObject(2024,x,y,z-3.5,90,0,0)
	setTimer(function()
	destroyElement(Rocket7)
end,15500,1)
end,8000,1)
	setTimer(function()
		local Rocket8=createObject(2024,x,y,z-2.5,90,0,0)
	setTimer(function()
	destroyElement(Rocket8)
end,14000,1)
end,9500,1)
	setTimer(function()
	destroyElement(Rocket)
end,25500,1)
			RocketCount=RocketCount+1
			if RocketCount == randomRockets then
				RocketPack=RocketPack-1
			end
		end,18000,1)
	end,2016/math.random(1.0,4.5),randomRockets)
end
end)