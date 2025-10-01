-- ENHANCED BRAINROT HUB - CENTERED TITLE & PROPER LAYOUT
-- Made by Landon

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Main GUI - INITIALLY HIDDEN
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BrainrotHub"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = playerGui

-- STORE ALL ACTIVE GUIS FOR CLEANUP
local activeGUIs = {}

-- EXECUTOR STATE
local executorInjected = false

-- PERSISTENT SAVED SCRIPTS STORAGE
local savedScripts = {}
local function saveScripts()
    -- Save to workspace for persistence
    local saveFolder = Instance.new("Folder")
    saveFolder.Name = "BrainrotSavedScripts"
    
    -- Clear previous saves
    for _, child in pairs(workspace:GetChildren()) do
        if child.Name == "BrainrotSavedScripts" then
            child:Destroy()
        end
    end
    
    -- Save current scripts
    for i, scriptData in ipairs(savedScripts) do
        local value = Instance.new("StringValue")
        value.Name = "Script_" .. i
        value.Value = HttpService:JSONEncode(scriptData)
        value.Parent = saveFolder
    end
    
    saveFolder.Parent = workspace
end

local function loadScripts()
    savedScripts = {}
    local saveFolder = workspace:FindFirstChild("BrainrotSavedScripts")
    if saveFolder then
        for _, child in pairs(saveFolder:GetChildren()) do
            if child:IsA("StringValue") then
                local success, data = pcall(function()
                    return HttpService:JSONDecode(child.Value)
                end)
                if success and data then
                    table.insert(savedScripts, data)
                end
            end
        end
    end
end

-- FUNCTION TO CREATE ROUNDED CORNERS
local function applyRoundedCorners(frame, cornerRadius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, cornerRadius)
    corner.Parent = frame
    return corner
end

-- FUNCTION TO CREATE WHITE OUTLINE
local function applyWhiteOutline(frame, thickness)
    local outline = Instance.new("UIStroke")
    outline.Color = Color3.fromRGB(255, 255, 255)
    outline.Thickness = thickness
    outline.Transparency = 0.3
    outline.Parent = frame
    return outline
end

-- FUNCTION TO CREATE ANIMATED BACKGROUND
local function createAnimatedBackground(parent, particleCount, baseColor)
    local background = Instance.new("Frame")
    background.Size = UDim2.new(1, 0, 1, 0)
    background.BackgroundColor3 = baseColor
    background.BorderSizePixel = 0
    background.Parent = parent
    
    applyRoundedCorners(background, 12)
    
    -- Create animated particles
    for i = 1, particleCount do
        local particle = Instance.new("Frame")
        particle.Size = UDim2.new(0, math.random(4, 8), 0, math.random(4, 8))
        particle.Position = UDim2.new(math.random(), 0, math.random(), 0)
        particle.BackgroundColor3 = Color3.fromHSV(i/particleCount, 0.8, 1)
        particle.BorderSizePixel = 0
        applyRoundedCorners(particle, 4)
        particle.Parent = background
        
        spawn(function()
            while particle.Parent do
                TweenService:Create(particle, TweenInfo.new(math.random(3, 6)), {
                    Position = UDim2.new(math.random(), 0, math.random(), 0),
                    BackgroundColor3 = Color3.fromHSV(math.random(), 0.8, 1),
                    Rotation = math.random(0, 360)
                }):Play()
                wait(math.random(3, 6))
            end
        end)
    end
    
    return background
end

-- RAINBOW TEXT ANIMATION FUNCTION
local function createRainbowText(label)
    local time = 0
    local connection
    
    connection = RunService.Heartbeat:Connect(function(delta)
        time = time + delta
        local hue = (time * 0.5) % 1  -- Cycle through all hues
        label.TextColor3 = Color3.fromHSV(hue, 0.8, 1)
    end)
    
    return connection
end

-- LIVE TIME FUNCTION
local function createLiveTime(label)
    local connection
    
    connection = RunService.Heartbeat:Connect(function()
        local currentTime = os.date("%I:%M:%S %p")
        label.Text = "🕒 " .. currentTime
    end)
    
    return connection
end

