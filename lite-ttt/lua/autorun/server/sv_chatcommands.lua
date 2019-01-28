
local White = Color(255, 255, 255)
local Red = Color(255, 0, 0)
local Green = Color(0, 255, 0)

local GreenBlue = Color(100, 100, 255)
local BlueGreen = Color(100, 255, 100)

local ChatCommands = {
	["!credits"] = function(ply)
		ply:AddCredits(10)
	end,
	["!traitor"] = function(ply)
		ply:SetRole(ROLE_TRAITOR)
		SendFullStateUpdate()
	end,
	["!detective"] = function(ply)
		ply:SetRole(ROLE_DETECTIVE)
		SendFullStateUpdate()
	end,
	["!innocent"] = function(ply)
		ply:SetRole(ROLE_INNOCENT)
		SendFullStateUpdate()
	end,
	["!respawn"] = function(ply)
		ply:SetRole(ROLE_INNOCENT)
		ply:UnSpectate()
		ply:SetTeam(TEAM_TERROR)
		ply:StripAll()
		ply:Spawn()
		SendFullStateUpdate()
	end,
	["!radar"] = function(ply)
		ply:AddEquipmentItem(EQUIP_RADAR)
		timer.Simple(1, function()
			if not IsValid(ply) or not ply:IsPlayer() then return end
			ply:ConCommand("ttt_radar_scan")
		end)
	end,
}

hook.Add("PlayerSay", "ServerSidedChatCommands", function(ply, txt)
	if not ply:IsAdmin() then return end

	local func = ChatCommands[string.lower(txt)]
	if isfunction(func) then
		func(ply)
		return ""
	end
end)
