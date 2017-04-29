
function playRocketSound7(typ, x, y, z)
	if typ == "start7" then

		rocketStart7=playSound3D("Fountain5.mp3", x, y, z)
		setSoundMaxDistance(rocketStart7, 350)
	elseif typ == "finish7" then
		createEffect("shootlight",x,y,z)
		rocketFinish7=playSound3D("Fountain5.mp3", x, y, z)
		setSoundMaxDistance(rocketFinish7, 350)
	end

end
addEvent("startSilvesterRocket7", true)
addEventHandler("startSilvesterRocket7", root, playRocketSound7)