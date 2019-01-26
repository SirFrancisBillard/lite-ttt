
util.AddNetworkString("MakeMeVIP")

net.Receive("MakeMeVIP",function(len, ply)
	if not file.Exists("ttt_vip", "DATA") then
		file.CreateDir("ttt_vip")
	end
	local path = "ttt_vip/" .. tostring(ply:SteamID64()) .. ".txt"
	if not file.Exists(path, "DATA") then
		file.Write(path, "yes")
		ply:ChatPrint("You are now a VIP. That's all you had to do!")
	else
		ply:ChatPrint("You are already a VIP!")
	end
end)


