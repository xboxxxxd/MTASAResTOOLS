local function createXMLFile ( xmlData ) 
    local number = 0 
	
	-- this loop will terminate on its own once a number is found which has no file with that specific number
	while ( fileExists (number) ) do  -- if a file with this number already exists then
	    number = number + 1 -- increase the number 
	end 
	
	local xmlName = tostring ( number )..".xml"
		local hFile = fileCreate( xmlName )
		fileWrite(hFile, xmlData )
		fileClose(hFile)
		
	return xmlName
end


print = outputChatBox
function convert(src, data)
	if src == "Soundcloud" then
		local json = fromJSON("["..data.."]")
		local items = {	["items"] = {} }
		for i, v in ipairs(json) do
			table.insert(items["items"],
				{ 	["snippet"] = { ["title"] = v["title"], ["channelTitle"] = v["user"]["username"] },
					["id"] = { ["videoId"] = v["stream_url"] }
				}
			)
		end
		return toJSON(items)
		
	elseif src == "vmuzice.com" then
		
		data = utf8.gsub(data, "%s&ndash;%s", "")
		
		local _,str2 = string.find(data,"</ul>")
		if str2 then
			data = string.sub(data, str2, #data)
		end
		
		--De nuevo
		local str1 = string.find(data, "<ul>")
		_,str2 = string.find(data,"</ul>")
		
		if not str1 or not str2 then
			return false
		end 
		data = string.sub(data, str1, str2)
		--
		
		local filePath = createXMLFile (data)
		
		local xml = xmlLoadFile(filePath)
		local items = {	["items"] = {} }

		for _,node in pairs(xmlNodeGetChildren(xml)) do 
			local songName
			local artist
			local url
			local currentAttribute = xmlNodeGetAttribute(node,"class")
				
				if currentAttribute == "x-track" then

						for i, div in pairs(xmlNodeGetChildren(node)) do
							local child = xmlNodeGetChildren(div)
							if xmlNodeGetName(child[1]) == "span" then
								local artistNode = xmlNodeGetChildren(child[1], 0)
								artist = xmlNodeGetValue(artistNode)
								xmlDestroyNode(artistNode)
								songName = xmlNodeGetValue(child[1])
								
							elseif xmlNodeGetName(child[2]) == "a" then
								url = xmlNodeGetAttribute(child[2],"data-url")
							end
						end
					table.insert(items["items"], 
						{ 	["snippet"] = { ["title"] = tostring(songName), ["channelTitle"] = tostring(artist) }, 
							["id"] = { ["videoId"] = tostring(url) } 
						}
					)
				end
		end
		
		xmlUnloadFile(xml)
		fileDelete(filePath)
		
		return toJSON(items)
	end
end