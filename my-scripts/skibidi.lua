-- SERVICES
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- WAIT FOR ROOT
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

-- ================= UI =================

local gui = Instance.new("ScreenGui")
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.fromScale(0.25, 0.25)
frame.Position = UDim2.fromScale(0.4, 0.35)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 14)

local title = Instance.new("TextLabel")
title.Size = UDim2.fromScale(1, 0.2)
title.BackgroundTransparency = 1
title.Text = "Steal"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.Parent = frame

local textbox = Instance.new("TextBox")
textbox.PlaceholderText = "Model Name"
textbox.Size = UDim2.fromScale(0.85, 0.2)
textbox.Position = UDim2.fromScale(0.075, 0.3)
textbox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
textbox.TextColor3 = Color3.new(1,1,1)
textbox.Font = Enum.Font.Gotham
textbox.TextScaled = true
textbox.ClearTextOnFocus = false
textbox.Parent = frame

Instance.new("UICorner", textbox).CornerRadius = UDim.new(0,10)

local button = Instance.new("TextButton")
button.Text = "Hand TP"
button.Size = UDim2.fromScale(0.6, 0.2)
button.Position = UDim2.fromScale(0.2, 0.6)
button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
button.TextColor3 = Color3.new(1,1,1)
button.Font = Enum.Font.GothamBold
button.TextScaled = true
button.Parent = frame

Instance.new("UICorner", button).CornerRadius = UDim.new(0,10)

-- ================= LOGIC =================

local function getNearestModelByName(name)
	local closestPart
	local shortest = math.huge

	for _, obj in ipairs(workspace:GetDescendants()) do
		if obj:IsA("Model") and obj.Name == name then
			local part = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
			if part then
				local dist = (part.Position - humanoidRootPart.Position).Magnitude
				if dist < shortest and dist <= 50 then
					shortest = dist
					closestPart = part
				end
			end
		end
	end

	return closestPart
end

button.MouseButton1Click:Connect(function()
	local name = textbox.Text
	if name == "" then return end

	local targetPart = getNearestModelByName(name)
	if not targetPart then return end

	local originalCFrame = humanoidRootPart.CFrame

	-- TELEPORT TO TARGET
	humanoidRootPart.CFrame = targetPart.CFrame * CFrame.new(0, 0, -2)

	-- WAIT 0.2 SECONDS
	task.wait(0.2)

	-- RETURN BACK
	humanoidRootPart.CFrame = originalCFrame
end)
