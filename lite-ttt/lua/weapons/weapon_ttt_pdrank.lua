AddCSLuaFile()

if CLIENT then
    SWEP.PrintName = "Lean"
    SWEP.Slot = 6

    SWEP.EquipMenuData = {
        type = "item_weapon",
        name = "Lean",
        desc = "Heals you for 75 health.\nSingle use."
    }

    SWEP.Icon = MaterialURL("https://sirfrancisbillard.github.io/billard-radio/images/ttt/icon_pdrank.png")
end

SWEP.Base = "weapon_tttbase"

SWEP.Primary.Ammo = "None"
SWEP.Primary.Recoil = 0.6
SWEP.Primary.Damage = 75
SWEP.Primary.Delay = 0.2
SWEP.Primary.Cone = 0.01
SWEP.Primary.ClipSize = -1
SWEP.Primary.Automatic = true
SWEP.Primary.DefaultClip = -1
SWEP.Primary.ClipMax = -1
SWEP.Primary.Sound = Sound("npc/barnacle/barnacle_gulp1.wav")

SWEP.Kind = WEAPON_EQUIP
SWEP.CanBuy = {ROLE_TRAITOR}

SWEP.HoldType = "slam"
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/c_grenade.mdl"
SWEP.WorldModel = "models/weapons/w_grenade.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = false

SWEP.ViewModelBoneMods = {
	["ValveBiped.Grenade_body"] = { scale = Vector(0, 0, 0), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_R_Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-13.275, -3.847, 32.747) }
}

SWEP.VElements = {
	["juice"] = { type = "Model", model = "models/props_phx/construct/plastic/plastic_angle_360.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.888, 2.559, -3.166), angle = Angle(0, 0, 0), size = Vector(0.034, 0.034, 0.034), color = Color(130, 0, 255, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["cup"] = { type = "Model", model = "models/props_junk/terracotta01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.051, 2.542, 1.039), angle = Angle(0, 0, 180), size = Vector(0.2, 0.2, 0.344), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["juice"] = { type = "Model", model = "models/props_phx/construct/plastic/plastic_angle_360.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.247, 2.033, -3.626), angle = Angle(-0.294, -4.694, 29.368), size = Vector(0.034, 0.034, 0.034), color = Color(130, 0, 255, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["cup"] = { type = "Model", model = "models/props_junk/terracotta01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.505, 4.094, -0.105), angle = Angle(0, 0, -150.223), size = Vector(0.2, 0.2, 0.344), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} }
}

function SWEP:Deploy()
    self:SendWeaponAnim(ACT_VM_DEPLOY)
    self.Drinking = false
end

function SWEP:PrimaryAttack()
    if self.Drinking or self.Owner:Health() >= self.Owner:GetMaxHealth() then return end
    self.Drinking = true

    if (IsFirstTimePredicted() or game.SinglePlayer()) then
        timer.Simple(1, function()
            if self:IsValid() and self.Owner:IsValid() and self.Owner:Alive() and self.Owner:GetActiveWeapon() == self then
                self.Owner:SetHealth(math.Clamp(self.Owner:Health() + self.Primary.Damage, 1, self.Owner:GetMaxHealth()))
                self.Owner:ViewPunch(Angle(-40, 0, 0))
                self:EmitSound(self.Primary.Sound)

                timer.Simple(1, function()
                    if self:IsValid() and self.Owner:IsValid() and self.Owner:Alive() then
                        self.Drinking = false

                        if SERVER then
                            self.Owner:SelectWeapon("weapon_zm_improvised")
                            self.Owner:StripWeapon(self.ClassName)
                        end
                    end
                end)
            end
        end)
    end
end

function SWEP:SecondaryAttack() end
