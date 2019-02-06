AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "ttt_basegrenade_proj"
ENT.Model = Model("models/weapons/w_eq_flashbang_thrown.mdl")

function ENT:Explode(tr)
	if SERVER then
		self:SetNoDraw(true)
		self:SetSolid(SOLID_NONE)

		-- pull out of the surface
		if tr.Fraction ~= 1.0 then
			self:SetPos(tr.HitPos + tr.HitNormal * 0.6)
		end

		local pos = self:GetPos()
		for k, v in pairs(player.GetAll()) do
			if pos:DistToSqr(v:EyePos()) then

		self:Remove()
	else
		local ply = LocalPlayer()

		if ply:GetObserverMode() ~= OBS_MODE_NONE and IsValid( ply:GetObserverTarget() ) then
			ply = ply:GetObserverTarget()
		end

		local dist = ply:EyePos():Distance( self:GetPos() )

		-- falloff is 1024 units
		--if dist < 1024 then
		local flashmul = InverseLerp( dist, 1024, 0 )
		flashmul = math.Clamp( flashmul, 0.1, 1 )

		local td = {
			start = ply:GetShootPos(),
			endpos = self:GetPos(),
			filter = {ply, self}
		}

		local tr = util.TraceLine( td )
		if not tr.Hit then
			local bonus = 1
			
			local sx, sy, svis = self:GetPos():ToScreen().x, self:GetPos():ToScreen().y, self:GetPos():ToScreen().visible
			if not svis then bonus = 0.2 end

			ply.FlashTime = ply.FlashTime + 10*flashmul*bonus
		end

		local spos = self:GetPos()
		local trs = util.TraceLine({start=spos + Vector(0,0,64), endpos=spos + Vector(0,0,-128), filter=self})
		util.Decal("SmallScorch", trs.HitPos + trs.HitNormal, trs.HitPos - trs.HitNormal)      

		self:SetDetonateExact(0)
		sound.Play("weapons/flashbang/flashbang_explode2.wav", spos, 100, 100)
	end
end

if SERVER then return end

hook.Add("HUDPaint", "FlashbangEffect", function()
	local ply = LocalPlayer()

	if ply:GetObserverMode() ~= OBS_MODE_NONE then
		if IsValid( ply:GetObserverTarget() ) then
			ply = ply:GetObserverTarget()
		end
	end

	ply.FlashTime = math.Clamp((ply.FlashTime or 0) - FrameTime(), 0, 10)

	local alpha = InverseLerp( ply.FlashTime, 0, 1 )
	alpha = math.Clamp( alpha, 0, 1 )

	if alpha > 0 then
		surface.SetDrawColor(Color(255,255,255,alpha*255))
		surface.DrawRect(0,0,ScrW(), ScrH())
	end
end)
