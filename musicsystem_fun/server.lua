local youtubeKey = ""  -- Your youtube API Key!
local soundcloudKey = "" -- Your soundcloud API Key! See more https://developers.soundcloud.com/
local maxResults = 25 -- How many results do you want? + results = + data to get and send to user = + bandwith

function result ( data, errno, source, src, key )
	if data and data ~= "ERROR" then
		triggerLatentClientEvent ( source, "song:sendTable", 40000, false, source, data, src, key )
		outputChatBox("LOADING RESULTS...", source, 0, 255, 0)
	else
		outputChatBox(tostring(data).." ERRID: "..tostring(errno) or "Unknown", source, 255, 0, 0)
	end
end

addEvent ( "search:database", true )
function searchMusic( song, src )
	if src == "Youtube" then
		fetchRemote ( "https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults="..tostring(maxResults).."&order=viewCount&q="..string.gsub(song, " ", "+").."&type=video&videoDefinition=any&key="..youtubeKey, result, "", false, client, src )
	elseif src == "Soundcloud" then
		fetchRemote ( "https://api.soundcloud.com/tracks/?q="..string.gsub(song, " ", "+").."&client_id="..soundcloudKey, result, "", false, client, src, soundcloudKey )
	elseif src == "vmuzice.com" then
		fetchRemote ( "http://vmuzice.com/mp3/"..string.gsub(song, " ", "+"), result, "", false, client, src )
	end
	outputChatBox("SEARCHING...", client, 255, 255, 0)
end
addEventHandler ( "search:database", root, searchMusic )

