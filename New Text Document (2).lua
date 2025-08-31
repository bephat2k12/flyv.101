-- LocalScript bên trong FlyButton
local player = game.Players.LocalPlayer
local button = script.Parent
local flying = false
local bodyVel

button.MouseButton1Click:Connect(function()
	local character = player.Character or player.CharacterAdded:Wait()
	local root = character:WaitForChild("HumanoidRootPart")

	if flying == false then
		-- Bật bay
		flying = true
		button.Text = "Fly ON"

		bodyVel = Instance.new("BodyVelocity")
		bodyVel.Velocity = Vector3.new(0, 0, 0)
		bodyVel.MaxForce = Vector3.new(4000, 4000, 4000)
		bodyVel.Parent = root

		-- Update hướng bay theo input
		game:GetService("RunService").RenderStepped:Connect(function()
			if flying and bodyVel then
				local moveDir = Vector3.zero
				local humanoid = character:FindFirstChildOfClass("Humanoid")
				if humanoid then
					moveDir = humanoid.MoveDirection
				end
				-- tốc độ bay
				local speed = 50
				bodyVel.Velocity = Vector3.new(moveDir.X * speed, moveDir.Y * speed + (game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) and speed or 0) - (game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) and speed or 0), moveDir.Z * speed)
			end
		end)

	else
		-- Tắt bay
		flying = false
		button.Text = "Fly OFF"
		if bodyVel then
			bodyVel:Destroy()
			bodyVel = nil
		end
	end
end)
