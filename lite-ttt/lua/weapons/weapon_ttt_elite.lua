AddCSLuaFile()

if CLIENT then
   SWEP.PrintName          = "Single Elite"
   SWEP.Slot               = 1

   SWEP.ViewModelFlip      = false
   SWEP.ViewModelFOV       = 54

   SWEP.Icon               = "vgui/ttt/icon_glock"
   SWEP.IconLetter         = "c"
end

SWEP.Base                  = "weapon_tttbase_sck"

SWEP.Primary.Recoil        = 1.2
SWEP.Primary.Damage        = 18
SWEP.Primary.Delay         = 0.1
SWEP.Primary.Cone          = 0.028
SWEP.Primary.ClipSize      = 15
SWEP.Primary.Automatic     = false
SWEP.Primary.DefaultClip   = 20
SWEP.Primary.ClipMax       = 60
SWEP.Primary.Ammo          = "Pistol"
SWEP.Primary.Sound         = Sound( "Weapon_Elite.Single" )

SWEP.AutoSpawnable         = true

SWEP.AmmoEnt               = "item_ammo_pistol_ttt"
SWEP.Kind                  = WEAPON_PISTOL

SWEP.HeadshotMultiplier    = 1.75

SWEP.HoldType = "pistol"
SWEP.ViewModelFOV = 54
SWEP.ViewModelFlip = true
SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/cstrike/c_pist_elite.mdl"
SWEP.WorldModel = "models/weapons/w_pist_elite_single.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true
SWEP.ViewModelBoneMods = {
	["v_weapon.elite_right"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(-30, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_R_Clavicle"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(-30, 0, 0), angle = Angle(0, 0, 0) }
}

SWEP.IronSightsPos = Vector(6.36, 0, 3)
SWEP.IronSightsAng = Vector(-0.201, 0.2, 0)

SWEP.VElements = {}
