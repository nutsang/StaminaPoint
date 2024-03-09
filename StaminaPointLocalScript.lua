local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character
if not character or character.Parent == nil then
	character = player.CharacterAdded:Wait()
end
local humanoid = character:WaitForChild("Humanoid")
local playerGui = player:WaitForChild("PlayerGui")
local staminaPointScreenGui = playerGui:WaitForChild("StaminaPointScreenGui")
local background = staminaPointScreenGui:WaitForChild("Frame")
local bar = background:WaitForChild("Frame")
local defaultWalkSpeed = humanoid.WalkSpeed
local maxStamina = 100
local stamina = 100
local isSprint = false
bar.Size = UDim2.new(stamina/maxStamina,0,1, 0)

UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
	if input.KeyCode == Enum.KeyCode.LeftShift or input.KeyCode == Enum.KeyCode.RightShift then
		isSprint = true
		humanoid.WalkSpeed = defaultWalkSpeed + 8
	end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessedEvent)
	if input.KeyCode == Enum.KeyCode.LeftShift or input.KeyCode == Enum.KeyCode.RightShift then
		isSprint = false
		humanoid.WalkSpeed = defaultWalkSpeed
	end
end)

task.spawn(function()
	while task.wait(1) do
		if isSprint then
			stamina = math.max(0, stamina - 1)
		else
			stamina = math.min(100, stamina + 1)
		end
		bar.Size = UDim2.new(stamina/maxStamina,0,1, 0)
	end
end)
