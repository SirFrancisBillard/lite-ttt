CoffeeCup = CoffeeCup or {}

CoffeeCup.EnablePointshop = false
CoffeeCup.Points = 5

CoffeeCup.ReplacementTypes = {
	"prop_physics",
	"prop_physics_multiplayer",
	"prop_dynamic"
}

CoffeeCup.Models = {
	"models/props/cs_office/coffee_mug.mdl",
	"models/props/cs_office/coffee_mug2.mdl",
	"models/props/cs_office/coffee_mug3.mdl"
}

function CoffeeCup.CheckRequirements()
	if CoffeeCup.ReplacementTypes then
		CoffeeCup.EntityType = table.Random(CoffeeCup.ReplacementTypes)
		CoffeeCup.PropToReplace = table.Random(ents.FindByClass(CoffeeCup.EntityType))
		if not CoffeeCup.PropToReplace and #CoffeeCup.ReplacementTypes > 0 then
			table.RemoveByValue(CoffeeCup.ReplacementTypes, CoffeeCup.EntityType)
			CoffeeCup.CheckRequirements()
		else
			CoffeeCup.GenerateEntity()
		end
	end
end

function CoffeeCup.GenerateEntity()
	local original_prop_pos = CoffeeCup.PropToReplace:GetPos()
	CoffeeCup.PropToReplace:Remove()

	local coffee_cup = ents.Create("ent_coffeecup")
	coffee_cup:SetPos(original_prop_pos)
	coffee_cup:Spawn()
	for k, v in pairs(player.GetAll()) do
		v:ChatPrint("[Coffee Cup] A coffee cup has spawned somewhere on the map! Press E on it for $1,000,000!")
	end	
end

hook.Add("TTTBeginRound", "CC_ChooseProp", function()
	CoffeeCup.CheckRequirements()
end)

hook.Add("TTTEndRound", "CC_KillProp", function(result)
	local cup = ents.FindByClass("ent_coffeecup")
	if cup then
		for k, v in pairs(player.GetAll()) do
			v:ChatPrint("[Coffee Cup] No one found the coffee cup this round!")
		end	
	end
end)
