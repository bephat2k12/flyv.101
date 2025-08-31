-- LocalScript trong StarterPlayerScripts
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local root = character:WaitForChild("HumanoidRootPart")

-- Tạo GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FlyMenu"
screenGui.Parent = player:WaitForChild("PlayerGui")

local button = Instance.new("TextButton")
button.Name = "FlyButton"
button.Size = UDim2.new(0, 200, 0, 50)
button.Position = UDim2.new(0.5, -100, 0.9, 0)
button.BackgroundColor3 = Color3.fromRGB(50, 150, 250)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Font = Enum.Font.SourceSansBold
button.TextSize = 24
button.Text = "Fly OFF"
button.Parent = screenGui

-- Fly logic
local flying = false
local bodyVel

button.MouseButton1Click:Connect(function()
	if flying == false then
		-- Bật fly
		flying = true
		button.Text = "Fly ON"

		bodyVel = Instance.new("BodyVelocity")
		bodyVel.MaxForce = Vector3.new(4000, 4000, 4000)
		bodyVel.Velocity = Vector3.new(0, 0, 0)
		bodyVel.Parent = root

		-- Update bay theo input
		RunService.RenderStepped:Connect(function()
			if flying and bodyVel and root then
				local moveDir = humanoid.MoveDirection
				local speed = 50

				-- bay lên bằng Space, xuống bằng Ctrl
				local up = 0
				if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
					up = speed
				elseif UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
					up = -speed
				end

				bodyVel.Velocity = Vector3.new(moveDir.X * speed, up, moveDir.Z * speed)
			end
		end)
	else
		-- Tắt fly
		flying = false
		button.Text = "Fly OFF"
		if bodyVel then
			bodyVel:Destroy()
			bodyVel = nil
		end
	end
end)
