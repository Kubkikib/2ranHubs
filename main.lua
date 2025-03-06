local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = game.Workspace.CurrentCamera
local ESP_Enabled = true
local Hitbox_Enabled = false
local InfiniteJumpEnabled = true  -- Infinity Jump için yeni bir değişken

-- UI Oluştur
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 200, 0, 180)
MainFrame.Position = UDim2.new(0.5, -100, 0.5, -90) -- Ortalanmış
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0.2, 0)
Title.Text = "2ranHub "
Title.TextColor3 = Color3.fromRGB(255, 255, 255) -- Beyaz renk
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 22
Title.Parent = MainFrame

local ProPlus = Instance.new("TextLabel") -- Pro+ kısmı
ProPlus.Size = UDim2.new(0, 80, 0, 20)
ProPlus.Position = UDim2.new(1, -110, 0, 0) -- "Pro+" kısmının 2ranHub yazısının yanında
ProPlus.Text = "Pro+"
ProPlus.TextColor3 = Color3.fromRGB(255, 255, 255)
ProPlus.BackgroundTransparency = 1
ProPlus.Font = Enum.Font.SourceSansBold
ProPlus.TextSize = 22
ProPlus.Parent = MainFrame

-- Rainbow Efekti sadece Pro+ başlığında olacak
spawn(function()
    while wait(0.1) do
        ProPlus.TextColor3 = Color3.fromHSV(tick() % 5 / 5, 1, 1)
    end
end)

local VersionLabel = Instance.new("TextLabel")
VersionLabel.Size = UDim2.new(1, 0, 0.2, 0)
VersionLabel.Position = UDim2.new(0, 0, 0.4, 0)
VersionLabel.Text = "version 0.0.1"
VersionLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
VersionLabel.BackgroundTransparency = 1
VersionLabel.Font = Enum.Font.SourceSansBold
VersionLabel.TextSize = 10
VersionLabel.Parent = MainFrame

local ProfileLabel = Instance.new("TextLabel") -- Roblox profil ismi
ProfileLabel.Size = UDim2.new(1, 0, 0.2, 0)
ProfileLabel.Position = UDim2.new(0, 0, 0.6, 0)
ProfileLabel.Text = "Profil: " .. LocalPlayer.Name -- Roblox profil ismi burada
ProfileLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ProfileLabel.BackgroundTransparency = 1
ProfileLabel.Font = Enum.Font.SourceSansBold
ProfileLabel.TextSize = 14
ProfileLabel.Parent = MainFrame

local ToggleESP = Instance.new("TextButton")
ToggleESP.Size = UDim2.new(1, 0, 0.25, 0)
ToggleESP.Position = UDim2.new(0, 0, 0.8, 0)
ToggleESP.Text = "ESP Aç/Kapat"
ToggleESP.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleESP.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ToggleESP.Parent = MainFrame

local ToggleHitbox = Instance.new("TextButton")
ToggleHitbox.Size = UDim2.new(1, 0, 0.25, 0)
ToggleHitbox.Position = UDim2.new(0, 0, 1.05, 0) -- Sonraki Buton için boşluk
ToggleHitbox.Text = "Hitbox Büyüt"
ToggleHitbox.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleHitbox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ToggleHitbox.Parent = MainFrame

