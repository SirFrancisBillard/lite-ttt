
AddCSLuaFile()

SWEP.HoldType           = "grenade"

if CLIENT then
   SWEP.PrintName       = "Flashbang"
   SWEP.Slot            = 3

   SWEP.ViewModelFlip   = false
   SWEP.ViewModelFOV    = 54

   SWEP.EquipMenuData = {
      type = "item_weapon",
      desc = "Blinding grenade, lasts 10 seconds."
   };

   SWEP.Icon            = "vgui/ttt/icon_nades"
   SWEP.IconLetter      = "h"
end

SWEP.Base = "weapon_tttbasegrenade"

SWEP.Kind = WEAPON_NADE
SWEP.CanBuy = {ROLE_DETECTIVE, ROLE_TRAITOR}

SWEP.Spawnable          = true
SWEP.AutoSpawnable      = true

SWEP.UseHands           = true
SWEP.ViewModel          = "models/weapons/cstrike/c_eq_flashbang.mdl"
SWEP.WorldModel         = "models/weapons/w_eq_flashbang.mdl"

SWEP.Weight             = 5

function SWEP:GetGrenadeName()
   return "ttt_flashbang_proj"
end
