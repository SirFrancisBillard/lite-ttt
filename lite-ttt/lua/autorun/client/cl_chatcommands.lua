
local White = Color(255, 255, 255)
local Red = Color(255, 0, 0)
local Green = Color(0, 255, 0)

local GreenBlue = Color(100, 100, 255)
local BlueGreen = Color(100, 255, 100)

local ChatCommands = {
	["!music"] = function()
		if gRoundEndMusic == nil then gRoundEndMusic = false end
		gRoundEndMusic = not gRoundEndMusic
		local on = gRoundEndMusic
		chat.AddText(White, "Round end music is now ", on and Green or Red, on and "enabled" or "disabled", White, ".")
	end,
	["!hints"] = function()
		if gShowChatHints == nil then gShowChatHints = true end
		gShowChatHints = not gShowChatHints
		local on = gShowChatHints
		chat.AddText(White, "Chat hints are now ", on and Green or Red, on and "enabled" or "disabled", White, ".")
	end,
	["!headshot"] = function()
		if gPlayHeadshotSound == nil then gPlayHeadshotSound = true end
		gPlayHeadshotSound = not gPlayHeadshotSound
		local on = gPlayHeadshotSound
		chat.AddText(White, "Headshot sound now ", on and Green or Red, on and "enabled" or "disabled", White, ".")
	end,
	["!vip"] = function()
		if not file.Exists("ttt_vip", "DATA") then
			file.CreateDir("ttt_vip")
		end
		if not file.Exists("ttt_vip/vip.txt", "DATA") then
			file.Write("ttt_vip/vip.txt", "yes")
			net.Start("MakeMeVIP")
			net.SendToServer()
		end
	end,
	["!hitsound"] = function()
		local frame = Derma_StringRequest("Hitsound", "Enter a file/URL to use as your hitsound.", "hitmarkers/mlg.wav", function(text)
			gHitsound = text
			chat.AddText(color_white, "Hitsound set to ", Color(0, 255, 0), text, color_white, ".")
		end, function()
			chat.AddText(color_white, "Hitsound is still ", Color(0, 255, 0), gHitsound, color_white, ".")
		end)
	end
}

hook.Add("OnPlayerChat", "ClientSidedChatCommands", function(ply, strText, bTeam, bDead)
	if ply ~= LocalPlayer() then return end

	local func = ChatCommands[string.lower(strText)]
	if isfunction(func) then
		func()
		return true
	end
end)
