
AddCSLuaFile()

SWEP.HoldType              = "pistol"

if CLIENT then
   SWEP.PrintName          = "Magnum"
   SWEP.Slot               = 1

   SWEP.ViewModelFlip      = false
   SWEP.ViewModelFOV       = 54

   SWEP.Icon               = "vgui/ttt/icon_deagle"
end

SWEP.Base                  = "weapon_tttbase"

SWEP.Kind                  = WEAPON_PISTOL

SWEP.Primary.Ammo          = "AlyxGun" -- hijack an ammo type we don't use otherwise
SWEP.Primary.Recoil        = 6
SWEP.Primary.Damage        = 37 * 2
SWEP.Primary.Delay         = 1
SWEP.Primary.Cone          = 0.02
SWEP.Primary.ClipSize      = 6
SWEP.Primary.ClipMax       = 36
SWEP.Primary.DefaultClip   = 6
SWEP.Primary.Automatic     = true
SWEP.Primary.Sound         = Sound( "Weapon_357.Single" )

SWEP.HeadshotMultiplier    = 4

SWEP.AutoSpawnable         = false
SWEP.Spawnable             = false
SWEP.AmmoEnt               = "item_ammo_revolver_ttt"

SWEP.UseHands              = true
SWEP.ViewModel             = "models/weapons/c_357.mdl"
SWEP.WorldModel            = "models/weapons/w_357.mdl"

SWEP.IronSightsPos	       = Vector(-4.64, -3.96, 0.68)
SWEP.IronSightsAng         = Vector(0.214, -0.1767, 0)

SWEP.HoldType = "pistol"
SWEP.ViewModelFOV = 54
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/c_357.mdl"
SWEP.WorldModel = "models/weapons/w_357.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true
SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_L_Clavicle"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(-30, 0, 0), angle = Angle(0, 0, 0) }
}

SWEP.IronSightsPos = Vector(-4.761, 0, 0.519)
SWEP.IronSightsAng = Vector(0.3, -0.301, 0)

SWEP.VElements = {}
