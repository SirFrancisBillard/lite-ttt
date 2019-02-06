
do return end

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

hook.Add("EntityTakeDamage", "LiteTTT.HotHeels", function(target, dmginfo)
	if target:IsPlayer() and target.ShouldRemoveFallDamage then
		if dmginfo:IsFallDamage() then
			local explode = ents.Create( "env_explosion" )
			explode:SetPos( target:GetPos() )
			explode:SetOwner( target )
			explode:Spawn()
			explode:SetKeyValue( "iMagnitude", "100" )
			explode:Fire( "Explode", 0, 0 )
			explode:EmitSound( "weapon_AWP.Single", 400, 400 )
		end
		if dmginfo:IsFallDamage() or dmginfo:IsExplosionDamage() then
			dmginfo:SetDamage(0)		
		end
	end
end)