-- COMPLETE 12 SCRIPTS FROM QUANTUM CORE
local scriptFunctions = {
    ["Chili Hub 🌶️"] = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua"))()
    end,

    ["Spawner 🎮"] = function()
        loadstring(game:HttpGet("https://gitlab.com/traxscriptss/traxscriptss/-/raw/main/visual2.lua"))()
    end,

    ["Rift(OP) 🔥"] = function()
        loadstring(game:HttpGet("https://rifton.top/loader.lua"))()
    end,

    ["Control 🎛️"] = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/onliengamerop/Steal-a-brainrot/refs/heads/main/Protected_3771863424757750.lua.txt"))()
    end,

    ["Fly Hack 🚀"] = function()
        local player = game.Players.LocalPlayer
        local mouse = player:GetMouse()
        
        local flying = false
        local bodyVelocity
        local flyKey = "f"
        
        mouse.KeyDown:Connect(function(key)
            if key == flyKey then
                flying = not flying
                if flying then
                    bodyVelocity = Instance.new("BodyVelocity")
                    bodyVelocity.Name = "QuantumFly"
                    bodyVelocity.Parent = player.Character.HumanoidRootPart
                    bodyVelocity.MaxForce = Vector3.new(40000, 40000, 40000)
                    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
                else
                    if bodyVelocity then
                        bodyVelocity:Destroy()
                    end
                end
            end
        end)
        
        -- Fly controls
        local camera = workspace.CurrentCamera
        game:GetService("RunService").RenderStepped:Connect(function()
            if flying and bodyVelocity then
                local root = player.Character.HumanoidRootPart
                local camCF = camera.CFrame
                local moveVector = Vector3.new()
                
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    moveVector = moveVector + (camCF.LookVector * 50)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    moveVector = moveVector - (camCF.LookVector * 50)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    moveVector = moveVector - (camCF.RightVector * 50)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    moveVector = moveVector + (camCF.RightVector * 50)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                    moveVector = moveVector + Vector3.new(0, 50, 0)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                    moveVector = moveVector - Vector3.new(0, 50, 0)
                end
                
                bodyVelocity.Velocity = moveVector
            end
        end)
    end,

    ["Pet Finder 🐾"] = function()
        script_key = "KEY";
        loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/77d72e34c893b67ea49b8d62d1a18485.lua"))()
    end,

    ["No Hitbox(OP) 🛡️"] = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Davi999z/Cartola-Hub/refs/heads/main/StealABrainrot.lua",true))()
    end,

    ["Lemon(VERY OP) 🍋"] = function()
        script_key = "KEY";
        loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/2341c827712daf923191e93377656f67.lua"))()
    end,

    ["Lennon Hub 🎵"] = function()
        loadstring(game:HttpGet("https://pastefy.app/MJw2J4T6/raw"))()
    end,

    ["Miranda Hub 🔮"] = function()
        loadstring(game:HttpGet("https://pastefy.app/JJVhs3rK/raw"))()
    end,

    ["Free Private Server 🌐"] = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/Ru4UQDpN"))()
    end,

    ["Lennon Dysync ⚡"] = function()
        loadstring(game:HttpGet("https://pastefy.app/MJw2J4T6/raw"))()
    end
}

-- PHASE 1: KEY INPUT GUI
local KeyGUI = Instance.new("Frame")
KeyGUI.Name = "KeyGUI"
KeyGUI.Size = UDim2.new(0, 350, 0, 350)
KeyGUI.Position = UDim2.new(0.5, -175, 0.5, -175)
KeyGUI.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
KeyGUI.BorderSizePixel = 0
KeyGUI.Parent = ScreenGui
applyRoundedCorners(KeyGUI, 15)
applyWhiteOutline(KeyGUI, 2)
table.insert(activeGUIs, KeyGUI)

local KeyBackground = createAnimatedBackground(KeyGUI, 20, Color3.fromRGB(20, 20, 30))

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 10)
Title.BackgroundTransparency = 1
Title.Text = "BRAINROT HUB 🅱️ v2.1.4"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 20
Title.Font = Enum.Font.GothamBlack
Title.Parent = KeyGUI

local rainbowTitle = createRainbowText(Title)

local KeyBox = Instance.new("TextBox")
KeyBox.Name = "KeyBox"
KeyBox.Size = UDim2.new(0.8, 0, 0, 40)
KeyBox.Position = UDim2.new(0.1, 0, 0.2, 0)
KeyBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBox.PlaceholderText = "Enter key here..."
KeyBox.Text = ""
KeyBox.TextSize = 18
KeyBox.Font = Enum.Font.Gotham
KeyBox.Parent = KeyGUI
applyRoundedCorners(KeyBox, 8)

local UpdateLogBtn = Instance.new("TextButton")
UpdateLogBtn.Name = "UpdateLogBtn"
UpdateLogBtn.Size = UDim2.new(0.6, 0, 0, 40)
UpdateLogBtn.Position = UDim2.new(0.2, 0, 0.35, 0)
UpdateLogBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
UpdateLogBtn.Text = "📋 UPDATE LOG"
UpdateLogBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
UpdateLogBtn.TextSize = 16
UpdateLogBtn.Font = Enum.Font.GothamBold
UpdateLogBtn.Parent = KeyGUI
applyRoundedCorners(UpdateLogBtn, 8)
applyWhiteOutline(UpdateLogBtn, 2)

local GetKeyBtn = Instance.new("TextButton")
GetKeyBtn.Name = "GetKeyBtn"
GetKeyBtn.Size = UDim2.new(0.6, 0, 0, 40)
GetKeyBtn.Position = UDim2.new(0.2, 0, 0.55, 0)
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
GetKeyBtn.Text = "🎁 GET FREE KEY"
GetKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
GetKeyBtn.TextSize = 16
GetKeyBtn.Font = Enum.Font.GothamBold
GetKeyBtn.Parent = KeyGUI
applyRoundedCorners(GetKeyBtn, 8)
applyWhiteOutline(GetKeyBtn, 2)

local SubmitBtn = Instance.new("TextButton")
SubmitBtn.Name = "SubmitBtn"
SubmitBtn.Size = UDim2.new(0.6, 0, 0, 40)
SubmitBtn.Position = UDim2.new(0.2, 0, 0.75, 0)
SubmitBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
SubmitBtn.Text = "SUBMIT"
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.TextSize = 18
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.Parent = KeyGUI
applyRoundedCorners(SubmitBtn, 8)
applyWhiteOutline(SubmitBtn, 2)

-- UPDATE LOG POPUP GUI
local UpdateLogGUI = Instance.new("Frame")
UpdateLogGUI.Name = "UpdateLogGUI"
UpdateLogGUI.Size = UDim2.new(0, 400, 0, 450)
UpdateLogGUI.Position = UDim2.new(0.5, -200, 0.5, -225)
UpdateLogGUI.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
UpdateLogGUI.BorderSizePixel = 0
UpdateLogGUI.Visible = false
UpdateLogGUI.Parent = ScreenGui
applyRoundedCorners(UpdateLogGUI, 15)
applyWhiteOutline(UpdateLogGUI, 2)

