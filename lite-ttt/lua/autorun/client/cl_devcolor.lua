
function DevColor(ply)
	if ply:SteamID() == "STEAM_0:1:52811933" then
		return Color(100, 240, 105, 255)
	end
end

hook.Add("TTTScoreboardColorForPlayer", "DevColor", DevColor)
