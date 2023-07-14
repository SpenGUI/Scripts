local Players = game:GetService("Players")
local highlight = Instance.new("Highlight")
highlight.Name = "Highlight"

--- settings
getgenv().isEnabled = false
getgenv().removeOutline = false
getgenv().teamCheck = false

function highlightPlayer(player)
    repeat wait() until player.Character
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
            if not highlight then
                highlightPlayer(player)
            else
                highlight.Enabled = isEnabled

                if removeOutline and isEnabled then
                    highlight.OutlineTransparency = 1
                elseif not removeOutline and isEnabled then
                    highlight.OutlineTransparency = 0
                end
            end
        end
    end
end

function playerAdded(player)
    print("ADDING PLAYER: ", player)
    repeat wait() until player.Character
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

game.Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        character:WaitForChild("Humanoid").Died:Connect(function()
            while character:FindFirstChild("Humanoid").Health == 0 do
                print("DEAD")
                wait()
            end
            print("HIGHLIGHTED")
            highlightPlayer(player)
        end)
    end)
end)

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("ESP by SpenW", "DarkTheme")
local Tab = Window:NewTab("Esp")
local Section = Tab:NewSection("Espp")

Section:NewToggle("Toggle Esp", "ToggleInfo", function(state)
    isEnabled = state
    if isEnabled then
        print("Toggle On")
    else
        print("Toggle Off")
    end
end)

Section:NewToggle("Remove outline", "ToggleInfo", function(state)
    removeOutline = state
    if removeOutline then
        print("Toggle On")
    else
        print("Toggle Off")
    end
end)

Section:NewToggle("team Color", "ToggleInfo", function(state)
    teamCheck = state
    if removeOutline then
        print("Toggle On")
    else
        print("Toggle Off")
    end
end)

while true do
    update()
    wait()
end
