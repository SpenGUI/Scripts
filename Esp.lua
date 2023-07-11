local Players = game:GetService("Players")
local highlight = Instance.new("Highlight")
highlight.Name = "Highlight"

--- settings
getgenv().isEnabled = false
getgenv().removeOutline = false

function highlightPlayer(player)
    repeat wait() until player.Character
    print(player)
    local highlightClone = highlight:Clone()
    highlightClone.Adornee = player.Character
    highlightClone.Parent = player.Character:FindFirstChild("HumanoidRootPart")
    highlightClone.Name = "Highlight"
    highlightClone.Enabled = isEnabled
end

function update()
    for i, player in ipairs(Players:GetPlayers()) do
        local humanoidRootPart = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            local highlight = humanoidRootPart:FindFirstChild("Highlight")
            if highlight then
                highlight.Enabled = isEnabled

                if removeOutline == true and isEnabled == true then
                    highlight.OutlineTransparency = 1
                elseif removeOutline == false and isEnabled == true then
                    highlight.OutlineTransparency = 0
                end
            end
        end
    end
end

function playerAdded(player)
    print("ADDING PLAYER: ", player)
    highlightPlayer(player)
end

function playerRemoving(player)
    print("REMOVING PLAYER: ", player)
    local humanoidRootPart = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if humanoidRootPart then
        local highlight = humanoidRootPart:FindFirstChild("Highlight")
        if highlight then
            highlight:Destroy()
        end
    end
end

Players.PlayerAdded:Connect(playerAdded)
Players.PlayerRemoving:Connect(playerRemoving)

for i, player in ipairs(Players:GetPlayers()) do
    highlightPlayer(player)
end

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("ESP by SpenW", "DarkTheme")
local Tab = Window:NewTab("Esp")
local Section = Tab:NewSection("Espp")

Section:NewToggle("Toggle Esp", "ToggleInfo", function(state)
    if state then
        isEnabled = true
        print("Toggle On")
    else
        isEnabled = false
        print("Toggle Off")
    end
end)

Section:NewToggle("Remove outline", "ToggleInfo", function(state)
    if state then
        removeOutline = true
        print("Toggle On")
    else
        removeOutline = false
        print("Toggle Off")
    end
end)

while true do
    update()
    wait()
end
