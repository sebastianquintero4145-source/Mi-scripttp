pcall(function()
    game:GetService('CoreGui'):FindFirstChild('ui'):Remove()
end)

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

local Library = {}
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

-- Create UI
function Library:Window(title)
    local ui = Instance.new("ScreenGui")
    ui.Name = "ui"
    ui.Parent = CoreGui
    ui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ui.IgnoreGuiInset = true
    ui.ResetOnSpawn = false
    
    -- Main Frame
    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.Parent = ui
    Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Main.BorderSizePixel = 0
    Main.Position = UDim2.new(0.377, 0, 0.368, 0)
    Main.Size = UDim2.new(0, 470, 0, 283)
    Main.Active = true
    Main.Selectable = true
    
    -- Make draggable
    local dragging = false
    local dragInput, dragStart, startPos
    
    local function updateInput(input)
        local Delta = input.Position - dragStart
        Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
    end
    
    Main.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = Main.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    Main.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            updateInput(input)
        end
    end)
    
    -- Corner
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = Main
    
    -- Shadow
    local Shadow = Instance.new("ImageLabel")
    Shadow.Name = "Shadow"
    Shadow.Parent = Main
    Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    Shadow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Shadow.BackgroundTransparency = 1.000
    Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    Shadow.Size = UDim2.new(1, 30, 1, 30)
    Shadow.ZIndex = 0
    Shadow.Image = "rbxassetid://5554236805"
    Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.SliceCenter = Rect.new(23, 23, 277, 277)
    
    -- Top Bar
    local Top = Instance.new("Frame")
    Top.Name = "Top"
    Top.Parent = Main
    Top.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
    Top.BorderSizePixel = 0
    Top.Size = UDim2.new(1, 0, 0, 34)
    
    local TopCorner = Instance.new("UICorner")
    TopCorner.CornerRadius = UDim.new(0, 6)
    TopCorner.Parent = Top
    
    local TopCover = Instance.new("Frame")
    TopCover.Name = "Cover"
    TopCover.Parent = Top
    TopCover.AnchorPoint = Vector2.new(0.5, 1)
    TopCover.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
    TopCover.BorderSizePixel = 0
    TopCover.Position = UDim2.new(0.5, 0, 1, 0)
    TopCover.Size = UDim2.new(1, 0, 0, 4)
    
    local Line = Instance.new("Frame")
    Line.Name = "Line"
    Line.Parent = Top
    Line.AnchorPoint = Vector2.new(0.5, 1)
    Line.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Line.BackgroundTransparency = 0.920
    Line.Position = UDim2.new(0, 20, 0, 20)
    Line.Size = UDim2.new(1, 0, 0, 1)
    
    -- Logo
    local Logo = Instance.new("ImageLabel")
    Logo.Name = "Logo"
    Logo.Parent = Top
    Logo.AnchorPoint = Vector2.new(0, 0.5)
    Logo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Logo.BackgroundTransparency = 1.000
    Logo.Position = UDim2.new(0, 4, 0.5, 0)
    Logo.Size = UDim2.new(0, 26, 0, 30)
    Logo.Image = "http://www.roblox.com/asset/?id=110728705873113"
    Logo.ImageColor3 = Color3.fromRGB(232, 17, 85)
    
    -- Minimize Button (using minus icon)
    local Minimize = Instance.new("ImageButton")
    Minimize.Name = "Minimize"
    Minimize.Parent = Top
    Minimize.AnchorPoint = Vector2.new(1, 0.5)
    Minimize.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Minimize.BackgroundTransparency = 1.000
    Minimize.Position = UDim2.new(1, -6, 0.5, 0)  -- ← DE -30 A -6
    Minimize.Size = UDim2.new(0, 20, 0, 20)
    Minimize.Image = "rbxassetid://7733771811" -- Minus icon
    Minimize.ImageColor3 = Color3.fromRGB(199, 199, 199)
    Minimize.ScaleType = Enum.ScaleType.Crop
        
    -- Minimized Icon (initially hidden)
    local MinimizedIcon = Instance.new("ImageButton")
    MinimizedIcon.Name = "MinimizedIcon"
    MinimizedIcon.Parent = ui
    MinimizedIcon.AnchorPoint = Vector2.new(1, 1)
    MinimizedIcon.BackgroundColor3 = Color3.fromRGB(232, 17, 85)
    MinimizedIcon.BackgroundTransparency = 0
    MinimizedIcon.BorderSizePixel = 0
    MinimizedIcon.Position = UDim2.new(1, -20, 1, -20)
    MinimizedIcon.Size = UDim2.new(0, 40, 0, 40)
    MinimizedIcon.Visible = false
    MinimizedIcon.ZIndex = 10
    MinimizedIcon.Image = "http://www.roblox.com/asset/?id=110728705873113"
    
    local MinimizedCorner = Instance.new("UICorner")
    MinimizedCorner.CornerRadius = UDim.new(0, 8)
    MinimizedCorner.Parent = MinimizedIcon
    
    -- Make minimized icon draggable
    local minDragging = false
    local minDragInput, minDragStart, minStartPos
    
    local function updateMinInput(input)
        local Delta = input.Position - minDragStart
        MinimizedIcon.Position = UDim2.new(minStartPos.X.Scale, minStartPos.X.Offset + Delta.X, minStartPos.Y.Scale, minStartPos.Y.Offset + Delta.Y)
    end
    
    MinimizedIcon.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            minDragging = true
            minDragStart = input.Position
            minStartPos = MinimizedIcon.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    minDragging = false
                end
            end)
        end
    end)
    
    MinimizedIcon.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            minDragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == minDragInput and minDragging then
            updateMinInput(input)
        end
    end)
    
    -- Minimize functionality
    Minimize.MouseButton1Click:Connect(function()
        Main.Visible = false
        MinimizedIcon.Visible = true
    end)
    
    Minimize.MouseEnter:Connect(function()
        TweenService:Create(Minimize, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(255,255,255)}):Play()
    end)
    
    Minimize.MouseLeave:Connect(function()
        TweenService:Create(Minimize, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(166, 166, 166)}):Play()
    end)
    
    -- Restore functionality
    MinimizedIcon.MouseButton1Click:Connect(function()
        Main.Visible = true
        MinimizedIcon.Visible = false
    end)
    
    -- Close Button (OCULTO)
    local Close = Instance.new("ImageButton")
    Close.Name = "Close"
    Close.Parent = Top
    Close.AnchorPoint = Vector2.new(1, 0.5)
    Close.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Close.BackgroundTransparency = 1.000
    Close.Position = UDim2.new(1, -6, 0.5, 0)
    Close.Size = UDim2.new(0, 20, 0, 20)
    Close.Image = "http://www.roblox.com/asset/?id=7755372427"
    Close.ImageColor3 = Color3.fromRGB(199, 199, 199)
    Close.ScaleType = Enum.ScaleType.Crop
    Close.Visible = false  -- ← ESTA ES LA LÍNEA IMPORTANTE
    Close.Active = false   -- ← Y ESTA TAMBIÉN

