
if SERVER then
	util.AddNetworkString("TTT.DisplayPowerRound")
end

TTT_PowerRoundChance = 5
TTT_CurrentPowerRound = false

TTT_PowerRounds = {
	["railgun"] = {
		name = "Railguns Only",
		desc = "All guns have been replaced by Railguns.",
		ReplaceGuns = "weapon_ttt_railgun",
		ReplaceAmmo = "item_box_buckshot_ttt"
	},
	["huge"] = {
		name = "H.U.G.E Only",
		desc = "Good luck, and may god have mercy on your soul.",
		ReplaceGuns = "weapon_zm_sledge",
		ReplaceAmmo = "weapon_zm_sledge"
	},
	["bloodbath"] = {
		name = "Blood Bath",
		desc = "Knives only, karma is disabled.",
		ReplaceGuns = "weapon_ttt_knife",
		ReplaceAmmo = "weapon_ttt_knife"
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
		if isstring(TTT_PowerRounds[TTT_CurrentPowerRound].ReplaceGuns) or isstring(TTT_PowerRounds[TTT_CurrentPowerRound].ReplaceAmmo) then
			local gun = TTT_PowerRounds[TTT_CurrentPowerRound].ReplaceGuns
			local ammo = TTT_PowerRounds[TTT_CurrentPowerRound].ReplaceAmmo
			timer.Simple(0.1, function()
				local function replace_ent(ent, class)
					ent:SetSolid(SOLID_NONE)

					local rent = ents.Create(class)
					rent:SetPos(ent:GetPos())
					rent:SetAngles(ent:GetAngles())
					rent:Spawn()

					rent:Activate()
					rent:PhysWake()

					ent:Remove()
				end
				if gun then
					for k, v in pairs(ents.FindByClass("weapon_*")) do
						if IsValid(v) and not IsValid(v:GetOwner()) and v:GetClass() ~= railgun then
							replace_ent(v, gun)
						end
					end
				end
				if ammo then
					for k, v in pairs(ents.FindByClass("item_*_ttt")) do
						if IsValid(v) and not IsValid(v:GetOwner()) and v:GetClass() ~= ammo then
							replace_ent(v, ammo)
						end
					end
				end
			end)
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
		ForceNextRound = false
	else
		if math.random(TTT_PowerRoundChance) == TTT_PowerRoundChance then
			local x, y = table.Random(TTT_PowerRounds)
			TTT_CurrentPowerRound = y
		else
			TTT_CurrentPowerRound = false
		end
	end
end)


