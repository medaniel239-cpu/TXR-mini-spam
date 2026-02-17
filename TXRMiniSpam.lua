-- Nothing Mini Spam - Fixed & Clean Version by txr ashu
-- Delta Executor Android pe load hone ke liye ready

local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
if not player then return end

local spamming = false
local spamConnection = nil
local msgIndex = 1

local messages = {
    "Ready, nothing mini spammer loaded",
    "Ki sis hamari raat ka toy hai",
    "Ki MAiya ko bathroom me xdaaa/pela",
    "Kuttro/dog se apni g mrvara hai",
    "Japanese tel lagake pela jayega",
    "Ur mom 100 me bikti hai",
    "Aukat me rehle ckkkk",
    "Tera nunu kat ke TERIHI g-- me daba dunga",
    "Ki maiya ke pet me ghore/horse ka baccha hai",
    "Halak me danda fasa denge teko",
    "--t-e-r-y--m-а-қ-і--қ-а-І-і--|0-h-a-t-i---i-l-i--c-h-x-t-",
    "--เทา-ล-c-c-h-e-r--қ-i--j-h-a-n-t-"
}

local inputBox  -- global

local function sendMessage(msg)
    local fullMsg = (inputBox.Text \~= "" and inputBox.Text .. " " or "") .. msg
    
    -- Legacy chat
    pcall(function()
        local events = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
        if events then
            local req = events:FindFirstChild("SayMessageRequest")
            if req then req:FireServer(fullMsg, "All") end
        end
    end)
    
    -- New chat
    pcall(function()
        local channels = TextChatService:FindFirstChild("TextChannels")
        if channels then
            local gen = channels:FindFirstChild("RBXGeneral")
            if gen then gen:SendAsync(fullMsg) end
        end
    end)
end

local function startSpam()
    if spamConnection then return end
    spamConnection = RunService.Heartbeat:Connect(function()
        if spamming and inputBox and inputBox.Text \~= "" then
            sendMessage(messages[msgIndex])
            msgIndex = (msgIndex % #messages) + 1
        end
    end)
end

local function stopSpam()
    if spamConnection then
        spamConnection:Disconnect()
        spamConnection = nil
    end
end

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "NothingMiniSpam"
gui.ResetOnSpawn = false
gui.Parent = game.CoreGui

local frame = Instance.new("Frame")
frame.Size = UDim2.fromScale(0.35, 0.35)
frame.Position = UDim2.fromScale(0.125, 0.3)
frame.BackgroundColor3 = Color3.fromRGB(15,15,15)
frame.BorderSizePixel = 0
frame.Active = true
frame.Parent = gui

-- Drag
local dragging, dragStart, startPos
frame.InputBegan:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = inp.Position
        startPos = frame.Position
    end
end)
frame.InputEnded:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)
UserInputService.InputChanged:Connect(function(inp)
    if dragging and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
        local delta = inp.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.fromScale(1, 0.15)
title.BackgroundTransparency = 1
title.Text = "Nothing Mini Spam 🔥"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.Parent = frame

-- Credits
local credits = Instance.new("TextLabel")
credits.Size = UDim2.fromScale(1, 0.1)
credits.Position = UDim2.fromScale(0, 0.15)
credits.BackgroundTransparency = 1
credits.Text = "made by txr ashu"
credits.TextColor3 = Color3.fromRGB(200,200,200)
credits.Font = Enum.Font.Gotham
credits.TextScaled = true
credits.Parent = frame

-- Close
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.fromScale(0.12, 0.15)
closeBtn.Position = UDim2.fromScale(0.88, 0)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextScaled = true
closeBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
closeBtn.TextColor3 = Color3.new(1,0,0)
closeBtn.Parent = frame

-- Input
inputBox = Instance.new("TextBox")
inputBox.Size = UDim2.fromScale(0.9, 0.22)
inputBox.Position = UDim2.fromScale(0.05, 0.28)
inputBox.PlaceholderText = "Target Name (jaise Gun)"
inputBox.Text = ""
inputBox.Font = Enum.Font.Gotham
inputBox.TextScaled = true
inputBox.BackgroundColor3 = Color3.fromRGB(25,25,25)
inputBox.TextColor3 = Color3.new(1,1,1)
inputBox.Parent = frame

-- Toggle
local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.fromScale(0.6, 0.22)
toggleBtn.Position = UDim2.fromScale(0.2, 0.55)
toggleBtn.Text = "START"
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextScaled = true
toggleBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
toggleBtn.TextColor3 = Color3.new(0,1,0)
toggleBtn.Parent = frame

-- Reopen
local reopenBtn = Instance.new("TextButton")
reopenBtn.Size = UDim2.fromScale(0.08, 0.08)
reopenBtn.Position = UDim2.fromScale(0.4, 0.85)
reopenBtn.Text = "OPEN"
reopenBtn.Visible = false
reopenBtn.Font = Enum.Font.GothamBold
reopenBtn.TextScaled = true
reopenBtn.BackgroundColor3 = Color3.fromRGB(20,20,20)
reopenBtn.TextColor3 = Color3.new(1,1,1)
reopenBtn.Active = true
reopenBtn.Parent = gui

-- Reopen drag
local rDragging, rStart, rPos
reopenBtn.InputBegan:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
        rDragging = true
        rStart = inp.Position
        rPos = reopenBtn.Position
    end
end)
reopenBtn.InputEnded
