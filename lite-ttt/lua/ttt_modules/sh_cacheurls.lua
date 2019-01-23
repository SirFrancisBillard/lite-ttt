
-- Put links to sounds to cache in here
-- All URLs *MUST* be cached on both client AND server!

local prefix = "https://sirfrancisbillard.github.io/billard-radio/sound/"

local SoundURLs = {
	"jihad/jihad_1.wav",
	"jihad/jihad_2.wav",
	"jihad/islam.wav", -- salil a sawarim
	"misc/headshot.wav",
	"misc/heil.mp3",
	"memes/roblox.wav",
	"zoo_of_idiots/ligma.wav",
	"bullet_time/slowmo_start.wav",
	"bullet_time/slowmo_end.wav",
	"gross/vomit1.wav",
	"gross/vomit2.wav",
	"russian_music/boyohboy.mp3",
}

-- Actual code below this line

BroadcastURL = BroadcastURL or {}

local function PrecacheURLs()
	for _, v in ipairs(SoundURLs) do
		BroadcastURL.CacheURL(prefix .. v)
	end
end

hook.Add("Initialize", "BroadcastURL.PrecacheURLS", PrecacheURLs)
hook.Add("OnReloaded", "BroadcastURL.PrecacheURLS", PrecacheURLs)