local UpdateLogBackground = createAnimatedBackground(UpdateLogGUI, 25, Color3.fromRGB(25, 25, 40))

local UpdateLogTitle = Instance.new("TextLabel")
UpdateLogTitle.Size = UDim2.new(1, 0, 0, 50)
UpdateLogTitle.Position = UDim2.new(0, 0, 0, 10)
UpdateLogTitle.BackgroundTransparency = 1
UpdateLogTitle.Text = "UPDATE LOG - v2.1.4 🅱️"
UpdateLogTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
UpdateLogTitle.TextSize = 22
UpdateLogTitle.Font = Enum.Font.GothamBlack
UpdateLogTitle.Parent = UpdateLogGUI

local rainbowUpdateTitle = createRainbowText(UpdateLogTitle)

local UpdateLogContent = Instance.new("ScrollingFrame")
UpdateLogContent.Size = UDim2.new(0.9, 0, 0, 320)
UpdateLogContent.Position = UDim2.new(0.05, 0, 0.15, 0)
UpdateLogContent.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
UpdateLogContent.BorderSizePixel = 0
UpdateLogContent.ScrollBarThickness = 8
UpdateLogContent.CanvasSize = UDim2.new(0, 0, 0, 600)
UpdateLogContent.Parent = UpdateLogGUI
applyRoundedCorners(UpdateLogContent, 10)
applyWhiteOutline(UpdateLogContent, 1)

local updates = {
    "🔹 v2.1.4 - Gotham font & clean text design",
    "🔹 v2.1.3 - Added rainbow version text & beta symbol",
    "🔹 v2.1.2 - Implemented update log system",
    "🔹 v2.1.1 - Enhanced animations & rounded corners",
    "🔹 v2.1.0 - Complete GUI overhaul",
    "🔹 v2.0.4 - Fixed loading screen transitions",
    "🔹 v2.0.3 - Added epic slam text animations",
    "🔹 v2.0.2 - Improved key validation system",
    "🔹 v2.0.1 - Added animated backgrounds",
    "🔹 v2.0.0 - Brainrot Hub Initial Release",
    "",
    "🎯 UPCOMING FEATURES:",
    "• Advanced script executor",
    "• Premium game exploits",
    "• Auto-update system",
    "• User customization",
    "• More animation effects",
    "",
    "👑 DEVELOPER: Landon [BETA]"
}

for i, updateText in ipairs(updates) do
    local updateLabel = Instance.new("TextLabel")
    updateLabel.Size = UDim2.new(0.9, 0, 0, 30)
    updateLabel.Position = UDim2.new(0.05, 0, 0, (i-1) * 35)
    updateLabel.BackgroundTransparency = 1
    updateLabel.Text = updateText
    updateLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
    updateLabel.TextSize = 14
    updateLabel.Font = Enum.Font.Gotham
    updateLabel.TextXAlignment = Enum.TextXAlignment.Left
    updateLabel.Parent = UpdateLogContent
end

local UpdateLogCloseBtn = Instance.new("TextButton")
UpdateLogCloseBtn.Size = UDim2.new(0.6, 0, 0, 40)
UpdateLogCloseBtn.Position = UDim2.new(0.2, 0, 0.9, 0)
UpdateLogCloseBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
UpdateLogCloseBtn.Text = "CLOSE"
UpdateLogCloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
UpdateLogCloseBtn.TextSize = 16
UpdateLogCloseBtn.Font = Enum.Font.GothamBold
UpdateLogCloseBtn.Parent = UpdateLogGUI
applyRoundedCorners(UpdateLogCloseBtn, 8)
applyWhiteOutline(UpdateLogCloseBtn, 2)

-- LOADING SCREENS
local LoadingGUI1 = Instance.new("Frame")
LoadingGUI1.Name = "LoadingGUI1"
LoadingGUI1.Size = UDim2.new(1, 0, 1, 0)
LoadingGUI1.Position = UDim2.new(0, 0, 0, 0)
LoadingGUI1.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
LoadingGUI1.BorderSizePixel = 0
LoadingGUI1.Visible = false
LoadingGUI1.Parent = ScreenGui
table.insert(activeGUIs, LoadingGUI1)

local LoadingBackground1 = createAnimatedBackground(LoadingGUI1, 40, Color3.fromRGB(0, 0, 0))

local LoadingText1 = Instance.new("TextLabel")
LoadingText1.Size = UDim2.new(1, 0, 0, 60)
LoadingText1.Position = UDim2.new(0, 0, 0.4, 0)
LoadingText1.BackgroundTransparency = 1
LoadingText1.Text = "VERIFYING ACCESS..."
LoadingText1.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadingText1.TextSize = 28
LoadingText1.Font = Enum.Font.GothamBlack
LoadingText1.Parent = LoadingGUI1

local LoadingBar1 = Instance.new("Frame")
LoadingBar1.Size = UDim2.new(0.6, 0, 0, 20)
LoadingBar1.Position = UDim2.new(0.2, 0, 0.5, 0)
LoadingBar1.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
LoadingBar1.BorderSizePixel = 0
LoadingBar1.Parent = LoadingGUI1
applyRoundedCorners(LoadingBar1, 10)
applyWhiteOutline(LoadingBar1, 1)

