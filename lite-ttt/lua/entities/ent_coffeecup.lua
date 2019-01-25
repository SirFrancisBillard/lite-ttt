AddCSLuaFile()

ENT.Type = "anim"
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

if SERVER then
	function ENT:Initialize()
		self:SetModel("models/props/cs_office/coffee_mug.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		self:SetPlaybackRate(1)
	end

	function ENT:Use(activator, caller)
		self:Remove()
		
		for k, v in pairs(player.GetAll()) do
			v:ChatPrint("[Coffee Cup] " .. caller:Nick() .. " found the coffee cup!")
		end	
		caller:ChatPrint("You don't actually get a prize lmao.")
	end
	 
	function ENT:Think()
	end
end
