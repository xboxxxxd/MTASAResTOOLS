function centerWindow (center_window)
    local screenW, screenH = guiGetScreenSize()
    local windowW, windowH = guiGetSize(center_window, false)
    local x, y = (screenW - windowW) /2,(screenH - windowH) /2
    guiSetPosition(center_window, x, y, false)
end

--

local screenX, screenY = guiGetScreenSize()
local sound = false
local videosData = {}
local progress = 0
local musicWindow
local isDownloaded = false
local streamed = 0
local attempttoplay = 0
local link = ""

addEventHandler("onClientResourceStart", resourceRoot,
    function()
        musicWindow = guiCreateWindow(0, 0, 615, 490, "Search music", false)
		musicClose = guiCreateLabel(0, 0, 15, 15, "X", false, musicWindow)
		centerWindow(musicWindow)
		guiWindowSetSizable(musicWindow, false)
		guiSetVisible(musicWindow, false)
		--showCursor(false)

        musicSearch = guiCreateEdit(9, 22, 390, 29, "", false, musicWindow)
		musicSource = guiCreateComboBox(410, 26, 100, 100, "Youtube", false, musicWindow)
		guiComboBoxAddItem ( musicSource, "Youtube" )
		guiComboBoxAddItem ( musicSource, "Soundcloud" )
		guiComboBoxAddItem ( musicSource, "vmuzice.com" )
		musicButton = guiCreateButton(515, 22, 100, 29, "Search", false, musicWindow)
		--guiRadioButtonSetSelected(soloCheck,true)
		
		
        musicList = guiCreateGridList(10, 58, 595, 350, false, musicWindow)
		guiGridListSetSortingEnabled(musicList, false)
        guiGridListAddColumn(musicList, "Results", 0.7)
        guiGridListAddColumn(musicList, "Channel", 0.3)
		guiGridListAddColumn(musicList, "ID", 0.5)
		guiGridListAddColumn(musicList, "Source", 0.5)
		
		
		local labelID = guiCreateLabel(15, 417, 400, 29, "Play a direct URL here, youtube or mp3 ------------>", false, musicWindow)
		local hex = "FFFF0000"
		guiSetProperty(labelID, "TextColours", "tl:"..hex.." tr:"..hex.." bl:"..hex.." br:"..hex)
		guiSetFont(labelID, "default-bold-small")
		musicLink = guiCreateEdit(350, 412, 200, 29, "", false, musicWindow)
		musicPlay = guiCreateButton(555, 412, 50, 29, "➽", false, musicWindow)
		
		--musicLoad = guiCreateProgressBar( 9, 450, 515, 30, false, musicWindow)
		musicResume = guiCreateButton(575, 450, 30, 30, "➤", false, musicWindow)
		musicPause = guiCreateButton(540, 450, 30, 30, "||", false, musicWindow)
		guiSetFont(musicResume, "default-bold-small")
		guiSetFont(musicPause, "default-bold-small")
		guiSetEnabled(musicResume, false) 
		guiSetEnabled(musicPause, false)
		
		function search()
			if guiGetEnabled(musicButton) then
				local item = guiComboBoxGetSelected(musicSource)
				local src = item == -1 and "Youtube" or guiComboBoxGetItemText(musicSource, item)
				guiSetEnabled(musicButton, false)
				setTimer(guiSetEnabled, 5000, 1, musicButton, true)
				triggerServerEvent ( "search:database", localPlayer, guiGetText(musicSearch), src )
			end
		end
		addEventHandler("onClientGUIClick", musicButton, search, false)
		addEventHandler("onClientGUIAccepted", musicSearch, search, false)
		
		function directPlay()
			local editText = guiGetText(musicLink)
			link = editText
			if string.find(editText, "youtube") then
				link = "http://www.youtubeinmp3.com/fetch/?video="..editText
			end
			
			if isElement(sound) then
				stopSound(sound)
				removeEventHandler("onClientRender", root, updateInfo)
			end
			
			musicInfo = "00:00 - 00:00 | -"
			guiSetEnabled(musicResume, false) 
			guiSetEnabled(musicPause, false)
			
			
			sound = playSound(link)
			
			if isElement(sound) then
				outputChatBox("Loading song...!")
			else
				outputChatBox("ERROR")
			end
		end
		addEventHandler("onClientGUIClick", musicPlay, directPlay, false)
		addEventHandler("onClientGUIAccepted", musicLink, directPlay, false)
		
		function pauseSound()
			setSoundPaused(sound, true)
			tickPause = getTickCount()
		end
		addEventHandler("onClientGUIClick", musicPause, pauseSound, false)
		
		function resumeSound()
			setSoundPaused(sound, false)
			tick = tick + (getTickCount()-tickPause)
		end
		addEventHandler("onClientGUIClick", musicResume, resumeSound, false)
		
		addEventHandler("onClientGUIClick", musicWindow, 
			function(_, _, cx, cy)
				local x, y = guiGetPosition(source, false)
				if cx > x + 540 and cx < x + 598 and cy > y + 1 and cy < y + 15 then
					guiSetVisible(musicWindow, false)
					showCursor(false)
				end
			end
		, false)
    end
)

