MaxRocketPack = 1
RocketPack = 0


addCommandHandler("cbattery",
function(lp)
if RocketPack < MaxRocketPack then
	local RocketCount=0
	RocketPack=RocketPack+1
	local randomRockets=math.random(15,30)
	local x,y,z=getElementPosition(lp)

	local Palett=createObject(1615,x,y,z-1,0,90,0)

	setTimer(function()

		local Rocket=createObject(3790,x,y,z-2,0,90,0)
		local flare=createObject(354,x,y,z)
		attachElements(flare,Rocket,0,0,-1)
		moveObject(Rocket,1600, x+math.random(0,15), y+math.random(0,25), z+math.random(300,350), 0, 0, math.random(17000,18000))
		triggerClientEvent(root, "startSilvesterRocket2", root, "start2", x, y, z)
		setTimer(function()
		
			local xr,yr,zr=getElementPosition(Rocket)
			createExplosion(xr,yr,zr,14,lp)
			destroyElement(Rocket)
			destroyElement(flare)
			if isElement(sign) then
				destroyElement(sign)
			end
			scale,r,g,b,a=math.random(2,4),math.random(0,255),math.random(0,255),math.random(0,255),math.random(100,200)
			sign=createMarker(xr,yr,zr,"corona",scale,r,g,b,a)
			triggerClientEvent(root, "startSilvesterRocket2", root, "finish2", xr, yr, zr, scale, r, g, b, a)
			
			RocketCount=RocketCount+1
			if RocketCount == randomRockets then
				destroyElement(Palett)
				destroyElement(sign)
				RocketPack=RocketPack-1
			end
		end,450,1)

	end,2016/math.random(1.0,3.5),randomRockets)
end
end)