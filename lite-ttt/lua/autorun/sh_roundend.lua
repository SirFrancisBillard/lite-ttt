
if SERVER then
	util.AddNetworkString("TTT.RoundEndMusic")

	hook.Add("TTTEndRound", "TTT.RoundEndMusic", function()
		net.Start("TTT.RoundEndMusic")
		net.WriteInt(math.random(51), 7)
		net.Broadcast()
	end)
else
	net.Receive("TTT.RoundEndMusic", function(len)
		local id = net.ReadInt(7)
		if not gRoundEndMusic then return end
		sound.PlayURL("https://sirfrancisbillard.github.io/billard-radio/sound/roundend/" .. id .. ".mp3", "", function(station)
			if IsValid(station) then
				station:Play()
			end
		end)
	end)
end
