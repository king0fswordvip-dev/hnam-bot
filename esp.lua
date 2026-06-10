local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local ESPEnabled = true
local Connections = {}

-- =========================
-- ESP SYSTEM
-- =========================

local function CreateESP(Character)
	if not Character then
		return
	end

	if Character:FindFirstChild("ESPHighlight") then
		return
	end

	local Humanoid = Character:FindFirstChildOfClass("Humanoid")

	if not Humanoid then
		return
	end

	local Highlight = Instance.new("Highlight")
	Highlight.Name = "ESPHighlight"
	Highlight.FillColor = Color3.fromRGB(255, 0, 0)
	Highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
	Highlight.FillTransparency = 0.5
	Highlight.OutlineTransparency = 0
	Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	Highlight.Parent = Character
end

local function RemoveESP(Character)
	if not Character then
		return
	end

	local ESP = Character:FindFirstChild("ESPHighlight")

	if ESP then
		ESP:Destroy()
	end
end

local function RefreshESP()
	for _, Player in ipairs(Players:GetPlayers()) do
		if Player ~= LocalPlayer then
			if ESPEnabled then
				if Player.Character then
					CreateESP(Player.Character)
				end
			else
				if Player.Character then
					RemoveESP(Player.Character)
				end
			end
		end
	end
end

local function HandlePlayer(Player)
	if Player == LocalPlayer then
		return
	end

	if Player.Character and ESPEnabled then
		task.defer(CreateESP, Player.Character)
	end

	if Connections[Player] then
		return
	end

	Connections[Player] = Player.CharacterAdded:Connect(function(Character)
		task.wait(0.5)

		if ESPEnabled then
			CreateESP(Character)
		end
	end)
end

for _, Player in ipairs(Players:GetPlayers()) do
	HandlePlayer(Player)
end

Players.PlayerAdded:Connect(HandlePlayer)

Players.PlayerRemoving:Connect(function(Player)
	if Connections[Player] then
		Connections[Player]:Disconnect()
		Connections[Player] = nil
	end
end)

-- =========================
-- GUI
-- =========================

local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AdminESP"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

local OpenButton = Instance.new("TextButton")
OpenButton.Size = UDim2.new(0,60,0,60)
OpenButton.Position = UDim2.new(0,20,0.5,-30)
OpenButton.Text = "☰"
OpenButton.TextScaled = true
OpenButton.Parent = ScreenGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0,220,0,120)
MainFrame.Position = UDim2.new(0,90,0.5,-60)
MainFrame.BackgroundColor3 = Color3.fromRGB(35,35,35)
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.Parent = MainFrame

local ESPButton = Instance.new("TextButton")
ESPButton.Size = UDim2.new(0.9,0,0,40)
ESPButton.Position = UDim2.new(0.05,0,0.15,0)
ESPButton.Text = "ESP : ON"
ESPButton.BackgroundColor3 = Color3.fromRGB(50,150,50)
ESPButton.TextColor3 = Color3.new(1,1,1)
ESPButton.Parent = MainFrame

local ESPCorner = Instance.new("UICorner")
ESPCorner.Parent = ESPButton

-- =========================
-- BUTTON EVENTS
-- =========================

OpenButton.MouseButton1Click:Connect(function()
	MainFrame.Visible = not MainFrame.Visible
end)

ESPButton.MouseButton1Click:Connect(function()

	ESPEnabled = not ESPEnabled

	if ESPEnabled then
		ESPButton.Text = "ESP : ON"
		ESPButton.BackgroundColor3 = Color3.fromRGB(50,150,50)
	else
		ESPButton.Text = "ESP : OFF"
		ESPButton.BackgroundColor3 = Color3.fromRGB(170,50,50)
	end

	RefreshESP()

end)

RefreshESP()