-- Mantener estas funciones por si acaso, pero no se ejecutarán porque el botón está oculto
Close.MouseButton1Click:Connect(function()
    ui:Destroy()
end)

Close.MouseEnter:Connect(function()
    TweenService:Create(Close, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(255,255,255)}):Play()
end)

Close.MouseLeave:Connect(function()
    TweenService:Create(Close, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(166, 166, 166)}):Play()
end)
    
    -- Title
    local GameName = Instance.new("TextLabel")
    GameName.Name = "GameName"
    GameName.Parent = Top 
    GameName.AnchorPoint = Vector2.new(0, 0.5)
    GameName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    GameName.BackgroundTransparency = 1.000
    GameName.Position = UDim2.new(0, 32, 0.5, 0)
    GameName.Size = UDim2.new(0, 165, 0, 22)
    GameName.Font = Enum.Font.Gotham
    GameName.Text = title or "Game Name"
    GameName.TextColor3 = Color3.fromRGB(232, 17, 85)
    GameName.TextSize = 14.000
    GameName.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Tabs Container
    local Tabs = Instance.new("Frame")
    Tabs.Name = "Tabs"
    Tabs.Parent = Main
    Tabs.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
    Tabs.BorderSizePixel = 0
    Tabs.Position = UDim2.new(0, 0, 0, 35)
    Tabs.Size = UDim2.new(0, 122, 1, -35)
    
    local TabsCorner = Instance.new("UICorner")
    TabsCorner.CornerRadius = UDim.new(0, 6)
    TabsCorner.Parent = Tabs
    
    local TabsCover = Instance.new("Frame")
    TabsCover.Name = "Cover"
    TabsCover.Parent = Tabs
    TabsCover.AnchorPoint = Vector2.new(1, 0.5)
    TabsCover.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
    TabsCover.BorderSizePixel = 0
    TabsCover.Position = UDim2.new(1, 0, 0.5, 0)
    TabsCover.Size = UDim2.new(0, 5, 1, 0)
    
    local TabsContainer = Instance.new("Frame")
    TabsContainer.Name = "TabsContainer"
    TabsContainer.Parent = Tabs
    TabsContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabsContainer.BackgroundTransparency = 1.000
    TabsContainer.Size = UDim2.new(1, 0, 1, 0)
    
    local TabsList = Instance.new("UIListLayout")
    TabsList.Name = "TabsList"
    TabsList.Parent = TabsContainer
    TabsList.HorizontalAlignment = Enum.HorizontalAlignment.Center
    TabsList.SortOrder = Enum.SortOrder.LayoutOrder
    TabsList.Padding = UDim.new(0, 5)
    
    local TabsPadding = Instance.new("UIPadding")
    TabsPadding.Parent = TabsContainer
    TabsPadding.PaddingTop = UDim.new(0, 5)
    
    -- Pages Container
    local Pages = Instance.new("Frame")
    Pages.Name = "Pages"
    Pages.Parent = Main
    Pages.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Pages.BorderSizePixel = 0
    Pages.Position = UDim2.new(0, 130, 0, 42)
    Pages.Size = UDim2.new(1, -138, 1, -50)
    
    local PagesCorner = Instance.new("UICorner")
    PagesCorner.CornerRadius = UDim.new(0, 6)
    PagesCorner.Parent = Pages
    
    -- Resize Button
    local Resize = Instance.new("ImageButton")
    Resize.Name = "Resize"
    Resize.Parent = Main
    Resize.AnchorPoint = Vector2.new(1, 1)
    Resize.BackgroundTransparency = 1.000
    Resize.Position = UDim2.new(1, -4, 1, -4)
    Resize.Size = UDim2.new(0, 16, 0, 16)
    Resize.ZIndex = 2
    Resize.Image = "rbxassetid://3926307971"
    Resize.ImageColor3 = Color3.fromRGB(186, 13, 68)
    Resize.ImageRectOffset = Vector2.new(204, 364)
    Resize.ImageRectSize = Vector2.new(36, 36)
    
    -- Resize functionality
    local resizing = false
    local resizeStart, startSize
    
    Resize.MouseButton1Down:Connect(function()
        resizing = true
        resizeStart = Vector2.new(Mouse.X, Mouse.Y)
        startSize = Main.Size
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if resizing and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = Vector2.new(input.Position.X - resizeStart.X, input.Position.Y - resizeStart.Y)
            Main.Size = UDim2.new(0, math.max(470, startSize.X.Offset + delta.X), 0, math.max(283, startSize.Y.Offset + delta.Y))
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            resizing = false
        end
    end)
    
    -- Tab functionality
    local TabFunctions = {}
    function TabFunctions:Tab(tabInfo)
        local title, icon
        if type(tabInfo) == "table" then
            title = tabInfo[1] or "Tab"
            icon = tabInfo[2]
        else
            title = tabInfo or "Tab"
        end
        
        local TabButton = Instance.new("TextButton")
        TabButton.Name = "TabButton"
        TabButton.Parent = TabsContainer
        TabButton.BackgroundColor3 = Color3.fromRGB(232, 17, 85)
        TabButton.BackgroundTransparency = 1
        TabButton.Size = UDim2.new(1, -12, 0, 30)
        TabButton.AutoButtonColor = false
        TabButton.Font = Enum.Font.Gotham
        TabButton.Text = ""
        TabButton.TextColor3 = Color3.fromRGB(72,72,72)
        TabButton.TextSize = 14.000
        
        local TabCorner = Instance.new("UICorner")
        TabCorner.CornerRadius = UDim.new(0, 6)
        TabCorner.Parent = TabButton
        
        -- Create container for icon and text
        local TabContent = Instance.new("Frame")
        TabContent.Name = "TabContent"
        TabContent.Parent = TabButton
        TabContent.BackgroundTransparency = 1
        TabContent.Size = UDim2.new(1, 0, 1, 0)
        
        -- Add icon if provided
        local Icon = nil
        if icon then
            Icon = Instance.new("ImageLabel")
            Icon.Name = "Icon"
            Icon.Parent = TabContent
            Icon.BackgroundTransparency = 1
            Icon.Position = UDim2.new(0, 5, 0.5, -10)
            Icon.Size = UDim2.new(0, 20, 0, 20)
            Icon.Image = icon
            Icon.ImageColor3 = Color3.fromRGB(232, 17, 85)
        end
        
        -- Add text label
        local TextLabel = Instance.new("TextLabel")
        TextLabel.Name = "TextLabel"
        TextLabel.Parent = TabContent
        TextLabel.BackgroundTransparency = 1
        TextLabel.Size = UDim2.new(1, 0, 1, 0)
        TextLabel.Font = Enum.Font.Gotham
        TextLabel.Text = title
        TextLabel.TextColor3 = Color3.fromRGB(72,72,72)
        TextLabel.TextSize = 14.000
        TextLabel.TextXAlignment = Enum.TextXAlignment.Center
        
        -- Adjust text position if icon is present
        if Icon then
            TextLabel.Position = UDim2.new(0, 25, 0, 0)
            TextLabel.TextXAlignment = Enum.TextXAlignment.Left
        end
        
        -- Page
        local Page = Instance.new("ScrollingFrame")
        Page.Name = "Page"
        Page.Visible = false
        Page.Parent = Pages
        Page.Active = true
        Page.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Page.BackgroundTransparency = 1.000
        Page.BorderSizePixel = 0
        Page.Size = UDim2.new(1, 0, 1, 0)
        Page.CanvasPosition = Vector2.new(0, 0)
        Page.ScrollBarThickness = 2
        Page.ScrollBarImageColor3 = Color3.fromRGB(255, 24, 101)
        
        local PageList = Instance.new("UIListLayout")
        PageList.Parent = Page
        PageList.HorizontalAlignment = Enum.HorizontalAlignment.Center
        PageList.SortOrder = Enum.SortOrder.LayoutOrder
        PageList.Padding = UDim.new(0, 6)
        
        local PagePadding = Instance.new("UIPadding")
        PagePadding.Parent = Page
        PagePadding.PaddingTop = UDim.new(0, 5)
        
        PageList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            Page.CanvasSize = UDim2.new(0, 0, 0, PageList.AbsoluteContentSize.Y)
        end)
        
        -- Tab button functionality
        TabButton.MouseButton1Click:Connect(function()
            for _,v in next, Pages:GetChildren() do
                if v:IsA("ScrollingFrame") then
                    v.Visible = false
                end
            end
            Page.Visible = true
            
            for _,v in next, TabsContainer:GetChildren() do
                if v.Name == 'TabButton' then
                    TweenService:Create(v, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
                    if v:FindFirstChild("TabContent") and v.TabContent:FindFirstChild("TextLabel") then
                        TweenService:Create(v.TabContent.TextLabel, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(72,72,72)}):Play()
                    end
                end
            end
            
            TweenService:Create(TabButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0.6}):Play()
            TweenService:Create(TextLabel, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(255,255,255)}):Play()
        end)
        
        -- First tab should be selected by default
        if #TabsContainer:GetChildren() == 1 then
            Page.Visible = true
            TweenService:Create(TabButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0.6}):Play()
            TweenService:Create(TextLabel, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(255,255,255)}):Play()
        end
        
        -- Element functions
        local Elements = {}
        
        -- Button
        function Elements:Button(text, callback)
            local Button = Instance.new("TextButton")
            Button.Name = "Button"
            Button.Parent = Page
            Button.BackgroundColor3 = Color3.fromRGB(134, 10, 49)
            Button.BorderSizePixel = 0
            Button.Size = UDim2.new(1, -6, 0, 34)
            Button.AutoButtonColor = false
            Button.Font = Enum.Font.Gotham
            Button.Text = text or "Button"
            Button.TextColor3 = Color3.fromRGB(255, 255, 255)
            Button.TextSize = 14.000
            
            local ButtonCorner = Instance.new("UICorner")
            ButtonCorner.CornerRadius = UDim.new(0, 6)
            ButtonCorner.Parent = Button
            
            Button.MouseEnter:Connect(function()
                TweenService:Create(Button, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(160, 12, 59)}):Play()
            end)
            
            Button.MouseLeave:Connect(function()
                TweenService:Create(Button, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(134, 10, 49)}):Play()
            end)
            
            Button.MouseButton1Click:Connect(function()
                callback()
            end)
            
            -- Mobile support
            Button.TouchTap:Connect(function()
                callback()
            end)
        end
        
        -- Toggle
-- Toggle con animación de switch estilo iOS
function Elements:Toggle(text, default, callback)
    local Toggle = Instance.new("TextButton")
    Toggle.Name = "Toggle"
    Toggle.Parent = Page
    Toggle.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Toggle.BorderSizePixel = 0
    Toggle.Size = UDim2.new(1, -6, 0, 34)
    T
