AddCSLuaFile()

do
	local SoundNames = {}

	for i = 0, 6, 1 do
		SoundNames[#SoundNames + 1] = "^phx/explode0" .. i .. ".wav"
	end

	sound.Add({
		name = "Jihad.Explosion",
		channel = CHAN_AUTO,
		volume = 1.0,
		level = 120,
		pitch = {95, 110},
		sound = SoundNames
	})
end

if CLIENT then
	SWEP.Slot = 7
	SWEP.Icon = MaterialURL("https://sirfrancisbillard.github.io/billard-radio/images/ttt/icon_jihad.png")
	SWEP.EquipMenuData = {
		name = "Jihad Bomb",
		type = "item_weapon",
		desc = "Sacrifice your life for Allah."
	}
end

-- SWEP STUFF
SWEP.PrintName = "Jihad Bomb"
SWEP.Base = "weapon_tttbase"
SWEP.HoldType = "slam"
SWEP.Primary.Ammo = "none"
SWEP.Primary.Delay = 5
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.UseHands = true
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 54
SWEP.ViewModel = "models/weapons/cstrike/c_c4.mdl"
SWEP.WorldModel = "models/weapons/w_c4.mdl"

-- TTT CONFIGURATION
SWEP.Kind = WEAPON_EQUIP2
SWEP.AutoSpawnable = false
SWEP.CanBuy = {ROLE_TRAITOR}
SWEP.InLoadoutFor = nil
SWEP.LimitedStock = true
SWEP.AllowDrop = false
SWEP.NoSights = true

function SWEP:Reload()
	return false
end

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)

	util.PrecacheModel("models/Humans/Charple01.mdl")
	util.PrecacheModel("models/Humans/Charple02.mdl")
	util.PrecacheModel("models/Humans/Charple03.mdl")
	util.PrecacheModel("models/Humans/Charple04.mdl")
end

if SERVER then
	util.AddNetworkString("Jihad.ShowAnimation")
else
	net.Receive("Jihad.ShowAnimation", function(len)
		local ply = net.ReadEntity()
		ply:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_TAUNT_ZOMBIE, true)
	end)
end

function SWEP:PrimaryAttack()
	self:SetNextPrimaryFire(CurTime() + 2)

	if SERVER then
		net.Start("Jihad.ShowAnimation")
		net.WriteEntity(self.Owner)
		net.Broadcast()

		self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
		self.Owner:EmitSoundURL("https://sirfrancisbillard.github.io/billard-radio/sound/jihad/jihad_" .. math.random(2) .. ".mp3")

		local ply = self.Owner
		timer.Simple(1, function()
			if not IsValid(ply) or not ply:Alive() then return end
			SafeRemoveEntity(self)
			local pos = ply:GetPos()

			ParticleEffect("explosion_huge", pos, vector_up:Angle())
			ply:EmitSound(Sound("Jihad.Explosion"))

			util.Decal("Rollermine.Crater", pos, pos - Vector(0, 0, 500), ply)
			util.Decal("Scorch", pos, pos - Vector(0, 0, 500), ply)

			ply:SetModel("models/Humans/Charple0" .. math.random(1, 4) .. ".mdl")
			ply:SetColor(color_white)

			util.BlastDamage(ply, ply, pos, 1000, 230)

			timer.Simple(0.5, function()
				if not pos then return end

				PlaySoundURL("https://sirfrancisbillard.github.io/billard-radio/sound/jihad/islam.mp3", pos)
			end)
		end)
	end
end

function SWEP:SecondaryAttack()
	self:SetNextSecondaryFire(CurTime() + TTT_TAUNT_DELAY:GetInt())

	if SERVER then
		SendTaunt(self)
	end
end
