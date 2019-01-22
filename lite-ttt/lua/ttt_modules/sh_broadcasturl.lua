
----------------------------------------------------
------------------- BroadcastURL -------------------
---- Serverside implementation of sound.PlayURL ----
-------------- By Sir Francis Billard --------------
----------------------------------------------------

local prefix = "[BroadcastURL] "
local bits = 16
local CachedURLs = {}

BroadcastURL = {
	CacheURL = function(url)
		if CachedURLs[url] then
			print(prefix .. "Repeated cache of " .. url .. "! Ignoring...")
		end
		CachedURLs[url] = #CachedURLs + 1
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

	local ENTITY = FindMetaTable("Entity")

	function ENTITY:EmitSoundURL(url)
		if not CachedURLs[url] then
			print(prefix .. "Uncached play of " .. url .. "! Please cache your URLs!")
			net.Start("BroadcastURL")
			net.WriteString(url)
			net.WriteVector(self:GetPos())
			net.Broadcast()
			return
		end

		net.Start("CachedBroadcastURL")
		net.WriteInt(CachedURLs[url], bits)
		net.WriteVector(self:GetPos())
		net.Broadcast()
	end
else
	net.Receive("BroadcastURL", function(len)
		sound.PlayURL(net.ReadString(), "3d",function(station)
			if IsValid(station) then
				station:SetPos(net.ReadVector())
				station:Play()
			end
		end)
	end)

	net.Receive("CachedBroadcastURL", function(len)
		sound.PlayURL(BroadcastURL.GetCachedURL(net.ReadInt(bits)), "3d",function(station)
			if IsValid(station) then
				station:SetPos(net.ReadVector())
				station:Play()
			end
		end)
	end)
end