local _showCursor = showCursor
function showCursor(value)
	_showCursor(value)
	guiSetInputEnabled(value)
end

addCommandHandler("youtube",
function(_, arg1)
	if arg1 == "stop" then
		if isElement(sound) then
			stopSound(sound)
			outputChatBox("Music has been stopped!", 0, 0, 255)
		end
	else
		local value = not guiGetVisible(musicWindow)
		guiSetVisible(musicWindow, value)
		showCursor(value)
	end
end)

addEventHandler("onClientGUIDoubleClick", root,
function()
	if source == musicList then
		local row,column = guiGridListGetSelectedItem(musicList)
		if row ~= -1 then
			local id = guiGridListGetItemText(musicList, row, 3)
			local src = guiGridListGetItemText(musicList, row, 4)
			
			
			if src == "vmuzice.com" then
				link = id
			elseif src == "Youtube" then
				link = "http://www.youtubeinmp3.com/fetch/?video=https://www.youtube.com/watch?v="..tostring(id)
			elseif src == "Soundcloud" then
				link = id.."?client_id="..soundcloudkey
			end
			
			
			if isElement(sound) then
				stopSound(sound)
				removeEventHandler("onClientRender", root, updateInfo)
			end
			sound = playSound(link)
			
			if src == "Youtube" then
				setClipboard("https://www.youtube.com/watch?v="..tostring(id))
			elseif	src ~= "Soundcloud" then
				setClipboard(link)
			end
			guiSetEnabled(musicResume, false) 
			guiSetEnabled(musicPause, false)
			musicInfo = "00:00 - 00:00 | -"
			progress = 0
			songName = guiGridListGetItemText(musicList, row, 1)
			
			if isElement(sound) then
				outputChatBox("Loading song and copied to the clipboard...!", 0, 0, 255)
			end
		end
	end
end)

addEventHandler("onClientSoundStream", resourceRoot,
	function(valid, length)
		if source == sound then
			if valid then
				streamed = 0
				isDownloaded = false
				sLength = length
				tick = getTickCount()
				addEventHandler("onClientRender", root, updateInfo)
				outputChatBox("Use '/youtube stop' command to stop listening", 255, 255, 0)
				songName = songName or getSoundMetaTags(sound)["title"] or "Desconocido"
				if #songName > 40 then
					songName = string.sub(songName, 1, 40).."..."
				end
				if source == sound then guiSetEnabled(musicResume, true) guiSetEnabled(musicPause, true) end
				attempttoplay = 0
			elseif attempttoplay <= 3 then
				attempttoplay = attempttoplay + 1
				outputChatBox("Can't play that song! Trying again("..tostring(attempttoplay).."/3)..", 255, 0, 0)
				if isElement(sound) then
					stopSound(sound)
					removeEventHandler("onClientRender", root, updateInfo)
				end
				playSound(link)
			else
				attempttoplay = 0
				outputChatBox("Can't play that song!", 255, 0, 0)
			end
		end
	end
)

addEventHandler("onClientSoundFinishedDownload", resourceRoot,
	function(length)
		if source == sound then
			isDownloaded = true
			streamed = length / 1000
			outputChatBox("You can now skip forward", 0, 0, 255)
		end
	end
)

function updateInfo()
	if isElement(sound) then
		if not isSoundPaused(sound) then
			--Tiempo actual
			local tickNow = getTickCount()
			local milliseconds = tickNow-tick
			local sec = (milliseconds / 1000) % 60 ;
			local min = milliseconds / (1000*60);
			-- Duracion
			local secEnd = ( sLength % 60 )
			local minEnd = math.floor ( ( sLength % 3600 ) /60 )
			--Progress
			progress = ( (milliseconds/1000)* 510 ) / sLength
			-- guiProgressBarSetProgress(musicLoad, progress)
			
			musicInfo = string.format("%02d:%02d - %02d:%02d", min, sec, minEnd, secEnd).." | "..songName
		end
	else
		musicInfo = "00:00 - 00:00 | -"
		progress = 0
		removeEventHandler("onClientRender", root, updateInfo)
		guiSetEnabled(musicResume, false) 
		guiSetEnabled(musicPause, false)
	end
