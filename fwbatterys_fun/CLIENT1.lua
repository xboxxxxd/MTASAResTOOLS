
function playRocketSound1(typ, x, y, z)
	if typ == "start1" then

		rocketStart1=playSound3D("cracklingStart5.mp3", x, y, z)
		setSoundMaxDistance(rocketStart1, 175)
	elseif typ == "finish" then
		createEffect("shootlight",x,y,z)
		rocketFinish1=playSound3D("cracklingEnd5.mp3", x, y, z)
		setSoundMaxDistance(rocketFinish1, 1250)
	end

end
addEvent("startSilvesterRocket1", true)
addEventHandler("startSilvesterRocket1", root, playRocketSound1)