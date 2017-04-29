
function playRocketSound3(typ, x, y, z)
	if typ == "start3" then
	elseif typ == "finish3" then
		createEffect("shootlight",x,y,z)
		rocketFinish3=playSound3D("rocketsExpl3.mp3", x, y, z)
		setSoundMaxDistance(rocketFinish3, 1250)
		rocketFinish3=playSound3D("rocketsExpl3_1.mp3", x, y, z)
		setSoundMaxDistance(rocketFinish3, 1250)
	end

end
addEvent("startSilvesterRocket3", true)
addEventHandler("startSilvesterRocket3", root, playRocketSound3)