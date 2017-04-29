local playerobj = {}
local marker = {}
objectid = {}
maxobjects = 500

function playerLeave ()
	setElementData ( source, "tempbuilder", false )
	setElementData ( source, "permbuilder", false )
end

function playerJoin ()
	setElementData ( source, "tempbuilder", false )
	setElementData ( source, "permbuilder", false )
	local pname = getClientName(source)
	if (pname == "example")
	or (pname == "example2")
	then
		setElementData ( source, "permbuilder", true )
	end
end

function thisResourceStart ()
	local players = getElementsByType ( "player" )
	for k,v in ipairs(players) do
		setElementData ( v, "tempbuilder", false )
		setElementData ( v, "permbuilder", false )
		local pname = getClientName(v)
	if (pname == "example")
	or (pname == "example2")
		then
			setElementData ( v, "permbuilder", true )
		end
	end
end

addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()), thisResourceStart )
addEventHandler ( "onPlayerJoin", getRootElement(), playerJoin )
addEventHandler ( "onPlayerQuit", getRootElement(), playerLeave )

function guestBuildPlayer ( player, commandName, player2nick )
if ( hasObjectPermissionTo ( player, "function.unbanSerial", true)) or (getElementData ( player, "permbuilder" ) == true) then
	local player2 = getPlayerFromNick ( player2nick )
	local player2n = getClientName ( player2 )
	if (getElementData ( player2, "tempbuilder" ) == false) then
		outputChatBox ( "#FFFF00"..player2n.." recieved map editor pass.", getRootElement(), 255, 255, 255, true )
		setElementData ( player2, "tempbuilder" , true )
	else
		outputChatBox ( "#FFFF00"..player2n.." map editor pass removed.", getRootElement(), 255, 255, 255, true )
		setElementData ( player2, "tempbuilder" , false )
	end
else 
	outputChatBox ( "You do not have permission to do that.", player )
end
end
addCommandHandler("guestb", guestBuildPlayer )

function createCurrentObject (player,cmd,objid)
if ( hasObjectPermissionTo ( player, "function.unbanSerial", true)) or (getElementData ( player, "permbuilder" ) == true) or (getElementData ( player, "tempbuilder" ) == true) then 
	if playerobj[player] then
		outputChatBox ( "You are already editing an object.  Please save or delete to make another.", player )
	else
		local x, y, z = getElementPosition(player)
		destroyMObj (player)
		playerobj[player] = createObject(tonumber(objid), x + 5, y + 5, z - 1)
		if marker[player] then destroyElement(marker[player]) end
		if playerobj[player] then
			marker[player] = createMarker ( x, y, z, "arrow", 5, 255, 255, 0, 255)
			attachElementToElement ( marker[player], playerobj[player], 0, 0, 10)
		else
			outputChatBox ( "" ..objid.. " does not appear to be a valid model ID.", player )
		end
	end
else 
	outputChatBox ( "You do not have permission to build.", player )
end
end
addCommandHandler( "mcreate", createCurrentObject )

function cloneCurrentObject (player, cmd, addx, addy, addz, addrx, addry, addrz)
if ( hasObjectPermissionTo ( player, "function.unbanSerial", true)) or (getElementData ( player, "permbuilder" ) == true) or (getElementData ( player, "tempbuilder" ) == true) then 
	if addx then 
		addx = tonumber(addx)
	else
		addx = 0
	end
	if addy then 
		addy = tonumber(addy)
	else
		addy = 0
	end
	if addz then 
		addz = tonumber(addz)
	else
		addz = 0
	end
	if addrx then 
		addrx = tonumber(addrx)
	else
		addrx = 0
	end
	if addry then 
		addry = tonumber(addry)
	else
		addry = 0
	end
	if addrz then 
		addrz = tonumber(addrz)
	else
		addrz = 0
	end
	if playerobj[player] then
		local x, y, z = getElementPosition(playerobj[player])
		local rx, ry, rz = getObjectRotation(playerobj[player])
		local model = getObjectModel ( playerobj[player] )
		saveObjID(player)
		playerobj[player] = createObject(model, x + addx, y + addy, z + addz, rx + addrx, ry + addry, rz + addrz)
	end
	if playerobj[player] then
		marker[player] = createMarker ( x, y, z, "arrow", 5, 255, 255, 0, 255)
		attachElementToElement ( marker[player], playerobj[player], 0, 0, 10)
	else
		outputChatBox ( "Failed to clone object.  Make sure you have one selected.", player )
	end
