local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local ESPEnabled = true

local function AddESP(Player)
	if Player == LocalPlayer then
		return
	end

	local function SetupCharacter(Character)
		if Character:FindFirstChild("ESPHighlight") then
			return
		end

		local Highlight = Instance.new("Highlight")
		Highlight.Name = "ESPHighlight"
		Highlight.FillTransparency = 0.5
		Highlight.OutlineTransparency = 0
		Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		Highlight.Parent = Character
	end

	if Player.Character then
		SetupCharacter(Player.Character)
	end

	Player.CharacterAdded:Connect(SetupCharacter)
end

local function RemoveESP(Player)
	if Player.Character then
		local ESP = Player.Character:FindFirstChild("ESPHighlight")
		if ESP then
			ESP:Destroy()
		end
	end
end

for _, Player in ipairs(Players:GetPlayers()) do
	AddESP(Player)
end

Players.PlayerAdded:Connect(AddESP)

-- Toggle test bằng phím E
game:GetService("UserInputService").InputBegan:Connect(function(Input, Processed)
	if Processed then return end

	if Input.KeyCode == Enum.KeyCode.E then
		ESPEnabled = not ESPEnabled

		for _, Player in ipairs(Players:GetPlayers()) do
			if ESPEnabled then
				AddESP(Player)
			else
				RemoveESP(Player)
			end
		end

		print("ESP:", ESPEnabled)
	end
end)