end

addEventHandler("onClientRender", root,
	function()
		local isOpen = guiGetVisible(musicWindow)
		if isOpen then
			local gx, gy = guiGetPosition(musicWindow, false)
			dxDrawRectangle(gx+9, gy+450, 515, 30, tocolor(255, 255, 255, 100), true)
			local cx, cy = getCursorPosition()
			cx, cy = cx * screenX, cy * screenY
			if isElement(sound) and cx > gx + 11.5 and cx < gx + 11.5 + 510 and cy > gy + 452.5 and cy < gy + 452.5 + 26 then
				--outputChatBox(tostring(cx - ( gx+11.5 )))
				local mWidth = cx - ( gx+11.5 )
				local width = isDownloaded and mWidth or math.min(mWidth, math.max(progress, ( streamed * 510 )/ sLength))
				dxDrawRectangle(gx+11.5, gy+452.5, width, 26, tocolor(255, 255, 255, 200), true)
			end
			
			--
			dxDrawRectangle(gx+11.5, gy+452.5, math.min(510, progress), 26, tocolor(255, 0, 0, 200), true)
			dxDrawText(musicInfo or "00:00 - 00:00 | -", gx*2+515, gy+457, 0, 0, tocolor(0, 0, 0, 255), 1.1, "default-bold", "center", _, false, false, true)
			dxDrawText("Close[X]", gx+540, gy+2, 0, 0, tocolor(255, 255, 255, 255), 1.1, "default-bold", _, _, false, false, true)
		end
	end
)

addEventHandler("onClientClick", root,
	function(button, state, cx, cy)
		if button == "left" and state == "down" and guiGetVisible(musicWindow) and isElement(sound) then
			local gx, gy = guiGetPosition(musicWindow, false)
			if cx > gx + 11.5 and cx < gx + 11.5 + 510 and cy > gy + 452.5 and cy < gy + 452.5 + 26 then
				local seconds = ( ( cx - (gx + 11.5) ) * sLength ) / 510
				local actualTime = getTickCount() - tick
				local actualSeconds = actualTime/1000
				
				if not isDownloaded then
					seconds = math.min(seconds, math.max(actualSeconds, streamed))
				end
				local diferencia = ( seconds * 1000 - actualTime )
				--if isDownloaded or diferencia < 0 or ( actualSeconds + diferencia / 1000 ) < streamed then
				setSoundPosition(sound, seconds)
				tick = tick - diferencia
				streamed =  actualSeconds > streamed and actualSeconds or streamed
			end
		end
	end
)

function refreshGrid()
	guiGridListClear(musicList)
	for i,v in ipairs(videosData) do
		local row = guiGridListAddRow(musicList)
		guiGridListSetItemText(musicList, row, 1, tostring(v[1]), false, false)
		guiGridListSetItemText(musicList, row, 2, tostring(v[2]), false, false)
		guiGridListSetItemText(musicList, row, 3, tostring(v[3]), false, false)
		guiGridListSetItemText(musicList, row, 4, tostring(v[4]), false, false)
	end
end

function addTable (data, src, key)
	src = src or "Youtube"
	
	if src == "vmuzice.com" then
		data = convert(src, data)
	elseif src == "Soundcloud" then
		data = convert(src, data)
		soundcloudkey = key
	end
	if not data then outputChatBox("There is no result!", 255, 0, 0) return end
	
	videosData = {}
	data = fromJSON(data)
	if not data then guiSetEnabled(musicButton, true) return end
	local subData = data["items"]
	for i, v in ipairs( subData ) do
		local title = v["snippet"]["title"]
		local canal = v["snippet"]["channelTitle"]
		local videoID = v["id"]["videoId"]
		table.insert(videosData, {tostring(title), tostring(canal), tostring(videoID), tostring(src)})
	end
	refreshGrid()
	--if #videosData == 0 then outputChatBox("Ups! No se han encontrado canciones, intenta con otro", 255, 0, 0)
	--else outputChatBox(videosData[1][1]) end
	guiSetEnabled(musicButton, true)
end
addEvent ( "song:sendTable", true )
addEventHandler ( "song:sendTable", root, addTable )