else 
	outputChatBox ( "You do not have permission to build.", player )
end
end
addCommandHandler( "mclone", cloneCurrentObject )

function stackCurrentObject (player, cmd, times, addx, addy, addz, addrx, addry, addrz)
if ( hasObjectPermissionTo ( player, "function.unbanSerial", true)) or (getElementData ( player, "permbuilder" ) == true) or (getElementData ( player, "tempbuilder" ) == true) then 
	if tonumber(times) < 50 and addx then
		times = tonumber(times)
		addx = tonumber(addx)
		if addy then 
			addy = tonumber(addy)
		else
			addy = 0
		end
		if addz then 
			addz = tonumber(addz)
		else
			addz = 0
		end
		if addrx then 
			addrx = tonumber(addrx)
		else	
			addrx = 0
		end
		if addry then 
			addry = tonumber(addry)
		else
			addry = 0
		end
		if addrz then 
			addrz = tonumber(addrz)
		else
			addrz = 0
		end
		if playerobj[player] then
			for i=0,times do
				local x, y, z = getElementPosition(playerobj[player])
				local rx, ry, rz = getObjectRotation(playerobj[player])
				local model = getObjectModel ( playerobj[player] )
				saveObjID(player)
				playerobj[player] = createObject(model, x + addx, y + addy, z + addz, rx + addrx, ry + addry, rz + addrz)
			end
		end
		if playerobj[player] then
			marker[player] = createMarker ( x, y, z, "arrow", 5, 255, 255, 0, 255)
			attachElementToElement ( marker[player], playerobj[player], 0, 0, 10)
		else
			outputChatBox ( "Failed to stack object.  Make sure you have one selected.", player )
		end
	else
		outputChatBox ( "Failed to stack object.  You can only stack up to 50 items at once.  Also make sure you at least specified an X value.", player )
	end
else 
	outputChatBox ( "You do not have permission to build.", player )
end
end
addCommandHandler( "mstack", stackCurrentObject )

function loopCurrentObject (player, cmd, pieces, radi, offset, rotaxis, loops, rota)
if ( hasObjectPermissionTo ( player, "function.unbanSerial", true)) or (getElementData ( player, "permbuilder" ) == true) or (getElementData ( player, "tempbuilder" ) == true) then 
	local angle
	local newi
	if loops then
		loops = tonumber(loops)
	else
		loops = 1
	end
	if rota then 
		rota = rota*(math.pi/180)
	else 
		rota = 0
	end
	if rotaxis == "x" or rotaxis == "-x" or rotaxis == "y" or rotaxis == "-y" then
	--do nothing
	else
		rotaxis = "x"
	end
	if radi and pieces and offset then
		radi = tonumber(radi)
		pieces = tonumber(pieces)
		offset = tonumber(offset)
		local spiralp = math.atan((offset/2)/(2*radi))/loops
		if playerobj[player] then
			local orx, ory, orz = getElementPosition(playerobj[player])
			newi = -1
			for i=0,pieces do
				local x, y, z = getElementPosition(playerobj[player])
				local rx, ry, rz = getObjectRotation(playerobj[player])
				local model = getObjectModel ( playerobj[player] )
				saveObjID(player)
				local weight = 1-(1/(pieces/2))*math.abs((pieces/2)-i)
				local radians = (i/pieces)*(2*math.pi)*loops
				local newx = orx + radi*math.sin(radians)*math.cos(rota)+(offset/2)*math.cos(radians/(2*loops))*-math.sin(rota)
				local newy = ory +(offset/2)*math.cos(radians/(2*loops))*math.cos(rota)+radi*math.sin(radians)*math.sin(rota)
				local newz = orz + radi*-math.cos(radians)
				angle = (((360/pieces)* loops )* newi)
				if angle <= 359.9999999999999999999999999 then
					newi = newi + 1
				end
				angle = (((360/pieces)* loops )* newi)
				if angle >= 360 then
					newi = -1
					angle = (((360/pieces)* loops )* newi)
				end
				if rotaxis == "x" then
					newrotx = angle
					newroty = ry --+ ((radians)-math.cos(rota)*spiralp*weight)
				elseif rotaxis == "-x" then
					newrotx = -angle
					newroty = ry --+ ((radians)-math.cos(rota)*spiralp*weight)
				elseif rotaxis == "y" then
					newrotx = rx --+ ((radians)-math.cos(rota)*spiralp*weight)
					newroty = angle
				elseif rotaxis == "-y" then
					newrotx = rx --+ ((radians)-math.cos(rota)*spiralp*weight)
					newroty = -angle
				end
				playerobj[player] = createObject(model, newx, newy, newz, newrotx, newroty, rz)
			end
		end
		if playerobj[player] then
			marker[player] = createMarker ( x, y, z, "arrow", 5, 255, 255, 0, 255)
			attachElementToElement ( marker[player], playerobj[player], 0, 0, 10)
		else
			outputChatBox ( "Failed to stack object.  Make sure you have one selected.", player )
		end
	else
		outputChatBox ( "Failed to make loop.  Use /mloop <radius> <pieces> <offset>", player )
	end
