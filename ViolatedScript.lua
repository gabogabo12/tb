-- Violated Triggerbot Script
-- Dan FFA | BloxStrike | Private Test Environment

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- ─── Config ──────────────────────────────────────────────────────────────────

local Config = {
    TriggerEnabled = false,
    TriggerKey     = Enum.KeyCode.C,
    MenuKey        = Enum.KeyCode.RightShift,
    TriggerDelay   = 0.1,
    FireRate       = 0.1,
    KnockCheck     = true,
    KnifeCheck     = false,
}

-- ─── Colors ──────────────────────────────────────────────────────────────────

local C = {
    bg         = Color3.fromRGB(28, 20, 26),
    bgRow      = Color3.fromRGB(40, 28, 36),
    bgTitle    = Color3.fromRGB(20, 14, 18),
    accent     = Color3.fromRGB(230, 140, 180),
    accentDark = Color3.fromRGB(160, 80, 120),
    accentOff  = Color3.fromRGB(60, 45, 55),
    white      = Color3.fromRGB(245, 225, 235),
    muted      = Color3.fromRGB(160, 130, 150),
    on         = Color3.fromRGB(210, 140, 175),
    off        = Color3.fromRGB(180, 80, 110),
}

-- ─── GUI ─────────────────────────────────────────────────────────────────────

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ViolatedUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = gethui()

-- Notification frame (top left)
local NotifFrame = Instance.new("Frame")
NotifFrame.Size = UDim2.new(0, 160, 0, 32)
NotifFrame.Position = UDim2.new(0, 12, 0, 12)
NotifFrame.BackgroundColor3 = Color3.fromRGB(28, 20, 26)
NotifFrame.BackgroundTransparency = 1
NotifFrame.BorderSizePixel = 0
NotifFrame.ZIndex = 10
NotifFrame.Parent = ScreenGui
local NFC = Instance.new("UICorner")
NFC.CornerRadius = UDim.new(0, 8)
NFC.Parent = NotifFrame
local NFStroke = Instance.new("UIStroke")
NFStroke.Color = C.accent
NFStroke.Thickness = 1
NFStroke.Transparency = 1
NFStroke.Parent = NotifFrame

local NotifLabel = Instance.new("TextLabel")
NotifLabel.Text = ""
NotifLabel.Font = Enum.Font.GothamBold
NotifLabel.TextSize = 11
NotifLabel.TextColor3 = C.white
NotifLabel.BackgroundTransparency = 1
NotifLabel.Size = UDim2.new(1, 0, 1, 0)
NotifLabel.TextXAlignment = Enum.TextXAlignment.Center
NotifLabel.ZIndex = 11
NotifLabel.Parent = NotifFrame

local function ShowNotif(text, isOn)
    NotifLabel.Text = text
    NotifLabel.TextColor3 = isOn and C.on or C.off
    NotifFrame.BackgroundTransparency = 0
    NFStroke.Transparency = 0
    TweenService:Create(NotifFrame, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()
    task.delay(2, function()
        TweenService:Create(NotifFrame, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
        TweenService:Create(NFStroke, TweenInfo.new(0.4), {Transparency = 1}):Play()
    end)
end

-- Main frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 300, 0, 380)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -190)
MainFrame.BackgroundColor3 = C.bg
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MFC = Instance.new("UICorner")
MFC.CornerRadius = UDim.new(0, 12)
MFC.Parent = MainFrame

-- Soft pink gradient background
local BGGrad = Instance.new("UIGradient")
BGGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(38, 24, 34)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(28, 18, 28)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 14, 22)),
})
BGGrad.Rotation = 135
BGGrad.Parent = MainFrame

local MFStroke = Instance.new("UIStroke")
MFStroke.Color = C.accentDark
MFStroke.Thickness = 1.5
MFStroke.Parent = MainFrame

