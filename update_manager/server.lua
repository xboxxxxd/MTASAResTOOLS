function script_updateDatabase()
	resources = getResources()
	outputDebugString("RU: Starting to update resource database.")
	database = xmlCreateFile("database.xml","UpdateDatabase")
	xmlSaveFile(database)
	xmlUnloadFile(database)
	for rKey,resource in ipairs(resources) do
		checkResourceUpdate(resource)
	end
	return true
end

function checkResourceUpdate(resource)
	name = getResourceName(resource)
	outputDebugString("RU: Starting the searching for an update for " ..name)
	version = getResourceInfo(resource,"version")
	if (version == false) then
		outputDebugString("RU: Version isn't listed inside resource, can't search for updates.")
	else 
		outputDebugString("RU: Starting web request for " ..name)
		updateCall = callRemote("http://community.mtasa.com/mta/resources.php",function(n,v) insertUpdateResultToDatabase(n,v,resource) end,"version",string.lower(name))
	end
	return true
end

function insertUpdateResultToDatabase(name,version,resource)
	outputDebugString("RU: Got result from community: " ..name.. "; " ..version.. "; " ..getResourceInfo(resource,"version"))
	database = xmlLoadFile("database.xml")
	rnode = xmlCreateChild(database,"resource")
	xmlNodeSetAttribute(rnode,"name",getResourceName(resource))
	version = tostring(version)
	xmlNodeSetAttribute(rnode,"version",version)
	xmlSaveFile(database)
	xmlUnloadFile(database)
	return true
end

function script_getUpdatesAvailable()
	anyUpdate = false
	database = xmlLoadFile("database.xml")
	Num = 0
	while (xmlFindChild(database,"resource",Num)) do
		rnode = xmlFindChild(database,"resource",Num)
		name = xmlNodeGetAttribute(rnode,"name")
		updateversion = xmlNodeGetAttribute(rnode,"version")
		localversion = getResourceInfo(getResourceFromName(name),"version")
		if (localversion) and (updateversion) and (updateversion ~= 0) and (updateversion ~= "0.0") then
			update = false
			if (parseVersion(localversion) < parseVersion(updateversion)) then
				update = true
			end
			if (update) then
				anyUpdate = true
				outputDebugString("There is an update available for " ..name.. ". Current version: " ..localversion.. "; New version: " ..updateversion)
			end
		end
		Num = Num + 1
	end
	if (anyUpdate == false) then
		outputDebugString("All your resources are fully up to date!")
	end
	xmlUnloadFile(database)
	return true
end

function parseVersion(version)
	sversion = split(version,string.byte("."));
	i = 0
	if (sversion) then
		for k,v in ipairs(sversion) do
			i = i + 1
		end
	end
	i = i - 1
	if (i == -1) then
		outputDebugString("-1 detected.")
	elseif (i == 0) then
		version = version.. ".0.0"
	elseif (i == 1) then
		version = version.. ".0"
	end
	version = version:gsub("%.","")
	return version
end

function command_UpdateResource(player,cmd,name)
	database = xmlCreateFile("database.xml","UpdateDatabase")
	xmlSaveFile(database)
	xmlUnloadFile(database)
	checkResourceUpdate(getResourceFromName(name))
end

addCommandHandler("checkforupdates",script_updateDatabase)
addCommandHandler("getupdatesavailable",script_getUpdatesAvailable)
addCommandHandler("updateresource",command_UpdateResource)

--REMOTE FUNCTIONS
function getUpdatesAvailable()
	updates = {}
	database = xmlLoadFile("database.xml")
	Num = 0
	uNum = 1
	while (xmlFindChild(database,"resource",Num)) do
		rnode = xmlFindChild(database,"resource",Num)
		name = xmlNodeGetAttribute(rnode,"name")
		updateversion = xmlNodeGetAttribute(rnode,"version")
		localversion = getResourceInfo(getResourceFromName(name),"version")
		if (localversion) and (updateversion) and (updateversion ~= 0) and (updateversion ~= "0.0") then
			update = false
			if (parseVersion(localversion) < parseVersion(updateversion)) then
				update = true
			end
			if (update) then
				updates[uNum] = {}
				updates[uNum]['name'] = name
				updates[uNum]['localversion'] = localversion
				updates[uNum]['updateversion'] = updateversion
				uNum = uNum + 1
			end
		end
		Num = Num + 1
	end
	xmlUnloadFile(database)
	return updates
end

function updateDatabase()
	if (script_updateDatabase()) then
		return true
	else
		return false
	end
end