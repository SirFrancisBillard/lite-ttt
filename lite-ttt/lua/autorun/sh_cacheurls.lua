
-- Put links to sounds to cache in here
-- All URLs *MUST* be cached on both client AND server!

local prefix = "https://sirfrancisbillard.github.io/billard-radio/sound/"
local suffix = ".mp3"

local SoundURLs = {
	"jihad/jihad_1",
	"jihad/jihad_2",
	"jihad/islam", -- salil a sawarim
	"misc/headshot",
	"misc/heil",
	"memes/roblox",
	"zoo_of_idiots/ligma",
	"bullet_time/slowmo_start",
	"bullet_time/slowmo_end",
	"gross/vomit1",
	"gross/vomit2",
	"russian_music/boyohboy",
}

-- Actual code below this line

BroadcastURL = BroadcastURL or {}

local function PrecacheURLs()
	for _, v in ipairs(SoundURLs) do
		local full = prefix .. v .. suffix
		BroadcastURL.CacheURL(full)
	end
end

PrecacheURLS()
hook.Add("Initialize", "BroadcastURL.PrecacheURLS", PrecacheURLs)
hook.Add("OnReloaded", "BroadcastURL.PrecacheURLS", PrecacheURLs)
