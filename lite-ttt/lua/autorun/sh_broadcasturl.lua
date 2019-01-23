
----------------------------------------------------
------------------- BroadcastURL -------------------
---- Serverside implementation of sound.PlayURL ----
-------------- By Sir Francis Billard --------------
----------------------------------------------------

local prefix = "[BroadcastURL] "
local bits = 16
local CachedURLs = CachedURLs or {} -- dont lose cache on refresh
local CacheIndex = 1 -- workaround: non-incremental tables break with length operator

BroadcastURL = {
	CacheURL = function(url)
		if CachedURLs[url] then
			print(prefix .. "Repeated cache of " .. url .. "! Ignoring...")
		end
		print(prefix .. " Cached sound " .. url .. " with id " .. CacheIndex)
		CachedURLs[url] = CacheIndex
		CacheIndex = CacheIndex + 1
	end,
	GetCachedURL = function(id)
		for k, v in pairs(CachedURLs) do
			if v == id then
				return k
			end
		end
		print(prefix .. "Repeated cache of " .. url .. "! Ignoring...")
	end
}

if SERVER then
	util.AddNetworkString("BroadcastURL")
	util.AddNetworkString("CachedBroadcastURL")

	function PlaySoundURL(url, pos)
		if not CachedURLs[url] then
			print(prefix .. "Uncached play of " .. url .. "! Please cache your URLs!")
			net.Start("BroadcastURL")
			print("BROADCASTING URL "..tostring(url))
			net.WriteString(url)
			print("BROADCASTING VECTOR "..tostring(pos))
			net.WriteVector(pos)
			net.Broadcast()
			return
		end

		net.Start("CachedBroadcastURL")
		net.WriteInt(CachedURLs[url], bits)
		print("BROADCASTING VECTOR "..tostring(pos))
		net.WriteVector(pos)
		net.Broadcast()
	end

	local ENTITY = FindMetaTable("Entity")

	function ENTITY:EmitSoundURL(url)
		print("EMITTING VECTOR "..tostring(self:GetPos()))
		PlaySoundURL(url, self:GetPos())
	end
else
	net.Receive("BroadcastURL", function(len)
		local url = net.ReadString()
		local vec = net.ReadVector()
		print("RECEIVED UC URL "..tostring(url))
		print("RECEIVED UC VECTOR "..tostring(vec))
		sound.PlayURL(url, "3d", function(station)
			if IsValid(station) then
				station:SetPos(vec)
				station:Play()
			end
		end)
	end)

	net.Receive("CachedBroadcastURL", function(len)
		local id = net.ReadInt(bits)
		local url = BroadcastURL.GetCachedURL(id)
		local vec = net.ReadVector()
		print("RECEIVED URL "..tostring(url).." with id "..id)
		print("RECEIVED VECTOR "..tostring(vec))
		sound.PlayURL(url, "3d", function(station)
			if IsValid(station) then
				station:SetPos(vec)
				station:Play()
			end
		end)
	end)
end
