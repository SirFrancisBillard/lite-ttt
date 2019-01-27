
-- fuck that little c

hook.Add("PostGamemodeLoaded", "RemoveCustomEquipmentIcon",function()
	for k, v in pairs(weapons.GetList()) do
		local canBuy = v.CanBuy
		local class = v.ClassName
		print("class: " .. class)
		print("canbuy: " .. tostring(canBuy))
		if istable(canBuy) and table.HasValue(canBuy, ROLE_TRAITOR) then
			table.insert(DefaultEquipment[ROLE_TRAITOR], class)
		end
		if istable(canBuy) and table.HasValue(canBuy, ROLE_DETECTIVE) then
			table.insert(DefaultEquipment[ROLE_DETECTIVE], class)
		end
		table.insert(DefaultEquipment[ROLE_NONE], class)
	end
end)
