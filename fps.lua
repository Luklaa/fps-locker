local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local player = Players.LocalPlayer

local function cleanupOldGui()
    local name = "FpsLimiterGui"
    local locations = {
        gethui and gethui(),
        CoreGui:FindFirstChild("RobloxGui"),
        player:FindFirstChild("PlayerGui")
    }
    
    for _, location in ipairs(locations) do
        if location then
            local old = location:FindFirstChild(name)
            if old then old:Destroy() end
        end
    end
end

cleanupOldGui()

local parentGui = gethui and gethui() or CoreGui:FindFirstChild("RobloxGui") or player:WaitForChild("PlayerGui")

local currentFpsLimit = 60
local function setFps(value)
    currentFpsLimit = value == 0 and 60 or value
    if setfpscap then
        setfpscap(value == 0 and 60 or value)
    else
        warn("your executor don't support setfpscap!")
    end
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FpsLimiterGui"
screenGui.ResetOnSpawn = false
screenGui.ScreenInsets = Enum.ScreenInsets.None
screenGui.Parent = parentGui

local blackOverlay = Instance.new("Frame")
blackOverlay.Size = UDim2.new(1, 0, 1, 0)
blackOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
blackOverlay.BorderSizePixel = 0
blackOverlay.Visible = false
blackOverlay.ZIndex = 1
blackOverlay.Parent = screenGui

local openBtn = Instance.new("TextButton")
openBtn.Size = UDim2.new(0, 40, 0, 40)
openBtn.Position = UDim2.new(0.5, -70, 0, 10)
openBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
openBtn.BackgroundTransparency = 0.2
openBtn.Text = "FPS"
openBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
openBtn.Font = Enum.Font.GothamBold
openBtn.TextSize = 12
openBtn.Active = true
openBtn.Draggable = true
openBtn.ZIndex = 10
openBtn.Parent = screenGui

local openCorner = Instance.new("UICorner")
openCorner.CornerRadius = UDim.new(0, 12)
openCorner.Parent = openBtn

local frame = Instance.new("Frame")
frame.Size = UDim2.new(1, 0, 1, 0)
frame.Position = UDim2.new(0, 0, 0, 0)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BackgroundTransparency = 0.15
frame.BorderSizePixel = 0
frame.Visible = false
frame.ZIndex = 5
frame.Parent = screenGui

local mainContainer = Instance.new("Frame")
mainContainer.Size = UDim2.new(0, 540, 0, 320)
mainContainer.Position = UDim2.new(0.5, -270, 0.5, -160)
mainContainer.BackgroundTransparency = 1
mainContainer.ZIndex = 6
mainContainer.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.Text = "BSS Ultra Optimizer"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.ZIndex = 6
title.Parent = mainContainer

local leftContainer = Instance.new("Frame")
leftContainer.Size = UDim2.new(0.5, -10, 1, -40)
leftContainer.Position = UDim2.new(0, 0, 0, 40)
leftContainer.BackgroundTransparency = 1
leftContainer.ZIndex = 6
leftContainer.Parent = mainContainer

local gridLayout = Instance.new("UIGridLayout")
gridLayout.CellSize = UDim2.new(0, 82, 0, 32)
gridLayout.CellPadding = UDim2.new(0, 6, 0, 6)
gridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
gridLayout.VerticalAlignment = Enum.VerticalAlignment.Top
gridLayout.Parent = leftContainer

local rightContainer = Instance.new("Frame")
rightContainer.Size = UDim2.new(0.5, -10, 1, -40)
rightContainer.Position = UDim2.new(0.5, 10, 0, 40)
rightContainer.BackgroundTransparency = 1
rightContainer.ZIndex = 6
rightContainer.Parent = mainContainer

local rightScroll = Instance.new("ScrollingFrame")
rightScroll.Size = UDim2.new(1, 0, 1, 0)
rightScroll.BackgroundTransparency = 1
rightScroll.CanvasSize = UDim2.new(0, 0, 0, 380)
rightScroll.ScrollBarThickness = 4
rightScroll.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
rightScroll.ZIndex = 6
rightScroll.Parent = rightContainer

