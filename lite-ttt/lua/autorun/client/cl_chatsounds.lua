
local cooldown = CreateClientConVar("chatsounds_delay", "4", true, false)

hook.Add("OnPlayerChat", "ClientSidedChatSounds", function(ply, txt)
	if CurTime() - ply.LastChatSound > cvars.Number("chatsounds_delay", 4) then return end

	txt = string.lower(txt)

	sound.PlayURL(url, "3d", function(station)
		if IsValid(station) then
			station:SetPos(ply:GetPos())
			station:Play()
		end
	end)

	return false
end)

-- FUCK

--[[
local sound_dirs = {
	bigsmoke
	bill_wurtz
	bill_wurtz_history_of_everything
	bill_wurtz_history_of_japan
	bill_wurtz_outside
	billy_madison
	billy_mays
	bitconnect
	breakingbad
	breen
	cooking_mama
	cracklife
	csgo
	deathgrips
	deletethis
	discord
	doctorbreen
	donaldtrump
	down_under
	fullmetaljacket
	gabe
	gman
	goldeneye007
	goldeneye007soundfont
	goldeneyesource
	good_shit
	google
	gordon_ramsay
	h3h3
	halloween
	hamburger_time
	hitler_downfall
	hiv_suit
	hl1
	hl2_edits
	hl2_extras
	hm_music
	house_md
	how_is_babby_formed
	idubbbztv
	illegal_photgraphy
	impulse
	inception
	incoming
	instagib
	internet comment etiquette
	itsalwayssunny
	itsthenutshack
	jacksfilms
	joecartoon
	joel_half_life_playthrough
	jurassic_park
	kitchen gun
	kraftwerk
	lazytown
	leagueoflegends
	loadsamoney
	marioparty
	matrix
	mia khalifa
	michael rosen
	minecraft
	minecraft_con
	minecraft_noteblock
	miracle
	misc
	misc_youtube
	monty_python
	mortal_kombat
	music
	music_samples
	nonhuman
	noob
	numberone
	outlast2
	papersplease
	passtime
	payday2
	pennywise
	poo_poo
	poptart_tragedy
	portal_2
	portal_2_space_core
	postal
	radio graffiti
	random chatsounds
	randomshit
	rapbattle
	real_human_bean
	really_humor
	rickandmorty
	rofl/ha
	roosterteeth
	saxton_hale
	scarce
	sfm
	sfm_beta_misc
	sfm_scout_unused_dialog
	sfx_ambience
	sfx_domestic
	sfx_machine
	sfx_mechanical	
	sfx_misc
	sfx_voice
	shotmyself
	snoop_dogg
	some_beach
	southpark
	sphee
	spiderman
	spongebob
	stanley_parable
	starwars
	steve_ballmer
	suck_this_cock
	suckacock
	super_hot
	team_america
	terrorism/allahuakbar
	tf2_expiration_date
	tf2extra
	the_dover_boys_of_pimento_university
	the_uncredibles
	theoffice
	theroom
	thething
	timanderic
	titanfall
	tom_and_jerry
	tourettes
	trump
	trumpetfight
	tts
	tyrone
	u want sum fuk
	unreal
	vince_offer
	vine
	vinesauce
	vinesauce_butter_me_up
	vinesauce_mario
	vinesauce_ralph
	vinesauce_sleep
	vinesauce_ww
	vinesaucejoelgaminggear
	vsaucepoop
	weeb
	wooo
}
]]
