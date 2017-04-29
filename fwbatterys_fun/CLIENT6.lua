
function playRocketSound6(typ, x, y, z)
	if typ == "start6" then

		rocketStart6=playSound3D("rocketsExpl4_1.mp3", x, y, z)
		setSoundMaxDistance(rocketStart6, 450)
	elseif typ == "finish6" then
		createEffect("shootlight",x,y,z)
		rocketFinish6=playSound3D("cracklingEnd5.mp3", x, y, z)
		setSoundMaxDistance(rocketFinish6, 450)
	end

end
addEvent("startSilvesterRocket6", true)
addEventHandler("startSilvesterRocket6", root, playRocketSound6)