local LoadingBarFill1 = Instance.new("Frame")
LoadingBarFill1.Size = UDim2.new(0, 0, 1, 0)
LoadingBarFill1.Position = UDim2.new(0, 0, 0, 0)
LoadingBarFill1.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
LoadingBarFill1.BorderSizePixel = 0
LoadingBarFill1.Parent = LoadingBar1
applyRoundedCorners(LoadingBarFill1, 10)

local LoadingGUI2 = Instance.new("Frame")
LoadingGUI2.Name = "LoadingGUI2"
LoadingGUI2.Size = UDim2.new(1, 0, 1, 0)
LoadingGUI2.Position = UDim2.new(0, 0, 0, 0)
LoadingGUI2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
LoadingGUI2.BorderSizePixel = 0
LoadingGUI2.Visible = false
LoadingGUI2.Parent = ScreenGui
table.insert(activeGUIs, LoadingGUI2)

local LoadingBackground2 = createAnimatedBackground(LoadingGUI2, 50, Color3.fromRGB(0, 0, 0))

-- FUNCTION TO REMOVE ALL GUIS
local function removeAllGUIs()
    for _, gui in pairs(activeGUIs) do
        if gui and gui.Parent then
            gui.Visible = false
        end
    end
end

-- EPIC SLAM TEXT ANIMATION FUNCTION
local function createSlamText(text, size, yPosition, delay)
    wait(delay)
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(0, 0, 0, size)
    textLabel.Position = UDim2.new(0.5, 0, yPosition, -size/2)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = text
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.TextTransparency = 1
    textLabel.TextSize = size
    textLabel.Font = Enum.Font.GothamBlack
    textLabel.TextStrokeTransparency = 0.7
    textLabel.TextStrokeColor3 = Color3.fromRGB(0, 255, 255)
    textLabel.Parent = LoadingGUI2
    
    local glow = Instance.new("UIStroke")
    glow.Color = Color3.fromRGB(0, 255, 255)
    glow.Thickness = 8
    glow.Transparency = 1
    glow.Parent = textLabel
    
    local function screenShake(intensity, duration)
        local startTime = tick()
        while tick() - startTime < duration do
            local offsetX = math.random(-intensity, intensity)
            local offsetY = math.random(-intensity, intensity)
            LoadingGUI2.Position = LoadingGUI2.Position + UDim2.new(0, offsetX, 0, offsetY)
            wait(0.01)
            LoadingGUI2.Position = LoadingGUI2.Position - UDim2.new(0, offsetX, 0, offsetY)
            wait(0.01)
        end
    end
    
    TweenService:Create(textLabel, TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        TextTransparency = 0,
        Size = UDim2.new(0, 800, 0, size)
    }):Play()
    
    TweenService:Create(glow, TweenInfo.new(0.15), {
        Transparency = 0.2
    }):Play()
    
    screenShake(8, 0.3)
    
    wait(0.8)
    for i = 1, 2 do
        TweenService:Create(glow, TweenInfo.new(0.2), {
            Transparency = 0.1
        }):Play()
        wait(0.2)
        TweenService:Create(glow, TweenInfo.new(0.2), {
            Transparency = 0.4
        }):Play()
        wait(0.2)
    end
    
    TweenService:Create(textLabel, TweenInfo.new(0.5), {
        TextTransparency = 1
    }):Play()
    
    TweenService:Create(glow, TweenInfo.new(0.5), {
        Transparency = 1
    }):Play()
    
    wait(0.6)
    textLabel:Destroy()
end

-- PHASE 3: FINAL GUI WITH CENTERED TITLE & PROPER LAYOUT
local FinalGUI = Instance.new("Frame")
FinalGUI.Name = "FinalGUI"
FinalGUI.Size = UDim2.new(0.9, 0, 0.85, 0) -- ADJUSTED HEIGHT FOR BETTER FIT
FinalGUI.Position = UDim2.new(0.05, 0, 0.075, 0) -- CENTERED POSITION
FinalGUI.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
FinalGUI.BorderSizePixel = 0
FinalGUI.Visible = false
FinalGUI.Parent = ScreenGui
applyRoundedCorners(FinalGUI, 20) -- ROUNDED CORNERS ON MAIN GUI
-- NO OUTLINE ON MAIN GUI
table.insert(activeGUIs, FinalGUI)

-- ANIMATED BACKGROUND FOR FINAL GUI
local FinalBackground = createAnimatedBackground(FinalGUI, 25, Color3.fromRGB(0, 0, 0))

-- Draggable header for final GUI - NO OUTLINE
local FinalHeader = Instance.new("Frame")
FinalHeader.Name = "FinalHeader"
FinalHeader.Size = UDim2.new(1, 0, 0, 50)
FinalHeader.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
FinalHeader.BorderSizePixel = 0
FinalHeader.Parent = FinalGUI
applyRoundedCorners(FinalHeader, 12) -- ROUNDED CORNERS ON HEADER
-- NO OUTLINE ON HEADER

-- CENTERED TITLE WITH TIME - NO OUTLINE
local FinalTitle = Instance.new("TextLabel")
FinalTitle.Size = UDim2.new(1, 0, 1, 0)
FinalTitle.Position = UDim2.new(0, 0, 0, 0)
FinalTitle.BackgroundTransparency = 1
FinalTitle.Text = "BRAINROT HUB v2.1.4 - by Landon 🕒 " .. os.date("%I:%M:%S %p")
FinalTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
FinalTitle.TextSize = 16
FinalTitle.Font = Enum.Font.GothamBold
FinalTitle.Parent = FinalHeader

-- Start rainbow animation on final title
local rainbowFinalTitle = createRainbowText(FinalTitle)
-- Start live time updates
local liveTimeConnection = createLiveTime(FinalTitle)

