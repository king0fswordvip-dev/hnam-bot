local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ShootAllEvent = Instance.new("RemoteEvent")
ShootAllEvent.Name = "ShootAllEvent"
ShootAllEvent.Parent = ReplicatedStorage

ShootAllEvent.OnServerEvent:Connect(function(Player)

	for _, Target in ipairs(game.Players:GetPlayers()) do

		if Target ~= Player then

			local Character = Target.Character

			if Character then
				local Humanoid = Character:FindFirstChildOfClass("Humanoid")

				if Humanoid then
					Humanoid.Health = 0
				end
			end

		end

	end

end)