-- Decorative top glow bar
local GlowBar = Instance.new("Frame")
GlowBar.Size = UDim2.new(1, 0, 0, 3)
GlowBar.BackgroundColor3 = C.accent
GlowBar.BorderSizePixel = 0
GlowBar.ZIndex = 3
GlowBar.Parent = MainFrame
local GBC = Instance.new("UICorner")
GBC.CornerRadius = UDim.new(0, 12)
GBC.Parent = GlowBar
local GBGrad = Instance.new("UIGradient")
GBGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 180, 210)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(230, 130, 175)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 100, 150)),
})
GBGrad.Parent = GlowBar

-- Title bar
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 48)
TitleBar.BackgroundTransparency = 1
TitleBar.BorderSizePixel = 0
TitleBar.ZIndex = 2
TitleBar.Parent = MainFrame

-- Logo dot
local LogoDot = Instance.new("Frame")
LogoDot.Size = UDim2.new(0, 8, 0, 8)
LogoDot.Position = UDim2.new(0, 16, 0.5, -4)
LogoDot.BackgroundColor3 = C.accent
LogoDot.BorderSizePixel = 0
LogoDot.ZIndex = 3
LogoDot.Parent = TitleBar
local LDC = Instance.new("UICorner")
LDC.CornerRadius = UDim.new(1, 0)
LDC.Parent = LogoDot

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Text = "GabCute"
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 15
TitleLabel.TextColor3 = C.white
TitleLabel.BackgroundTransparency = 1
TitleLabel.Size = UDim2.new(0, 120, 1, 0)
TitleLabel.Position = UDim2.new(0, 30, 0, 0)
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.ZIndex = 3
TitleLabel.Parent = TitleBar

local SubLabel = Instance.new("TextLabel")
SubLabel.Text = "triggerbot"
SubLabel.Font = Enum.Font.Gotham
SubLabel.TextSize = 10
SubLabel.TextColor3 = C.muted
SubLabel.BackgroundTransparency = 1
SubLabel.Size = UDim2.new(0, 120, 1, 0)
SubLabel.Position = UDim2.new(0, 30, 0, 18)
SubLabel.TextXAlignment = Enum.TextXAlignment.Left
SubLabel.ZIndex = 3
SubLabel.Parent = TitleBar

local MenuHint = Instance.new("TextLabel")
MenuHint.Text = "RShift"
MenuHint.Font = Enum.Font.Gotham
MenuHint.TextSize = 9
MenuHint.TextColor3 = C.muted
MenuHint.BackgroundTransparency = 1
MenuHint.Size = UDim2.new(0, 50, 1, 0)
MenuHint.Position = UDim2.new(1, -80, 0, 0)
MenuHint.TextXAlignment = Enum.TextXAlignment.Right
MenuHint.ZIndex = 3
MenuHint.Parent = TitleBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Text = "✕"
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 11
CloseBtn.TextColor3 = C.muted
CloseBtn.Size = UDim2.new(0, 26, 0, 26)
CloseBtn.Position = UDim2.new(1, -36, 0.5, -13)
CloseBtn.BackgroundColor3 = Color3.fromRGB(50, 35, 44)
CloseBtn.BorderSizePixel = 0
CloseBtn.ZIndex = 3
CloseBtn.Parent = TitleBar
local CBC = Instance.new("UICorner")
CBC.CornerRadius = UDim.new(0, 6)
CBC.Parent = CloseBtn
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- Divider
local Divider = Instance.new("Frame")
Divider.Size = UDim2.new(1, -24, 0, 1)
Divider.Position = UDim2.new(0, 12, 0, 48)
Divider.BackgroundColor3 = C.accentDark
Divider.BackgroundTransparency = 0.6
Divider.BorderSizePixel = 0
Divider.Parent = MainFrame

-- Content frame
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -24, 1, -68)
Content.Position = UDim2.new(0, 12, 0, 58)
Content.BackgroundTransparency = 1
Content.BorderSizePixel = 0
Content.Parent = MainFrame

local ContentLayout = Instance.new("UIListLayout")
ContentLayout.Padding = UDim.new(0, 7)
ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
ContentLayout.Parent = Content

-- ─── Helpers ─────────────────────────────────────────────────────────────────