else 
	outputChatBox ( "You do not have permission to build.", player )
end
end
addCommandHandler( "mloop", loopCurrentObject )

function moveObjZ (player,cmd,newz)
if ( hasObjectPermissionTo ( player, "function.unbanSerial", true)) or (getElementData ( player, "permbuilder" ) == true) or (getElementData ( player, "tempbuilder" ) == true) then 
	if playerobj[player] then
		local x, y, z = getElementPosition(playerobj[player])
		moveObject ( playerobj[player], 200, x, y, z + tonumber(newz) )
	end
else 
	outputChatBox ( "You do not have permission to build.", player )
end
end
addCommandHandler( "oz", moveObjZ )

function moveObjX (player,cmd,newx)
if ( hasObjectPermissionTo ( player, "function.unbanSerial", true)) or (getElementData ( player, "permbuilder" ) == true) or (getElementData ( player, "tempbuilder" ) == true) then 
	if playerobj[player] then
		local x, y, z = getElementPosition(playerobj[player])
		moveObject ( playerobj[player], 200, x + tonumber(newx), y, z )
	end
else 
	outputChatBox ( "You do not have permission to build.", player )
end
end
addCommandHandler( "ox", moveObjX )

function moveObjY (player,cmd,newy)
if ( hasObjectPermissionTo ( player, "function.unbanSerial", true)) or (getElementData ( player, "permbuilder" ) == true) or (getElementData ( player, "tempbuilder" ) == true) then 
	if playerobj[player] then
		local x, y, z = getElementPosition(playerobj[player])
		moveObject ( playerobj[player], 200, x, y + tonumber(newy), z )
	end
else 
	outputChatBox ( "You do not have permission to build.", player )
end
end
addCommandHandler( "oy", moveObjY )

function moveRotZ (player,cmd,newrz)
if ( hasObjectPermissionTo ( player, "function.unbanSerial", true)) or (getElementData ( player, "permbuilder" ) == true) or (getElementData ( player, "tempbuilder" ) == true) then 
	if playerobj[player] then
		local x, y, z = getElementPosition(playerobj[player])
		moveObject ( playerobj[player], 200, x, y, z, 0, 0, tonumber(newrz) )
	end
else 
	outputChatBox ( "You do not have permission to build.", player )
end
end
addCommandHandler( "rz", moveRotZ )

function moveRotX (player,cmd,newrx)
if ( hasObjectPermissionTo ( player, "function.unbanSerial", true)) or (getElementData ( player, "permbuilder" ) == true) or (getElementData ( player, "tempbuilder" ) == true) then 
	if playerobj[player] then
		local x, y, z = getElementPosition(playerobj[player])
		moveObject ( playerobj[player], 200, x, y, z, tonumber(newrx), 0, 0 )
	end
else 
	outputChatBox ( "You do not have permission to build.", player )
end
end
addCommandHandler( "rx", moveRotX )

function moveRotY (player,cmd,newry)
if ( hasObjectPermissionTo ( player, "function.unbanSerial", true)) or (getElementData ( player, "permbuilder" ) == true) or (getElementData ( player, "tempbuilder" ) == true) then 
	if playerobj[player] then
		local x, y, z = getElementPosition(playerobj[player])
		moveObject ( playerobj[player], 200, x, y, z, 0, tonumber(newry), 0 )
	end
else 
	outputChatBox ( "You do not have permission to build.", player )
end
end
addCommandHandler( "ry", moveRotY )

function destroyMObj (player,cmd)
if ( hasObjectPermissionTo ( player, "function.unbanSerial", true)) or (getElementData ( player, "permbuilder" ) == true) or (getElementData ( player, "tempbuilder" ) == true) then 
	if playerobj[player] then
		for i=0,maxobjects do
			if objectid[i] == playerobj[player] then 
				local numstr = tostring(i)
				outputChatBox ( "Object ID deleted: " ..numstr.. "", player )
				local succeed = destroyElement(playerobj[player])
				if marker[player] then destroyElement(marker[player]) end
				objectid[i] = nil
				playerobj[player] = nil
				break
			end
		end
	end
	if marker[player] then destroyElement(marker[player]) end
	if playerobj[player] then destroyElement(playerobj[player])	end
	playerobj[player] = nil
