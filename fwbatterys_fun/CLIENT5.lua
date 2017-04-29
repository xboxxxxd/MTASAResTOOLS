
function playRocketSound5(typ, x, y, z)
	if typ == "start5" then

		rocketStart5=playSound3D("Fountain5.mp3", x, y, z)
		setSoundMaxDistance(rocketStart5, 350)
	elseif typ == "finish5" then
		createEffect("shootlight",x,y,z)
		rocketFinish5=playSound3D("Fountain5.mp3", x, y, z)
		setSoundMaxDistance(rocketFinish5, 350)
	end

end
addEvent("startSilvesterRocket5", true)
addEventHandler("startSilvesterRocket5", root, playRocketSound5)