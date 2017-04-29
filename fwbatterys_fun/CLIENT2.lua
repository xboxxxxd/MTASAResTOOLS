
function playRocketSound2(typ, x, y, z)
	if typ == "start2" then
	elseif typ == "finish2" then
		createEffect("shootlight",x,y,z)
		rocketFinish2=playSound3D("rocketsExpl2.mp3", x, y, z)
		setSoundMaxDistance(rocketFinish2, 1250)
		rocketFinish2=playSound3D("rocketsExpl2_1.mp3", x, y, z)
		setSoundMaxDistance(rocketFinish2, 1250)
	end

end
addEvent("startSilvesterRocket2", true)
addEventHandler("startSilvesterRocket2", root, playRocketSound2)