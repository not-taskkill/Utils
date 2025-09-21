local Notify = {}

local StarterGui = game:GetService("StarterGui")
local ContentProvider = game:GetService("ContentProvider")
local CoreGui = game:GetService("CoreGui")

ContentProvider:PreloadAsync({"rbxassetid://3398620867", "rbxassetid://130346111491713"})

local function StartSound()
	local Sound = Instance.new("Sound")
	Sound.Volume = 1.5
	Sound.SoundId = "rbxassetid://3398620867"
	Sound.Parent = CoreGui

	Sound.Ended:Connect(function()
		pcall(game.Destroy, Sound)
	end)

	Sound:Play()
end

function Notify.new(BaseTitle : string, Subtitle : string, Timer : number, SoundEnabled : boolean)
	StarterGui:SetCore("SendNotification", {
		Title = BaseTitle,
		Text = Subtitle,
		Icon = "rbxassetid://130346111491713",
		Duration = Timer or 5
	})
	
	if SoundEnabled then
		StartSound()
	end
	
	return
end

return Notify
