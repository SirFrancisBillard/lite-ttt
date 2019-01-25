
hook.Add("EntityFireBullets", "TTT.EarrapeGun", function(ent, data)
	if not IsValid(ent) or not ent:IsPlayer() then return end
	local wep = ent:GetActiveWeapon()
	if not IsValid(wep) or not wep.EarRape then return end
	data.Callback = function(atk, tr, dmg)
		PlaySoundURL("https://sirfrancisbillard.github.io/billard-radio/sound/earrape/earrape_" .. math.random(13) .. ".mp3", tr.HitPos)
	end
	return true	
end)

do return end

if SERVER then
	util.AddNetworkString("TTT.Earrape")

	hook.Add("EntityTakeDamage", "TTT.Earrape", function(ent, dmg)
		local atk = dmg:GetAttacker()
		local wep
		if IsValid(atk) and atk:IsPlayer() then
			wep = atk:GetActiveWeapon()
		end

		if IsValid(wep) and wep:IsWeapon() and IsValid(ent) and ent:IsPlayer() and wep.EarRape then
			timer.Simple(math.random(3, 5), function()
				if IsValid(ent) and ent:IsPlayer() and ent:Alive() then
					net.Start("TTT.Earrape")
					net.Send(ent)
				end
			end)
		end
	end)
else
	net.Receive("TTT.Earrape", function(len)
		sound.PlayURL("https://sirfrancisbillard.github.io/billard-radio/sound/earrape/earrape_" .. math.random(13) .. ".mp3", "", function(station)
			if IsValid(station) then
				station:Play()
			end
		end)
	end)
end