local function CreateRow(labelText, order)
    local Row = Instance.new("Frame")
    Row.Size = UDim2.new(1, 0, 0, 36)
    Row.BackgroundColor3 = C.bgRow
    Row.BorderSizePixel = 0
    Row.LayoutOrder = order
    Row.Parent = Content
    local RC = Instance.new("UICorner")
    RC.CornerRadius = UDim.new(0, 8)
    RC.Parent = Row
    local RStroke = Instance.new("UIStroke")
    RStroke.Color = C.accentDark
    RStroke.Thickness = 0.8
    RStroke.Transparency = 0.7
    RStroke.Parent = Row
    local Lbl = Instance.new("TextLabel")
    Lbl.Text = labelText
    Lbl.Font = Enum.Font.Gotham
    Lbl.TextSize = 12
    Lbl.TextColor3 = C.white
    Lbl.BackgroundTransparency = 1
    Lbl.Size = UDim2.new(1, -55, 1, 0)
    Lbl.Position = UDim2.new(0, 12, 0, 0)
    Lbl.TextXAlignment = Enum.TextXAlignment.Left
    Lbl.Parent = Row
    return Row
end

local function CreateToggle(parent, default, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(0, 38, 0, 20)
    ToggleFrame.Position = UDim2.new(1, -48, 0.5, -10)
    ToggleFrame.BackgroundColor3 = default and C.accent or C.accentOff
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.Parent = parent
    local TFC = Instance.new("UICorner")
    TFC.CornerRadius = UDim.new(1, 0)
    TFC.Parent = ToggleFrame
    local Knob = Instance.new("Frame")
    Knob.Size = UDim2.new(0, 14, 0, 14)
    Knob.Position = default and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)
    Knob.BackgroundColor3 = Color3.fromRGB(255, 245, 250)
    Knob.BorderSizePixel = 0
    Knob.Parent = ToggleFrame
    local KC = Instance.new("UICorner")
    KC.CornerRadius = UDim.new(1, 0)
    KC.Parent = Knob
    local state = default
    local ti = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 1, 0)
    Btn.BackgroundTransparency = 1
    Btn.Text = ""
    Btn.Parent = ToggleFrame
    Btn.MouseButton1Click:Connect(function()
        state = not state
        TweenService:Create(Knob, ti, {Position = state and UDim2.new(1,-17,0.5,-7) or UDim2.new(0,3,0.5,-7)}):Play()
        TweenService:Create(ToggleFrame, ti, {BackgroundColor3 = state and C.accent or C.accentOff}):Play()
        callback(state)
    end)
end