-- EXECUTOR SECTION - RIGHT SIDE (FIXED)
local ExecutorSection = Instance.new("Frame")
ExecutorSection.Name = "ExecutorSection"
ExecutorSection.Size = UDim2.new(0.45, 0, 0.25, 0)
ExecutorSection.Position = UDim2.new(0.48, 0, 0.12, 0)
ExecutorSection.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
ExecutorSection.BorderSizePixel = 0
ExecutorSection.Parent = FinalGUI
applyRoundedCorners(ExecutorSection, 8)
applyWhiteOutline(ExecutorSection, 2)

-- Executor Title - GOTHAM FONT
local ExecutorTitle = Instance.new("TextLabel")
ExecutorTitle.Size = UDim2.new(1, 0, 0, 25)
ExecutorTitle.Position = UDim2.new(0, 0, 0, 5)
ExecutorTitle.BackgroundTransparency = 1
ExecutorTitle.Text = "⚡ CUSTOM EXECUTOR ⚡"
ExecutorTitle.TextColor3 = Color3.fromRGB(0, 255, 255)
ExecutorTitle.TextSize = 16
ExecutorTitle.Font = Enum.Font.GothamBold
ExecutorTitle.Parent = ExecutorSection

-- Script Input Box - CLEAN TEXT
local ScriptInput = Instance.new("TextBox")
ScriptInput.Name = "ScriptInput"
ScriptInput.Size = UDim2.new(0.9, 0, 0, 100)
ScriptInput.Position = UDim2.new(0.05, 0, 0.15, 0)
ScriptInput.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
ScriptInput.TextColor3 = Color3.fromRGB(255, 255, 255)
ScriptInput.PlaceholderText = "Paste your script here..."
ScriptInput.Text = ""
ScriptInput.TextSize = 14
ScriptInput.Font = Enum.Font.Gotham
ScriptInput.TextXAlignment = Enum.TextXAlignment.Left
ScriptInput.TextYAlignment = Enum.TextYAlignment.Top
ScriptInput.TextWrapped = true
ScriptInput.Parent = ExecutorSection
applyRoundedCorners(ScriptInput, 6)

-- Inject Button - GOTHAM FONT
local InjectBtn = Instance.new("TextButton")
InjectBtn.Name = "InjectBtn"
InjectBtn.Size = UDim2.new(0.4, 0, 0, 35)
InjectBtn.Position = UDim2.new(0.05, 0, 0.8, 0)
InjectBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
InjectBtn.Text = "INJECT"
InjectBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
InjectBtn.TextSize = 16
InjectBtn.Font = Enum.Font.GothamBold
InjectBtn.Parent = ExecutorSection
applyRoundedCorners(InjectBtn, 6)
applyWhiteOutline(InjectBtn, 2)

-- Execute Button (Initially disabled) - GOTHAM FONT
local ExecuteBtn = Instance.new("TextButton")
ExecuteBtn.Name = "ExecuteBtn"
ExecuteBtn.Size = UDim2.new(0.4, 0, 0, 35)
ExecuteBtn.Position = UDim2.new(0.55, 0, 0.8, 0)
ExecuteBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
ExecuteBtn.Text = "EXECUTE"
ExecuteBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
ExecuteBtn.TextSize = 16
ExecuteBtn.Font = Enum.Font.GothamBold
ExecuteBtn.Active = false
ExecuteBtn.Parent = ExecutorSection
applyRoundedCorners(ExecuteBtn, 6)
applyWhiteOutline(ExecuteBtn, 2)

-- QUANTUM SCRIPTS SECTION - LEFT SIDE
local ScriptSection = Instance.new("Frame")
ScriptSection.Name = "ScriptSection"
ScriptSection.Size = UDim2.new(0.4, 0, 0.45, 0) -- ADJUSTED HEIGHT
ScriptSection.Position = UDim2.new(0.02, 0, 0.12, 0)
ScriptSection.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
ScriptSection.BorderSizePixel = 0
ScriptSection.Parent = FinalGUI
applyRoundedCorners(ScriptSection, 8)
applyWhiteOutline(ScriptSection, 2)

-- Script Section Title - GOTHAM FONT
local ScriptSectionTitle = Instance.new("TextLabel")
ScriptSectionTitle.Size = UDim2.new(1, 0, 0, 25)
ScriptSectionTitle.Position = UDim2.new(0, 0, 0, 2)
ScriptSectionTitle.BackgroundTransparency = 1
ScriptSectionTitle.Text = "⚡ QUANTUM CORE v1 - 12 SCRIPTS ⚡"
ScriptSectionTitle.TextColor3 = Color3.fromRGB(0, 255, 255)
ScriptSectionTitle.TextSize = 14
ScriptSectionTitle.Font = Enum.Font.GothamBold
ScriptSectionTitle.Parent = ScriptSection

-- Script Buttons Container - SCROLLING FRAME FOR ALL 12 SCRIPTS
local ScriptButtonsContainer = Instance.new("ScrollingFrame")
ScriptButtonsContainer.Size = UDim2.new(0.9, 0, 0.85, 0)
ScriptButtonsContainer.Position = UDim2.new(0.05, 0, 0.15, 0)
ScriptButtonsContainer.BackgroundTransparency = 1
ScriptButtonsContainer.ScrollBarThickness = 6
ScriptButtonsContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
ScriptButtonsContainer.Parent = ScriptSection

