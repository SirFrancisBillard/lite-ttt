
-- Put links to sounds to cache in here
-- All URLs *MUST* be cached on both client AND server!

local SoundURLs = {

}

-- Actual code below this line

BroadcastURL = BroadcastURL or {}

local function PrecacheURLs()
	for _, v in ipairs(SoundURLs) do
		BroadcastURL.CacheURL(v)
	end
end

hook.Add("Initialize", "BroadcastURL.PrecacheURLS", PrecacheURLs)
hook.Add("OnReloaded", "BroadcastURL.PrecacheURLS", PrecacheURLs)
