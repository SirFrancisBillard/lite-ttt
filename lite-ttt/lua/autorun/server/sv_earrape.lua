
hook.Add("EntityFireBullets", "TTT.EarrapeGun", function(ent, data)
	if not IsValid(ent) or not ent:IsPlayer() then return end
	local wep = ent:GetActiveWeapon()
	if not IsValid(wep) or not wep.EarRape then return end
	data.Callback = function(atk, tr, dmg)
		EmitSoundURL("https://sirfrancisbillard.github.io/billard-radio/sound/earrape/earrape_" .. math.random(13) .. ".mp3", tr.HitPos)
	end
	return true	
end)