local ScriptsListLayout = Instance.new("UIListLayout")
ScriptsListLayout.Padding = UDim.new(0, 5)
ScriptsListLayout.Parent = ScriptButtonsContainer

-- ALL 12 SCRIPTS FROM QUANTUM CORE
local allScripts = {
    "Chili Hub 🌶️",
    "Spawner 🎮",
    "Rift(OP) 🔥",
    "Control 🎛️",
    "Fly Hack 🚀",
    "Pet Finder 🐾",
    "No Hitbox(OP) 🛡️",
    "Lemon(VERY OP) 🍋",
    "Lennon Hub 🎵",
    "Miranda Hub 🔮",
    "Free Private Server 🌐",
    "Lennon Dysync ⚡"
}

-- Create ALL 12 script buttons - GOTHAM FONT
for i, scriptName in ipairs(allScripts) do
    local scriptButton = Instance.new("TextButton")
    scriptButton.Size = UDim2.new(0.95, 0, 0, 35)
    scriptButton.Position = UDim2.new(0.025, 0, 0, (i-1) * 40)
    scriptButton.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    scriptButton.Text = scriptName
    scriptButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    scriptButton.TextSize = 12
    scriptButton.Font = Enum.Font.GothamBold
    scriptButton.BorderSizePixel = 0
    scriptButton.Parent = ScriptButtonsContainer
    applyRoundedCorners(scriptButton, 4)
    
    -- CLICK TO EXECUTE
    scriptButton.MouseButton1Click:Connect(function()
        -- Visual feedback
        local originalColor = scriptButton.BackgroundColor3
        scriptButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
        scriptButton.Text = "EXECUTING..."
        
        -- Execute script directly
        local success, err = pcall(function()
            scriptFunctions[scriptName]()
        end)
        
        -- Reset button
        wait(1)
        scriptButton.BackgroundColor3 = originalColor
        scriptButton.Text = scriptName
        
        if not success then
            warn("Script execution error: " .. err)
        else
            print("QUANTUM CORE: " .. scriptName .. " executed successfully!")
        end
    end)
end

-- Update scrolling frame size
ScriptsListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ScriptButtonsContainer.CanvasSize = UDim2.new(0, 0, 0, ScriptsListLayout.AbsoluteContentSize.Y)
end)

-- SAVED SCRIPTS SECTION - RAISED UP UNDER QUANTUM SCRIPTS
local SavedScriptsSection = Instance.new("Frame")
SavedScriptsSection.Name = "SavedScriptsSection"
SavedScriptsSection.Size = UDim2.new(0.4, 0, 0.35, 0)
SavedScriptsSection.Position = UDim2.new(0.02, 0, 0.6, 0) -- RAISED UP FROM 0.65 TO 0.6
SavedScriptsSection.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
SavedScriptsSection.BorderSizePixel = 0
SavedScriptsSection.Parent = FinalGUI
applyRoundedCorners(SavedScriptsSection, 8)
applyWhiteOutline(SavedScriptsSection, 2)

-- Saved Scripts Title
local SavedScriptsTitle = Instance.new("TextLabel")
SavedScriptsTitle.Size = UDim2.new(1, 0, 0, 25)
SavedScriptsTitle.Position = UDim2.new(0, 0, 0, 2)
SavedScriptsTitle.BackgroundTransparency = 1
SavedScriptsTitle.Text = "💾 SAVED SCRIPTS (" .. #savedScripts .. ")"
SavedScriptsTitle.TextColor3 = Color3.fromRGB(0, 255, 255)
SavedScriptsTitle.TextSize = 14
SavedScriptsTitle.Font = Enum.Font.GothamBold
SavedScriptsTitle.Parent = SavedScriptsSection

-- Saved Scripts Container - SCROLLABLE AREA
local SavedScriptsContainer = Instance.new("ScrollingFrame")
SavedScriptsContainer.Size = UDim2.new(0.9, 0, 0.7, 0)
SavedScriptsContainer.Position = UDim2.new(0.05, 0, 0.15, 0)
SavedScriptsContainer.BackgroundTransparency = 1
SavedScriptsContainer.ScrollBarThickness = 6
SavedScriptsContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
SavedScriptsContainer.Parent = SavedScriptsSection

local SavedScriptsLayout = Instance.new("UIListLayout")
SavedScriptsLayout.Padding = UDim.new(0, 3)
SavedScriptsLayout.Parent = SavedScriptsContainer

-- UPLOAD BUTTON FOR SAVING SCRIPTS
local UploadScriptBtn = Instance.new("TextButton")
UploadScriptBtn.Name = "UploadScriptBtn"
UploadScriptBtn.Size = UDim2.new(0.9, 0, 0, 25)
UploadScriptBtn.Position = UDim2.new(0.05, 0, 0.88, 0)
UploadScriptBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
UploadScriptBtn.Text = "📁 UPLOAD SCRIPT"
UploadScriptBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
UploadScriptBtn.TextSize = 12
UploadScriptBtn.Font = Enum.Font.GothamBold
UploadScriptBtn.Parent = SavedScriptsSection
applyRoundedCorners(UploadScriptBtn, 6)
applyWhiteOutline(UploadScriptBtn, 2)

