
local tra = ROLE_TRAITOR
local det = ROLE_DETECTIVE

-- more consistent than the default one
local function NewID()
	return 2 ^ (#EquipmentItems[det] + #EquipmentItems[tra])
end

hook.Add("InitPostEntity", "LiteTTT.CustomEquipment",function()
	if not EquipmentItems then return end
	EQUIP_JEST = NewID()
	table.insert(EquipmentItems[tra], {
		id = EQUIP_JEST
	})
end)