local function CreateSlider(labelText, order, defaultVal, minVal, maxVal, configKey, labelRef)
    local SliderRow = Instance.new("Frame")
    SliderRow.Size = UDim2.new(1, 0, 0, 54)
    SliderRow.BackgroundColor3 = C.bgRow
    SliderRow.BorderSizePixel = 0
    SliderRow.LayoutOrder = order
    SliderRow.Parent = Content
    local SRC = Instance.new("UICorner")
    SRC.CornerRadius = UDim.new(0, 8)
    SRC.Parent = SliderRow
    local SRStroke = Instance.new("UIStroke")
    SRStroke.Color = C.accentDark
    SRStroke.Thickness = 0.8
    SRStroke.Transparency = 0.7
    SRStroke.Parent = SliderRow

    local Lbl = Instance.new("TextLabel")
    Lbl.Font = Enum.Font.Gotham
    Lbl.TextSize = 12
    Lbl.TextColor3 = C.white
    Lbl.BackgroundTransparency = 1
    Lbl.Size = UDim2.new(1, -12, 0, 22)
    Lbl.Position = UDim2.new(0, 12, 0, 4)
    Lbl.TextXAlignment = Enum.TextXAlignment.Left
    Lbl.Parent = SliderRow

    local ValLbl = Instance.new("TextLabel")
    ValLbl.Font = Enum.Font.GothamBold
    ValLbl.TextSize = 11
    ValLbl.TextColor3 = C.accent
    ValLbl.BackgroundTransparency = 1
    ValLbl.Size = UDim2.new(0, 50, 0, 22)
    ValLbl.Position = UDim2.new(1, -62, 0, 4)
    ValLbl.TextXAlignment = Enum.TextXAlignment.Right
    ValLbl.Parent = SliderRow

    local Track = Instance.new("Frame")
    Track.Size = UDim2.new(1, -24, 0, 4)
    Track.Position = UDim2.new(0, 12, 0, 38)
    Track.BackgroundColor3 = Color3.fromRGB(55, 40, 50)
    Track.BorderSizePixel = 0
    Track.Parent = SliderRow
    local TC2 = Instance.new("UICorner")
    TC2.CornerRadius = UDim.new(1, 0)
    TC2.Parent = Track

    local Fill = Instance.new("Frame")
    local initRatio = (defaultVal - minVal) / (maxVal - minVal)
    Fill.Size = UDim2.new(initRatio, 0, 1, 0)
    Fill.BackgroundColor3 = C.accent
    Fill.BorderSizePixel = 0
    Fill.Parent = Track
    local FC2 = Instance.new("UICorner")
    FC2.CornerRadius = UDim.new(1, 0)
    FC2.Parent = Fill
    local FGrad = Instance.new("UIGradient")
    FGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 180, 210)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 100, 150)),
    })
    FGrad.Parent = Fill

    local Knob2 = Instance.new("Frame")
    Knob2.Size = UDim2.new(0, 14, 0, 14)
    Knob2.AnchorPoint = Vector2.new(0.5, 0.5)
    Knob2.Position = UDim2.new(initRatio, 0, 0.5, 0)
    Knob2.BackgroundColor3 = Color3.fromRGB(255, 240, 248)
    Knob2.BorderSizePixel = 0
    Knob2.Parent = Track
    local KC2 = Instance.new("UICorner")
    KC2.CornerRadius = UDim.new(1, 0)
    KC2.Parent = Knob2

    local function updateLabel(val)
        Lbl.Text = labelText
        ValLbl.Text = string.format("%.2fs", val)
    end
    updateLabel(defaultVal)

    local dragging2 = false
    local SBtn = Instance.new("TextButton")
    SBtn.Size = UDim2.new(1, 0, 0, 20)
    SBtn.Position = UDim2.new(0, 0, 0, -8)
    SBtn.BackgroundTransparency = 1
    SBtn.Text = ""
    SBtn.Parent = Track
    SBtn.MouseButton1Down:Connect(function() dragging2 = true end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging2 = false end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if dragging2 and i.UserInputType == Enum.UserInputType.MouseMovement then
            local ratio = math.clamp((i.Position.X - Track.AbsolutePosition.X) / Track.AbsoluteSize.X, 0, 1)
            local val = minVal + (maxVal - minVal) * ratio
            val = math.floor(val * 100) / 100
            Config[configKey] = val
            Fill.Size = UDim2.new(ratio, 0, 1, 0)
            Knob2.Position = UDim2.new(ratio, 0, 0.5, 0)
            updateLabel(val)
        end
    end)
end

-- ─── Rows ─────────────────────────────────────────────────────────────────────

local R1 = CreateRow("Triggerbot  [C]", 1)
CreateToggle(R1, Config.TriggerEnabled, function(v)
    Config.TriggerEnabled = v
    ShowNotif(v and "Triggerbot  ON ✓" or "Triggerbot  OFF ✗", v)
end)

local R2 = CreateRow("Knock Check", 2)
CreateToggle(R2, Config.KnockCheck, function(v) Config.KnockCheck = v end)

local R3 = CreateRow("Knife Check", 3)
CreateToggle(R3, Config.KnifeCheck, function(v) Config.KnifeCheck = v end)

CreateSlider("Delay", 4, Config.TriggerDelay, 0.01, 1.0, "TriggerDelay")
CreateSlider("Fire Rate", 5, Config.FireRate, 0.01, 1.0, "FireRate")