local rightLayout = Instance.new("UIListLayout")
rightLayout.Padding = UDim.new(0, 6)
rightLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
rightLayout.Parent = rightScroll

local customInput = Instance.new("TextBox")
customInput.Size = UDim2.new(0.95, 0, 0, 32)
customInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
customInput.TextColor3 = Color3.fromRGB(255, 255, 255)
customInput.PlaceholderText = "Свой FPS (напр. 20)"
customInput.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
customInput.Font = Enum.Font.Gotham
customInput.TextSize = 13
customInput.Text = ""
customInput.ClearTextOnFocus = true
customInput.ZIndex = 7
customInput.Parent = rightScroll

local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 6)
inputCorner.Parent = customInput

local function makeFpsButton(text, fpsValue)
	local btn = Instance.new("TextButton")
	btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 12
	btn.Text = text
	btn.ZIndex = 7
	btn.Parent = leftContainer

	local btnCorner = Instance.new("UICorner")
	btnCorner.CornerRadius = UDim.new(0, 6)
	btnCorner.Parent = btn

	btn.MouseButton1Click:Connect(function()
		setFps(fpsValue)
		title.Text = fpsValue == 0 and "FPS: Default (60)" or ("FPS Limit: " .. fpsValue)
	end)
end

local fpsLimits = {5, 10, 15, 30, 45, 60, 90, 120, 144, 165, 240}
for _, v in ipairs(fpsLimits) do
    makeFpsButton(v .. " FPS", v)
end
makeFpsButton("Сброс", 0)

customInput.FocusLost:Connect(function(enterPressed)
    local text = customInput.Text
    local number = tonumber(text)
    if number and number >= 1 then
        number = math.floor(number)
        setFps(number)
        title.Text = "Custom FPS: " .. number
        customInput.Text = ""
    else
        customInput.Text = ""
        if text ~= "" then
            title.Text = "Write any number!"
            task.wait(1.5)
            title.Text = "Fps Locker + optimizer"
        end
    end
end)

local fpsDisplayLabel = Instance.new("TextLabel")
fpsDisplayLabel.Size = UDim2.new(0, 85, 0, 25)
fpsDisplayLabel.Position = UDim2.new(0, 15, 0, 40)
fpsDisplayLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
fpsDisplayLabel.BackgroundTransparency = 0.4
fpsDisplayLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
fpsDisplayLabel.Font = Enum.Font.GothamBold
fpsDisplayLabel.TextSize = 13
fpsDisplayLabel.Text = "FPS: --"
fpsDisplayLabel.Visible = false
fpsDisplayLabel.ZIndex = 10
fpsDisplayLabel.Parent = screenGui

local displayCorner = Instance.new("UICorner")
displayCorner.CornerRadius = UDim.new(0, 4)
displayCorner.Parent = fpsDisplayLabel

local fpsShowActive = false
local lastTime = os.clock()
local frameCount = 0

RunService.Heartbeat:Connect(function()
    if not fpsShowActive then return end
    frameCount = frameCount + 1
    local now = os.clock()
    if now - lastTime >= 0.5 then
        local currentFps = math.floor(frameCount / (now - lastTime))
        fpsDisplayLabel.Text = "FPS: " .. currentFps .. " / " .. currentFpsLimit
        
        if currentFps >= 45 then
            fpsDisplayLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
        elseif currentFps >= 20 then
            fpsDisplayLabel.TextColor3 = Color3.fromRGB(255, 165, 0)
        else
            fpsDisplayLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
        end
        
        frameCount = 0
        lastTime = now
    end
end)

