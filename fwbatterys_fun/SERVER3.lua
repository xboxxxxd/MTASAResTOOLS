MaxRocketPack = 1
RocketPack = 0


addCommandHandler("dbattery",
function(lp)
if RocketPack < MaxRocketPack then
	local RocketCount=0
	RocketPack=RocketPack+1
	local randomRockets=math.random(20,30)
	local x,y,z=getElementPosition(lp)

	local Palett=createObject(1615,x,y,z-1,0,90,0)

	setTimer(function()

		local Rocket=createObject(3790,x,y,z-2,0,90,0)
		local flare=createObject(354,x,y,z)
		attachElements(flare,Rocket,0,0,-1)
		moveObject(Rocket,800, x+math.random(0,15), y+math.random(0,25), z+math.random(300,350), 0, 0, math.random(100,180))
		triggerClientEvent(root, "startSilvesterRocket3", root, "start3", x, y, z)
		setTimer(function()
		
			local xr,yr,zr=getElementPosition(Rocket)
			createExplosion(xr,yr,zr,2,lp)
			destroyElement(Rocket)
			destroyElement(flare)
			if isElement(sign) then
				destroyElement(sign)
			end
			scale,r,g,b,a=math.random(0,0),math.random(0,255),math.random(0,255),math.random(0,255),math.random(200,250)
			sign=createMarker(xr,yr,zr,"corona",scale,r,g,b,a)
			triggerClientEvent(root, "startSilvesterRocket3", root, "finish3", xr, yr, zr, scale, r, g, b, a)
			
			RocketCount=RocketCount+1
			if RocketCount == randomRockets then
				destroyElement(Palett)
				destroyElement(sign)
				RocketPack=RocketPack-1
			end
		end,60,1)
	end,math.random(856,1376)/math.random(1.0,5.5),randomRockets)
end
end)