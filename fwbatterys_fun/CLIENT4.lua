
function playRocketSound4(typ, x, y, z)
	if typ == "start4" then
		createEffect("shootlight",x,y,z)
		rocketStart4=playSound3D("rocketsExpl4.mp3", x, y, z)
		setSoundMaxDistance(rocketStart4, 125)
	elseif typ == "finish4" then
		rocketFinish4=playSound3D("rocketsExpl4_1.mp3", x, y, z)
		setSoundMaxDistance(rocketFinish4, 1250)
	end

end
addEvent("startSilvesterRocket4", true)
addEventHandler("startSilvesterRocket4", root, playRocketSound4)