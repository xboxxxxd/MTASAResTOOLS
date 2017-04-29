
function playRocketSound(typ, x, y, z)
	if typ == "start" then

		rocketStart=playSound3D("rocketsStart.mp3", x, y, z)
		setSoundMaxDistance(rocketStart, 175)
	elseif typ == "finish" then
		createEffect("shootlight",x,y,z)
		rocketFinish1=playSound3D("rocketsExpl.mp3", x, y, z)
		setSoundMaxDistance(rocketFinish1, 1250)
	end

end
addEvent("startSilvesterRocket", true)
addEventHandler("startSilvesterRocket", root, playRocketSound)