-- FUNCTION TO REFRESH SAVED SCRIPTS DISPLAY
local function refreshSavedScriptsDisplay()
    -- Clear existing display
    for _, child in pairs(SavedScriptsContainer:GetChildren()) do
        if child:IsA("TextButton") or child:IsA("TextLabel") then
            child:Destroy()
        end
    end
    
    -- Update title with count
    SavedScriptsTitle.Text = "💾 SAVED SCRIPTS (" .. #savedScripts .. ")"
    
    -- Add each saved script WITH X BUTTONS
    for i, scriptData in ipairs(savedScripts) do
        local scriptButton = Instance.new("TextButton")
        scriptButton.Size = UDim2.new(0.95, 0, 0, 25)
        scriptButton.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
        scriptButton.Text = "📜 " .. scriptData.name
        scriptButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        scriptButton.TextSize = 10
        scriptButton.Font = Enum.Font.Gotham
        scriptButton.TextXAlignment = Enum.TextXAlignment.Left
        scriptButton.Parent = SavedScriptsContainer
        applyRoundedCorners(scriptButton, 4)
        
        -- X BUTTON TO REMOVE
        local deleteBtn = Instance.new("TextButton")
        deleteBtn.Size = UDim2.new(0, 18, 0, 18)
        deleteBtn.Position = UDim2.new(0.9, 0, 0.1, 0)
        deleteBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        deleteBtn.Text = "X"
        deleteBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        deleteBtn.TextSize = 10
        deleteBtn.Font = Enum.Font.GothamBold
        deleteBtn.Visible = true
        deleteBtn.Parent = scriptButton
        applyRoundedCorners(deleteBtn, 3)
        
        -- DELETE SCRIPT FUNCTION
        deleteBtn.MouseButton1Click:Connect(function()
            table.remove(savedScripts, i)
            saveScripts()
            refreshSavedScriptsDisplay()
        end)
        
        -- Load script into executor on click
        scriptButton.MouseButton1Click:Connect(function()
            ScriptInput.Text = scriptData.code
        end)
    end
    
    -- Update scrolling frame size
    SavedScriptsContainer.CanvasSize = UDim2.new(0, 0, 0, SavedScriptsLayout.AbsoluteContentSize.Y)
end

-- UPLOAD BUTTON FUNCTIONALITY
UploadScriptBtn.MouseButton1Click:Connect(function()
    if ScriptInput.Text == "" then
        UploadScriptBtn.Text = "EMPTY!"
        UploadScriptBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        wait(1)
        UploadScriptBtn.Text = "📁 UPLOAD SCRIPT"
        UploadScriptBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
        return
    end
    
    local scriptName = "Script " .. os.date("%H:%M")
    table.insert(savedScripts, {
        name = scriptName,
        code = ScriptInput.Text,
        timestamp = os.time()
    })
    saveScripts()
    refreshSavedScriptsDisplay()
    
    UploadScriptBtn.Text = "✅ SAVED!"
    wait(1)
    UploadScriptBtn.Text = "📁 UPLOAD SCRIPT"
end)

-- REOPEN TOGGLE - GOTHAM FONT
local ReopenToggle = Instance.new("TextButton")
ReopenToggle.Name = "ReopenToggle"
ReopenToggle.Size = UDim2.new(0, 120, 0, 40)
ReopenToggle.Position = UDim2.new(0, 20, 0, 20)
ReopenToggle.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
ReopenToggle.Text = "TOGGLE HUB"
ReopenToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
ReopenToggle.TextSize = 14
ReopenToggle.Font = Enum.Font.GothamBold
ReopenToggle.Visible = false
ReopenToggle.Parent = ScreenGui
applyRoundedCorners(ReopenToggle, 8)
applyWhiteOutline(ReopenToggle, 2)

-- EXECUTOR FUNCTIONALITY (FIXED)
InjectBtn.MouseButton1Click:Connect(function()
    if ScriptInput.Text == "" then
        InjectBtn.Text = "EMPTY!"
        InjectBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        wait(1)
        InjectBtn.Text = "INJECT"
        InjectBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
        return
    end
    
    InjectBtn.Text = "INJECTING..."
    InjectBtn.BackgroundColor3 = Color3.fromRGB(255, 150, 0)
    wait(1)
    
    executorInjected = true
    InjectBtn.Text = "INJECTED!"
    InjectBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    
    ExecuteBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
    ExecuteBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ExecuteBtn.Active = true
end)

ExecuteBtn.MouseButton1Click:Connect(function()
    if not executorInjected then
        ExecuteBtn.Text = "INJECT FIRST!"
        ExecuteBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        wait(1)
        ExecuteBtn.Text = "EXECUTE"
        ExecuteBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        return
    end
    
    if ScriptInput.Text == "" then
        ExecuteBtn.Text = "NO SCRIPT!"
        ExecuteBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        wait(1)
        ExecuteBtn.Text = "EXECUTE"
        ExecuteBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        return
    end
    
    ExecuteBtn.Text = "EXECUTING..."
    ExecuteBtn.BackgroundColor3 = Color3.fromRGB(255, 150, 0)
    
    local success, err = pcall(function()
        loadstring(ScriptInput.Text)()
    end)
    
    wait(1)
    
    if success then
        ExecuteBtn.Text = "EXECUTED!"
        ExecuteBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    else
        ExecuteBtn.Text = "ERROR!"
        ExecuteBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        warn("Executor Error: " .. err)
    end
    
    wait(2)
    ExecuteBtn.Text = "EXECUTE"
    ExecuteBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
    executorInjected = false
    InjectBtn.Text = "INJECT"
    InjectBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
end)

-- Dragging functionality for final GUI
local draggingFinal = false
local dragStartFinal, startPosFinal

FinalHeader.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingFinal = true
        dragStartFinal = input.Position
        startPosFinal = FinalGUI.Position
    end
end)