-- Infinity Jump'ı geri getiren kod
game:GetService("UserInputService").JumpRequest:connect(function()
    if InfiniteJumpEnabled then
        game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

-- Infinity Jump'ı açıp kapatacağımız buton
local ToggleInfiniteJump = Instance.new("TextButton")
ToggleInfiniteJump.Size = UDim2.new(1, 0, 0.25, 0)
ToggleInfiniteJump.Position = UDim2.new(0, 0, 1.3, 0)
ToggleInfiniteJump.Text = "Infinity Jump Aç/Kapat"
ToggleInfiniteJump.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleInfiniteJump.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ToggleInfiniteJump.Parent = MainFrame

-- Toggle Infinite Jump
ToggleInfiniteJump.MouseButton1Click:Connect(function()
    InfiniteJumpEnabled = not InfiniteJumpEnabled  -- Değişkeni tersine çevir
    if InfiniteJumpEnabled then
        ToggleInfiniteJump.Text = "Infinity Jump: Açık"
    else
        ToggleInfiniteJump.Text = "Infinity Jump: Kapalı"
    end
end)

-- K tuşu ile Client açma ve kapama
local clientOpen = false
local clientFrame

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end

    -- Eğer 'K' tuşuna basıldıysa, client'ı açıp kapat
    if input.KeyCode == Enum.KeyCode.K then
        if clientOpen then
            -- Eğer client açık ise, kapat
            clientFrame:Destroy()
            clientOpen = false
        else
            -- Client aç
            clientFrame = Instance.new("Frame")
            clientFrame.Size = UDim2.new(0, 400, 0, 300)
            clientFrame.Position = UDim2.new(0.5, -200, 0.5, -150) -- Ekranın ortasına
            clientFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            clientFrame.Parent = game.CoreGui

            local clientTitle = Instance.new("TextLabel")
            clientTitle.Size = UDim2.new(1, 0, 0.1, 0)
            clientTitle.Text = "Client - " .. LocalPlayer.Name
            clientTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            clientTitle.BackgroundTransparency = 1
            clientTitle.Font = Enum.Font.SourceSansBold
            clientTitle.TextSize = 18
            clientTitle.Parent = clientFrame

            local closeButton = Instance.new("TextButton")
            closeButton.Size = UDim2.new(0, 80, 0, 30)
            closeButton.Position = UDim2.new(1, -90, 0, 10)
            closeButton.Text = "Kapat"
            closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            closeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            closeButton.Parent = clientFrame

            closeButton.MouseButton1Click:Connect(function()
                clientFrame:Destroy()
                clientOpen = false
            end)

            clientOpen = true
        end
    end
end)

local function CreateESP(player)
    if player == LocalPlayer then return end
    if not player.Team then return end  -- Takımsız oyuncular için koruma

    local highlight = Instance.new("Highlight")
    highlight.Parent = player.Character
    highlight.Adornee = player.Character

    -- Takıma Göre Renk
    if player.Team == LocalPlayer.Team then
        highlight.FillColor = Color3.fromRGB(0, 255, 0) -- Yeşil (Takım arkadaşı)
    else
        highlight.FillColor = Color3.fromRGB(255, 0, 0) -- Kırmızı (Düşman)
    end

    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0.1

    player.CharacterAdded:Connect(function(char)
        highlight.Adornee = char
    end)
end

local function SetHitboxSize(size)
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
            local head = player.Character.Head
            head.Size = Vector3.new(size, size, size)
            head.Transparency = 0.3  -- Hafif saydamlık (dikkat çekmemesi için)
        end
    end
end

-- UI Butonları
ToggleESP.MouseButton1Click:Connect(function()
    ESP_Enabled = not ESP_Enabled
    if ESP_Enabled then
        ToggleESP.Text = "ESP Açık"
        for _, player in pairs(Players:GetPlayers()) do
            if player.Character then
                CreateESP(player)
            end
        end
    else
        ToggleESP.Text = "ESP Kapalı"
    end
end)

ToggleHitbox.MouseButton1Click:Connect(function()
    Hitbox_Enabled = not Hitbox_Enabled
    if Hitbox_Enabled then
        ToggleHitbox.Text = "Hitbox Büyütlü"
        SetHitboxSize(1.5)  -- 5 kat büyütülmüş
    else
        ToggleHitbox.Text = "Hitbox Küçük"
        SetHitboxSize(1)  -- Normal boyuta dön
    end
end)

-- ESP aktifken yeni oyuncular eklenirse, ESP'yi yeniden oluştur.
Players.PlayerAdded:Connect(function(player)
    if ESP_Enabled then
        CreateESP(player)
    end
end)