else 
	outputChatBox ( "You do not have permission to build.", player )
end
end
addCommandHandler( "mdestroy", destroyMObj )

function openTheFile(objFile)
	local mapFile = fileOpen ( "objects.txt" )
	if not mapFile then
		outputChatBox ( "objects.txt not Found...")
		mapFile = fileCreate( "objects.txt" )
		fileWrite (mapFile, "--Objects Script Created\r\n\r\n")
		outputChatBox ( "File Created")
	end
	return mapFile
end

function commentFix ( comment )
	if not ( comment ) then comment = "na" end
return comment
end

function saveObjID ( player, cmd )
if ( hasObjectPermissionTo ( player, "function.unbanSerial", true)) or (getElementData ( player, "permbuilder" ) == true) or (getElementData ( player, "tempbuilder" ) == true) then 
	if playerobj[player] then
		for i=0,maxobjects do
			if objectid[i] == playerobj[player] then 
				if marker[player] then destroyElement(marker[player]) end
				local numstr = tostring(i)
				outputChatBox ( "Object saved as ID: " ..numstr.. "", player )
				playerobj[player] = nil
				break
			elseif objectid[i] then 
			--do nothing
			else
				objectid[i] = playerobj[player]
				if marker[player] then destroyElement(marker[player]) end
				local numstr = tostring(i)
				outputChatBox ( "Object saved as ID: " ..numstr.. "", player )
				playerobj[player] = nil
				break
			end
		end
	end
else 
	outputChatBox ( "You do not have permission to build.", player )
end
end
addCommandHandler( "msave", saveObjID )

function selectObject ( player, cmd, selid )
if ( hasObjectPermissionTo ( player, "function.unbanSerial", true)) or (getElementData ( player, "permbuilder" ) == true) or (getElementData ( player, "tempbuilder" ) == true) then 
	num = tonumber(selid)
	if playerobj[player] then
		saveObjID(player)
		outputChatBox ( "You were editing an object.  It was saved as ID: " ..selid.. "", player )
	end
	if objectid[num] then 
		playerobj[player] = objectid[num] 
		local x, y, z = getElementPosition(playerobj[player])
		if marker[player] then destroyElement(marker[player]) end
		marker[player] = createMarker ( x, y, z, "arrow", 5, 255, 255, 0, 255)
		attachElementToElement ( marker[player], playerobj[player], 0, 0, 10)
		outputChatBox ( "Object ID selected: " ..selid.. "", player )
	end
else 
	outputChatBox ( "You do not have permission to build.", player )
end
end
addCommandHandler( "msel", selectObject )

function getEndOFile(mapFile)
  local temp, endPos = fileGetPos ( mapFile )
  while not fileIsEOF ( mapFile ) do    
    fileRead ( mapFile, 500 )                      
  end
  endPos = fileGetPos ( mapFile )
  fileSetPos ( mapFile, temp )
  return endPos
end

function getObjInfo ( player)
if ( hasObjectPermissionTo ( player, "function.unbanSerial", true)) or (getElementData ( player, "permbuilder" ) == true) or (getElementData ( player, "tempbuilder" ) == true) then 
	if playerobj[player] then
		local model = getObjectModel (playerobj[player])
		local x, y, z = getElementPosition(playerobj[player])
		local rx, ry, rz = getObjectRotation(playerobj[player])
		outputChatBox ( "Object Info - Object Model ID: " .. model .. "", player)
		outputChatBox ( "Pos X: " .. x .. " Pos Y: " .. y .. " Pos Z: " .. z .. "", player)
		outputChatBox ( "Rot X: " .. rx .. " Rot Y: " .. ry .. " Rot Z: " .. rz .. "", player)
	else
		outputChatBox ( "You currently have no object selected.", player)
	end
else 
	outputChatBox ( "You do not have permission to build.", player )
end
end
addCommandHandler( "minfo", getObjInfo )

