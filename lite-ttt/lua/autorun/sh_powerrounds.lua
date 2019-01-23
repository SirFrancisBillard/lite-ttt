
if SERVER then
	util.AddNetworkString("TTT.DisplayPowerRound")
end

TTT_PowerRoundChance = 8
TTT_CurrentPowerRound = false

TTT_PowerRounds = {
	["railgun"] = {
		name = "Railguns Only",
		desc = "All guns have been replaced by Railguns.",
		PrepareRound = function()
			local ttt_weps = ents.TTT.GetSpawnableSWEPs()
			local ttt_ents = ents.TTT.GetSpawnableAmmo()
			for k, v in pairs(ents.GetAll()) do
				if IsValid(v) and (table.HasValue(ttt_weps, v:GetClass()) or table.HasValue(ttt_ents, v:GetClass())) then
					v:SetSolid(SOLID_NONE)

					local rent = ents.Create(table.HasValue(ttt_weps, v:GetClass()) and "weapon_ttt_railgun" or "item_box_buckshot_ttt")
					rent:SetPos(v:GetPos())
					rent:SetAngles(v:GetAngles())
					rent:Spawn()

					rent:Activate()
					rent:PhysWake()

					v:Remove()
				end
			end
		end
	},
	["war"] = {
		name = "War",
		desc = "Half traitors, half detectives.",
		BeginRound = function()
			local max = player.GetCount() / 2
			local tcount = 0
			for k, v in RandomPairs(player.GetAll()) do
				if tcount < max then
					v:SetRole(ROLE_TRAITOR)
					tcount = tcount + 1
				else
					v:SetRole(ROLE_DETECTIVE)
				end
				v:SetCredits(2)
			end
			SendFullStateUpdate() -- update everybody
		end
	},
}

if CLIENT then
	net.Receive("TTT.DisplayPowerRound", function(len)
		local round = net.ReadString()
		chat.AddText(Color(255, 0, 0), "POWER ROUND: ", TTT_PowerRounds[round].name)
		chat.AddText(Color(255, 0, 0), TTT_PowerRounds[round].desc)
	end)

	return -- no more client stuff past here
end

hook.Add("TTTPrepareRound", "PowerRounds.PrepareRound", function()
	if TTT_CurrentPowerRound then
		if isfunction(TTT_PowerRounds[TTT_CurrentPowerRound].PrepareRound) then
			TTT_PowerRounds[TTT_CurrentPowerRound].PrepareRound()
		end
		net.Start("TTT.DisplayPowerRound")
		net.WriteString(TTT_CurrentPowerRound)
		net.Broadcast()
	end
end)

hook.Add("TTTBeginRound", "PowerRounds.BeginRound", function()
	if TTT_CurrentPowerRound and isfunction(TTT_PowerRounds[TTT_CurrentPowerRound].BeginRound) then
		TTT_PowerRounds[TTT_CurrentPowerRound].BeginRound()
	end
end)

local ForceNextRound = false

concommand.Add("ttt_forcepowerround", function(ply, cmd, args)
	if not ply:IsAdmin() then return end
	local round = args[1]
	if not TTT_PowerRounds[round] then return end
	ForceNextRound = round
end)

hook.Add("TTTEndRound", "PowerRounds.EndRound", function(result)
	if TTT_CurrentPowerRound and isfunction(TTT_PowerRounds[TTT_CurrentPowerRound].EndRound) then
		TTT_PowerRounds[TTT_CurrentPowerRound].EndRound(result)
	end
	-- pick for next round
	if ForceNextRound and TTT_PowerRounds[ForceNextRound] then
		TTT_CurrentPowerRound = ForceNextRound
	else
		if math.random(TTT_PowerRoundChance) == TTT_PowerRoundChance then
			local x, y = table.Random(TTT_PowerRounds)
			TTT_CurrentPowerRound = y
		else
			TTT_CurrentPowerRound = false
		end
	end
end)


