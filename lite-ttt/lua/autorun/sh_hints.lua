
local Red = Color(255, 0, 0)
local Green = Color(0, 255, 0)
local Blue = Color(0, 0, 255)
local Magenta = Color(255, 0, 255)

local GreenBlue = Color(100, 100, 255)
local BlueGreen = Color(100, 255, 100)

local ChatMessages = {
	{Red, "Hey did you know my knee grows?"},
	{Red, "You can get VIP instantly by typing !vip. You get a free golden deagle!"},
	{Red, "Hey did you know my knee grows?"},
	{Red, "Hey did you know my knee grows?"},
	{Red, "Hey did you know my knee grows?"},
}

if SERVER then
	util.AddNetworkString("SendChatHint")

	if timer.Exists("SendChatHintTimer") then
		timer.Remove("SendChatHintTimer")
	end

	timer.Create("SendChatHintTimer", 300, 0, function()
		net.Start("SendChatHint")
		net.WriteInt(math.random(#ChatMessages), 6)
		net.Broadcast()
	end)
else
	net.Receive("SendChatHint", function()
		local int = net.ReadInt(6)
		if gShowChatHints == false then return end
		chat.AddText(unpack(ChatMessages[int]))
	end)
end
