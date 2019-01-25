--[[
    A Simple Garry's mod drawing library
    Copyright (C) 2016 Bull [STEAM_0:0:42437032] [76561198045139792]
    Freely acquirable at https://github.com/bull29/b_draw-lib
    You can use this anywhere for any purpose as long as you acredit the work to the original author with this notice.
    Optionally, if you choose to use this within your own software, it would be much appreciated if you could inform me of it.
    I love to see what people have done with my code! :)
]]--

-- HEAVILY MODIFIED FOR TTT

file.CreateDir("downloaded_assets")

local exists = file.Exists
local write = file.Write
local fetch = http.Fetch
local crc = util.CRC

function MaterialURL(url)
	if not url then return "error.png" end

	local path = "downloaded_assets/" .. crc(url) .. ".png"

	if not exists(path, "DATA") then
		fetch(url, function(data)
			write(path, data)
		end)
	end

	return "data/" .. path
end