FinalHeader.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingFinal = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if draggingFinal and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStartFinal
        FinalGUI.Position = UDim2.new(startPosFinal.X.Scale, startPosFinal.X.Offset + delta.X, startPosFinal.Y.Scale, startPosFinal.Y.Offset + delta.Y)
    end
end)

-- Key validation
local validKeys = {"LANDON123", "BRAINROT", "PREMIUM", "VIP", "FREEKEY"}

local function isValidKey(key)
    key = key:upper():gsub("%s+", "")
    for _, validKey in pairs(validKeys) do
        if key == validKey then
            return true
        end
    end
    return false
end

-- UPDATE LOG BUTTON FUNCTIONALITY
UpdateLogBtn.MouseButton1Click:Connect(function()
    UpdateLogGUI.Visible = true
end)

-- UPDATE LOG CLOSE BUTTON
UpdateLogCloseBtn.MouseButton1Click:Connect(function()
    UpdateLogGUI.Visible = false
end)

-- GET KEY BUTTON
GetKeyBtn.MouseButton1Click:Connect(function()
    local randomKey = validKeys[math.random(1, #validKeys)]
    setclipboard(randomKey)
    KeyBox.Text = randomKey
    GetKeyBtn.Text = "✅ COPIED!"
    wait(1)
    GetKeyBtn.Text = "🎁 GET FREE KEY"
end)

-- MAIN SUBMIT BUTTON - STARTS THE ENTIRE SEQUENCE
SubmitBtn.MouseButton1Click:Connect(function()
    local key = KeyBox.Text
    if key == "" then return end
    
    if isValidKey(key) then
        UpdateLogGUI.Visible = false
        KeyGUI.Visible = false
        LoadingGUI1.Visible = true
        
        spawn(function()
            local steps = {
                {"VERIFYING KEY...", 25},
                {"LOADING CORE...", 50},
                {"INITIALIZING...", 75},
                {"ACCESS GRANTED!", 100}
            }
            
            for i, step in ipairs(steps) do
                local text, progress = step[1], step[2]
                LoadingText1.Text = text
                
                TweenService:Create(LoadingBarFill1, TweenInfo.new(0.8), {
                    Size = UDim2.new(progress/100, 0, 1, 0)
                }):Play()
                wait(1.2)
            end
            
            LoadingGUI1.Visible = false
            LoadingGUI2.Visible = true
            
            createSlamText("STEALTH", 80, 0.2, 0)
            createSlamText("BRAINROT", 100, 0.4, 0.5)
            createSlamText("PREMIUM", 80, 0.6, 1)
            createSlamText("HUB", 120, 0.8, 1.5)
            
            wait(1)
            local finalText = Instance.new("TextLabel")
            finalText.Size = UDim2.new(0, 1000, 0, 120)
            finalText.Position = UDim2.new(0.5, -500, 0.5, -60)
            finalText.BackgroundTransparency = 1
            finalText.Text = "LOADED - BY LANDON"
            finalText.TextColor3 = Color3.fromRGB(255, 255, 255)
            finalText.TextTransparency = 1
            finalText.TextSize = 48
            finalText.Font = Enum.Font.GothamBlack
            finalText.Parent = LoadingGUI2
            
            TweenService:Create(finalText, TweenInfo.new(0.3), {
                TextTransparency = 0
            }):Play()
            wait(2)
            TweenService:Create(finalText, TweenInfo.new(0.5), {
                TextTransparency = 1
            }):Play()
            wait(0.6)
            
            LoadingGUI2.Visible = false
            removeAllGUIs()
            FinalGUI.Visible = true
            ReopenToggle.Visible = true
            loadScripts()
            refreshSavedScriptsDisplay()
        end)
    else
        KeyBox.Text = ""
        KeyBox.PlaceholderText = "INVALID KEY!"
        KeyBox.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        wait(1)
        KeyBox.PlaceholderText = "Enter key here..."
        KeyBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    end
end)

-- REOPEN TOGGLE
ReopenToggle.MouseButton1Click:Connect(function()
    if FinalGUI.Visible then
        FinalGUI.Visible = false
        ReopenToggle.Text = "SHOW HUB"
    else
        FinalGUI.Visible = true
        ReopenToggle.Text = "HIDE HUB"
    end
end)

-- Mobile optimization
if UserInputService.TouchEnabled then
    FinalGUI.Size = UDim2.new(0.95, 0, 0.85, 0)
    FinalGUI.Position = UDim2.new(0.025, 0, 0.075, 0)
    ScriptSection.Size = UDim2.new(0.42, 0, 0.4, 0)
    ExecutorSection.Size = UDim2.new(0.48, 0, 0.25, 0)
    SavedScriptsSection.Size = UDim2.new(0.42, 0, 0.35, 0)
    SavedScriptsSection.Position = UDim2.new(0.02, 0, 0.58, 0)
end

-- INITIAL SETUP
KeyGUI.Visible = true
FinalGUI.Visible = false
LoadingGUI1.Visible = false
LoadingGUI2.Visible = false
ReopenToggle.Visible = false
loadScripts()

print("🎬 BRAINROT HUB v2.1.4 BETA LOADED")
print("🎯 CENTERED TITLE: Name and time combined in middle")
print("📏 RAISED SAVED SCRIPTS: Moved up to fit better in GUI")
print("🔧 EXECUTOR FIXED: Proper functionality restored")
print("🔵 ROUNDED GUI: All main sections properly rounded")
print("💾 PERSISTENT STORAGE: Saved scripts survive re-execution")
print("❌ X BUTTONS: Remove any saved script")
print("⚡ QUANTUM CORE: 12 scripts ready")