function saveObjPOS ( player, cmd, comment )
if ( hasObjectPermissionTo ( player, "function.unbanSerial", true)) or (getElementData ( player, "permbuilder" ) == true) or (getElementData ( player, "tempbuilder" ) == true) then 
	comment = commentFix ( comment )
	local model = getObjectModel ( playerobj[player] )
	local x, y, z = getElementPosition(playerobj[player])
	local rx, ry, rz = getObjectRotation(playerobj[player])
	local pname = getClientName(player)
	local objFile = fileOpen ( "objects.txt" )
	if objFile then
		local endPos = getEndOFile (objFile)
		fileSetPos(objFile, endPos)
	else
		outputChatBox ( "objects.txt not Found...")
		objFile = fileCreate( "objects.txt" )
		fileSetPos(objFile, 0)
		fileWrite (objFile, "--Objects Script Created Using OffRoader23's In Game Editor\r\n\r\n")
		outputChatBox ( "File Created")
	end
	fileWrite ( objFile, "createObject(" .. model .. ", " .. x .. ", " .. y .. ", " .. z .. ", " .. rx .. ", " .. ry .. ", " .. rz .. ") --" .. comment .. " " .. pname .. "\r\n")
	outputChatBox ( "Object Saved as: " ..comment.. "", player )
	fileClose ( objFile )
	saveObjID (player)
else 
	outputChatBox ( "You do not have permission to build.", player )
end
end
addCommandHandler( "saveobj", saveObjPOS )

function saveThisMap ( player, cmd, mapname )
if ( hasObjectPermissionTo ( player, "function.unbanSerial", true)) or (getElementData ( player, "permbuilder" ) == true)  then 
	if mapname then
		local madeFile = fileCreate("" ..mapname.. ".o23")                -- attempt to create a new file            
		fileWrite(madeFile, "--File Generated with OffRoader23's In-Game MTA DatchMatch Map Editor! \r\n \r\n")
		for i=0,maxobjects do
			if objectid[i] then
				local model = getObjectModel (objectid[i])
				local x, y, z = getElementPosition(objectid[i])
				local rx, ry, rz = getObjectRotation(objectid[i])
				fileWrite (madeFile, "objectid[" ..i.. "] = createObject(" .. model .. ", " .. x .. ", " .. y .. ", " .. z .. ", " .. rx .. ", " .. ry .. ", " .. rz .. ") \r\n")
			end
		end
		outputChatBox ( "Map saved as: " ..mapname.. "", player )
		fileClose ( madeFile )
	else
		outputChatBox ( "No map name specified.  Please use /savemap <name>", player )
	end
else 
	outputChatBox ( "You do not have permission to build.", player )
end
end
addCommandHandler( "savemap", saveThisMap )

function loadMapLua ( player, cmd, mapname )
if ( hasObjectPermissionTo ( player, "function.unbanSerial", true)) or (getElementData ( player, "permbuilder" ) == true)  then 
	if mapname then
		local mFile = fileOpen(""..mapname..".o23")  
		if mFile then   
			clearObjects (player)
			objectid = nil
			objectid = {}
			outputChatBox ( "Map loaded: " ..mapname.. "", player )  --output success
			local buffer            					-- temporary the whola lua file
			local filessize = fileGetSize (mFile) 		--get file size
			buffer = fileRead(mFile, filessize)         -- read the file length
			loadstring(buffer)()  						--load lua to string
			fileClose(mFile)         -- close the file once we're done with it
		else --if no such map
			outputChatBox ( "Map " ..mapname.. " failed to load.  Perhaps it doesn't exist?", player ) --output fail
		end 
	else
		outputChatBox ( "No map name specified.  Please use /loadmap <name>", player )
	end
else 
	outputChatBox ( "You do not have permission to build.", player )
end
end
addCommandHandler( "loadmap", loadMapLua )

function clearObjects (player)
if ( hasObjectPermissionTo ( player, "function.unbanSerial", true)) or (getElementData ( player, "permbuilder" ) == true)  then 
	for i=0,maxobjects do
		if objectid[i] then
			destroyElement(objectid[i])
		end
	end
	objectid = nil
	objectid = {}
	local players = getElementsByType ( "player" )
	for k,v in ipairs(players) do
		if marker[v] then destroyElement(marker[v]) end
		if playerobj[v] then destroyElement(playerobj[v]) end
		playerobj[v] = nil
	end
	if marker[player] then destroyElement(marker[player]) end
	if playerobj[player] then destroyElement(playerobj[player]) end
	playerobj[player] = nil
	outputChatBox ( "Map cleared.", player )
else 
	outputChatBox ( "You do not have permission to build.", player )
end
end
addCommandHandler( "mclear", clearObjects )