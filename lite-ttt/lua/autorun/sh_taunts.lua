
TTT_TAUNT_DELAY = CreateConVar("ttt_taunt_delay", "6", {FCVAR_ARCHIVE}, "Time in seconds between taunting.")

if SERVER then
	util.AddNetworkString("PlaySyncedTaunt")
	util.AddNetworkString("PraiseSyncedAllah")

	function SendTaunt(ent)
		net.Start("PlaySyncedTaunt")
		net.WriteEntity(ent.Owner)
		net.WriteInt(math.random(1, 18), 6)
		net.Broadcast()
	end

	function PraiseAllah(ent)
		net.Start("PraiseSyncedAllah")
		net.WriteEntity(ent.Owner)
		net.WriteInt(math.random(1, 10), 5)
		net.Broadcast()
	end
else
	net.Receive("PlaySyncedTaunt", function(len)
		local origin = net.ReadEntity()
		local soundNum = net.ReadInt(6)
		if not IsValid(origin) then return end
		sound.PlayURL("https://sirfrancisbillard.github.io/billard-radio/sound/emotes/random_" .. soundNum .. ".mp3", "3d", function(station)
			if (IsValid(station)) then
				station:SetPos(origin:GetPos())
				station:Play()
			end
		end)
	end)

	net.Receive("PraiseSyncedAllah", function(len)
		local origin = net.ReadEntity()
		local soundNum = net.ReadInt(5)
		if not IsValid(origin) then return end
		sound.PlayURL("https://sirfrancisbillard.github.io/billard-radio/sound/allahu/akbar_" .. soundNum .. ".mp3", "3d", function(station)
			if (IsValid(station)) then
				station:SetPos(origin:GetPos())
				station:Play()
			end
		end)
	end)
end	