local function makeToggle(text, callback)
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0.95, 0, 0, 32)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(45, 30, 30)
    toggleBtn.TextColor3 = Color3.fromRGB(255, 150, 150)
    toggleBtn.Font = Enum.Font.GothamBold
    toggleBtn.TextSize = 11
    toggleBtn.Text = text .. ": ВЫКЛ"
    toggleBtn.ZIndex = 7
    toggleBtn.Parent = rightScroll

    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 6)
    toggleCorner.Parent = toggleBtn

    local state = false
    toggleBtn.MouseButton1Click:Connect(function()
        state = not state
        if state then
            toggleBtn.BackgroundColor3 = Color3.fromRGB(30, 45, 30)
            toggleBtn.TextColor3 = Color3.fromRGB(150, 255, 150)
            toggleBtn.Text = text .. ": ВКЛ"
        else
            toggleBtn.BackgroundColor3 = Color3.fromRGB(45, 30, 30)
            toggleBtn.TextColor3 = Color3.fromRGB(255, 150, 150)
            toggleBtn.Text = text .. ": ВЫКЛ"
        end
        callback(state)
    end)
end

makeToggle("Show FPS counter", function(state)
    fpsShowActive = state
    fpsDisplayLabel.Visible = state
end)

makeToggle("Set Max FPS (999)", function(state)
    if state then setFps(999) else setFps(60) end
end)

local origFogColor, origFogEnd, origFogStart
makeToggle("Minimal vision (Fog)", function(state)
    if state then
        origFogColor = Lighting.FogColor
        origFogEnd = Lighting.FogEnd
        origFogStart = Lighting.FogStart
        
        Lighting.FogColor = Color3.fromRGB(20, 20, 20)
        Lighting.FogStart = 30
        Lighting.FogEnd = 70
    else
        if origFogEnd then
            Lighting.FogColor = origFogColor
            Lighting.FogEnd = origFogEnd
            Lighting.FogStart = origFogStart
        end
    end
end)

makeToggle("Disable 3D renderer", function(state)
    RunService:Set3dRenderingEnabled(not state)
    blackOverlay.Visible = state
end)

makeToggle("Very low graphics", function(state)
    if state then
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        Lighting.GlobalShadows = false
    else
        settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
        Lighting.GlobalShadows = true
    end
end)

makeToggle("Remove post-effects", function(state)
    for _, effect in ipairs(Lighting:GetChildren()) do
        if effect:IsA("PostEffect") or effect:IsA("BloomEffect") or effect:IsA("BlurEffect") or effect:IsA("DepthOfFieldEffect") or effect:IsA("SunRaysEffect") then
            effect.Enabled = not state
        end
    end
end)

local storedMaterials = {}
makeToggle("Remove textures (simple boost)", function(state)
    if state then
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj:IsA("BasePart") and not obj:IsA("MeshPart") and not obj.Parent:FindFirstChild("Humanoid") and obj.Name ~= "Flower" then
                storedMaterials[obj] = obj.Material
                obj.Material = Enum.Material.SmoothPlastic
            elseif obj:IsA("Texture") or obj:IsA("Decal") then
                storedMaterials[obj] = obj.Texture
                obj.Texture = ""
            end
        end
    else
        for obj, mat in pairs(storedMaterials) do
            if obj and obj.Parent then
                if obj:IsA("BasePart") then
                    obj.Material = mat
                elseif obj:IsA("Texture") or obj:IsA("Decal") then
                    obj.Texture = mat
                end
            end
        end
        table.clear(storedMaterials)
    end
end)

makeToggle("Clear map (Details)", function(state)
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("ParticleEmitter") or obj:IsA("Smoke") or obj:IsA("Sparkles") or obj:IsA("Fire") then
            obj.Enabled = not state
        end
    end
end)

local hiddenPlayers = {}
makeToggle("Hide other players", function(state)
    if state then
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= player and p.Character then
                hiddenPlayers[p] = p.Character.Parent
                p.Character.Parent = nil
            end
        end
    else
        for p, parent in pairs(hiddenPlayers) do
            if p and p.Character then
                p.Character.Parent = parent
            end
        end
        table.clear(hiddenPlayers)
    end
end)

openBtn.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)