-- Status bar
local StatusBar = Instance.new("Frame")
StatusBar.Size = UDim2.new(1, -24, 0, 30)
StatusBar.Position = UDim2.new(0, 12, 1, -40)
StatusBar.BackgroundColor3 = C.bgRow
StatusBar.BorderSizePixel = 0
StatusBar.Parent = MainFrame
local SBC = Instance.new("UICorner")
SBC.CornerRadius = UDim.new(0, 8)
SBC.Parent = StatusBar

local StatusDot = Instance.new("Frame")
StatusDot.Size = UDim2.new(0, 7, 0, 7)
StatusDot.Position = UDim2.new(0, 12, 0.5, -3.5)
StatusDot.BackgroundColor3 = C.off
StatusDot.BorderSizePixel = 0
StatusDot.Parent = StatusBar
local SDC = Instance.new("UICorner")
SDC.CornerRadius = UDim.new(1, 0)
SDC.Parent = StatusDot

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Text = "inactive"
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 11
StatusLabel.TextColor3 = C.muted
StatusLabel.BackgroundTransparency = 1
StatusLabel.Size = UDim2.new(1, -30, 1, 0)
StatusLabel.Position = UDim2.new(0, 24, 0, 0)
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.Parent = StatusBar

-- ─── Keybinds ────────────────────────────────────────────────────────────────

UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Config.TriggerKey then
        Config.TriggerEnabled = not Config.TriggerEnabled
        ShowNotif(Config.TriggerEnabled and "Triggerbot  ON ✓" or "Triggerbot  OFF ✗", Config.TriggerEnabled)
    end
    if input.KeyCode == Config.MenuKey then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

-- Status updater
task.spawn(function()
    local last = nil
    local ti = TweenInfo.new(0.3)
    while task.wait(0.2) do
        if Config.TriggerEnabled ~= last then
            last = Config.TriggerEnabled
            if Config.TriggerEnabled then
                StatusLabel.Text = "active"
                StatusLabel.TextColor3 = C.on
                TweenService:Create(StatusDot, ti, {BackgroundColor3 = C.on}):Play()
            else
                StatusLabel.Text = "inactive"
                StatusLabel.TextColor3 = C.muted
                TweenService:Create(StatusDot, ti, {BackgroundColor3 = C.off}):Play()
            end
        end
    end
end)

-- ─── Knife Check ─────────────────────────────────────────────────────────────

local function IsHoldingKnife()
    local char = LocalPlayer.Character
    if not char then return false end
    local tool = char:FindFirstChildOfClass("Tool")
    if not tool then return false end
    local name = tool.Name:lower()
    return name:find("knife") or name:find("blade") or name:find("melee") or name:find("sword")
end

-- ─── Target Detection ────────────────────────────────────────────────────────

local function GetTarget()
    local target = Mouse.Target
    if not target then return nil end
    local model = target:FindFirstAncestorOfClass("Model")
    if not model then return nil end
    local humanoid = model:FindFirstChildOfClass("Humanoid")
    if not humanoid then return nil end
    if humanoid.Health <= 0 then return nil end
    if Config.KnockCheck then
        local state = humanoid:GetState()
        if state == Enum.HumanoidStateType.Physics or
           state == Enum.HumanoidStateType.FallingDown or
           humanoid.Health <= 1 then return nil end
    end
    local targetPlayer = Players:GetPlayerFromCharacter(model)
    if not targetPlayer then return nil end
    if targetPlayer == LocalPlayer then return nil end
    return targetPlayer
end

-- ─── Triggerbot Loop ─────────────────────────────────────────────────────────

task.spawn(function()
    local firing = false
    while task.wait(0.05) do
        if not Config.TriggerEnabled then
            firing = false
            task.wait(0.2)
            continue
        end
        if Config.KnifeCheck and IsHoldingKnife() then continue end
        local target = GetTarget()
        if target and not firing then
            firing = true
            task.delay(Config.TriggerDelay, function()
                if Config.TriggerEnabled and GetTarget() then
                    mouse1press()
                    task.wait(0.05)
                    mouse1release()
                end
                task.wait(math.max(Config.FireRate, 0.05))
                firing = false
            end)
        end
    end
end)
