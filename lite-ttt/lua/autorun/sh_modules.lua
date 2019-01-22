
include("ttt_config.lua")

if not ttt_config then ttt_config = {} end
if not ttt_config.disabledModules then ttt_config.disabledModules = {} end

local fol = "ttt_modules/"
local files, folders = file.Find(fol .. "*", "LUA")

for _, v in pairs(files) do
    if ttt_config.disabledModules[v:Left(-5)] then continue end
    if string.GetExtensionFromFilename(v) ~= "lua" then continue end
    include(fol .. v)
end

for _, folder in SortedPairs(folders, true) do
    if folder == "." or folder == ".." or ttt_config.disabledModules[folder] then continue end

    for _, File in SortedPairs(file.Find(fol .. folder .. "/sh_*.lua", "LUA"), true) do
        AddCSLuaFile(fol .. folder .. "/" .. File)
        include(fol .. folder .. "/" .. File)
    end

	if SERVER then
		for _, File in SortedPairs(file.Find(fol .. folder .. "/sv_*.lua", "LUA"), true) do
			include(fol .. folder .. "/" .. File)
		end
	end

    for _, File in SortedPairs(file.Find(fol .. folder .. "/cl_*.lua", "LUA"), true) do
        AddCSLuaFile(fol .. folder .. "/" .. File)
		if CLIENT then
			include(fol .. folder .. "/" .. File)
		end
    end
end
