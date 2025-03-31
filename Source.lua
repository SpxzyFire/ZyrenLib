-- ZyrenLib Main Module
local ZyrenLib = {}
ZyrenLib.__index = ZyrenLib

-- Theme presets
local Themes = {
    Synapse = {
        Background = Color3.fromRGB(28, 28, 32),
        TabBackground = Color3.fromRGB(35, 35, 40),
        GroupBackground = Color3.fromRGB(22, 22, 25),
        HeaderBackground = Color3.fromRGB(40, 40, 45),
        Accent = Color3.fromRGB(0, 162, 255),
        TextColor = Color3.fromRGB(240, 240, 240),
        TextSize = 13,
        Font = Enum.Font.Gotham,
        GroupFont = Enum.Font.GothamBold
    },
    Dark = {
        Background = Color3.fromRGB(20, 20, 20),
        TabBackground = Color3.fromRGB(30, 30, 30),
        GroupBackground = Color3.fromRGB(15, 15, 15),
        HeaderBackground = Color3.fromRGB(25, 25, 25),
        Accent = Color3.fromRGB(255, 255, 255),
        TextColor = Color3.fromRGB(220, 220, 220),
        TextSize = 13,
        Font = Enum.Font.SourceSans,
        GroupFont = Enum.Font.SourceSansBold
    },
    Red = {
        Background = Color3.fromRGB(30, 20, 20),
        TabBackground = Color3.fromRGB(40, 25, 25),
        GroupBackground = Color3.fromRGB(20, 15, 15),
        HeaderBackground = Color3.fromRGB(45, 30, 30),
        Accent = Color3.fromRGB(255, 60, 60),
        TextColor = Color3.fromRGB(240, 220, 220),
        TextSize = 13,
        Font = Enum.Font.SourceSans,
        GroupFont = Enum.Font.SourceSansBold
    },
    Ocean = {
        Background = Color3.fromRGB(20, 25, 35),
        TabBackground = Color3.fromRGB(25, 35, 45),
        GroupBackground = Color3.fromRGB(15, 20, 30),
        HeaderBackground = Color3.fromRGB(30, 40, 50),
        Accent = Color3.fromRGB(0, 180, 210),
        TextColor = Color3.fromRGB(220, 240, 255),
        TextSize = 13,
        Font = Enum.Font.SourceSans,
        GroupFont = Enum.Font.SourceSansBold
    },
    Midnight = {
        Background = Color3.fromRGB(10, 10, 20),
        TabBackground = Color3.fromRGB(20, 20, 35),
        GroupBackground = Color3.fromRGB(5, 5, 15),
        HeaderBackground = Color3.fromRGB(25, 25, 40),
        Accent = Color3.fromRGB(140, 80, 255),
        TextColor = Color3.fromRGB(220, 220, 240),
        TextSize = 13,
        Font = Enum.Font.SourceSans,
        GroupFont = Enum.Font.SourceSansBold
    },
    GrapeTheme = {
        Background = Color3.fromRGB(35, 20, 40),
        TabBackground = Color3.fromRGB(45, 25, 50),
        GroupBackground = Color3.fromRGB(25, 15, 30),
        HeaderBackground = Color3.fromRGB(50, 30, 55),
        Accent = Color3.fromRGB(180, 80, 220),
        TextColor = Color3.fromRGB(240, 220, 245),
        TextSize = 13,
        Font = Enum.Font.SourceSans,
        GroupFont = Enum.Font.SourceSansBold
    }
}

-- Constructor
function ZyrenLib.new(config)
    local self = setmetatable({}, ZyrenLib)
    
    -- Validate config
    config = config or {}
    self.WindowTitle = config.WindowTitle or "Zyren UI"
    self.Theme = Themes[config.ColorTheme or "Synapse"] or Themes.Synapse
    
    -- Create main UI elements
    self:InitializeUI()
    
    return self
end

-- UI Initialization
function ZyrenLib:InitializeUI()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    
    -- Main ScreenGui
    self.ScreenGui = Instance.new("ScreenGui")
    self.ScreenGui.Name = "ZyrenLibUI"
    self.ScreenGui.ResetOnSpawn = false
    self.ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
    self.ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    
    -- Main Container
    self.MainContainer = Instance.new("Frame")
    self.MainContainer.Name = "Main"
    self.MainContainer.Size = UDim2.new(0, 600, 0, 450)
    self.MainContainer.Position = UDim2.new(0.5, -300, 0.5, -225)
    self.MainContainer.AnchorPoint = Vector2.new(0.5, 0.5)
    self.MainContainer.BackgroundColor3 = self.Theme.Background
    self.MainContainer.BackgroundTransparency = 0.1
    self.MainContainer.BorderSizePixel = 0
    self.MainContainer.Parent = self.ScreenGui
    
    -- Top Bar
    self.TopBar = Instance.new("Frame")
    self.TopBar.Name = "TopBar"
    self.TopBar.Size = UDim2.new(1, 0, 0, 35)
    self.TopBar.BackgroundColor3 = self.Theme.TabBackground
    self.TopBar.BorderSizePixel = 0
    self.TopBar.Parent = self.MainContainer
    
    -- Title
    self.Title = Instance.new("TextLabel")
    self.Title.Name = "Title"
    self.Title.Text = self.WindowTitle
    self.Title.Font = self.Theme.GroupFont
    self.Title.TextSize = 16
    self.Title.TextColor3 = self.Theme.TextColor
    self.Title.Size = UDim2.new(0, 200, 1, 0)
    self.Title.BackgroundTransparency = 1
    self.Title.TextXAlignment = Enum.TextXAlignment.Left
    self.Title.Parent = self.TopBar
    self.Title.Position = UDim2.new(0, 10, 0, 0)
    
    -- Tab Container
    self.TabContainer = Instance.new("Frame")
    self.TabContainer.Name = "TabContainer"
    self.TabContainer.Size = UDim2.new(1, -210, 1, 0)
    self.TabContainer.Position = UDim2.new(0, 210, 0, 0)
    self.TabContainer.BackgroundTransparency = 1
    self.TabContainer.Parent = self.TopBar
    
    self.TabListLayout = Instance.new("UIListLayout")
    self.TabListLayout.FillDirection = Enum.FillDirection.Horizontal
    self.TabListLayout.Padding = UDim.new(0, 5)
    self.TabListLayout.Parent = self.TabContainer
    
    -- Content Area
    self.ContentContainer = Instance.new("Frame")
    self.ContentContainer.Name = "Content"
    self.ContentContainer.Size = UDim2.new(1, -20, 1, -45)
    self.ContentContainer.Position = UDim2.new(0, 10, 0, 40)
    self.ContentContainer.BackgroundTransparency = 1
    self.ContentContainer.Parent = self.MainContainer
    
    -- Columns
    self.LeftColumn = Instance.new("Frame")
    self.LeftColumn.Name = "Left"
    self.LeftColumn.Size = UDim2.new(0.5, -10, 1, 0)
    self.LeftColumn.BackgroundTransparency = 1
    self.LeftColumn.Parent = self.ContentContainer
    
    self.RightColumn = Instance.new("Frame")
    self.RightColumn.Name = "Right"
    self.RightColumn.Size = UDim2.new(0.5, -10, 1, 0)
    self.RightColumn.Position = UDim2.new(0.5, 10, 0, 0)
    self.RightColumn.BackgroundTransparency = 1
    self.RightColumn.Parent = self.ContentContainer
    
    -- Initialize tabs table
    self.Tabs = {}
    self.CurrentTab = nil
    
    -- Setup draggable window
    self:SetupDraggable()
end

-- Draggable Window Setup
function ZyrenLib:SetupDraggable()
    local dragging, dragInput, dragStart, startPos
    
    local function UpdateDrag(input)
        local delta = input.Position - dragStart
        self.MainContainer.Position = startPos + UDim2.new(0, delta.X, 0, delta.Y)
    end
    
    self.TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = self.MainContainer.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    self.TopBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            UpdateDrag(input)
        end
    end)
end

-- Tab Creation
function ZyrenLib:CreateTab(name)
    local Tab = {
        Name = name,
        Groups = {}
    }
    
    local TabButton = Instance.new("TextButton")
    TabButton.Name = name
    TabButton.Text = name
    TabButton.Font = self.Theme.GroupFont
    TabButton.TextSize = self.Theme.TextSize
    TabButton.TextColor3 = self.Theme.TextColor
    TabButton.Size = UDim2.new(0, 90, 0.8, 0)
    TabButton.Position = UDim2.new(0, 0, 0.1, 0)
    TabButton.BackgroundColor3 = self.Theme.TabBackground
    TabButton.BorderSizePixel = 0
    TabButton.AutoButtonColor = false
    TabButton.Parent = self.TabContainer
    
    local TabContent = Instance.new("Frame")
    TabContent.Name = name
    TabContent.Size = UDim2.new(1, 0, 1, 0)
    TabContent.BackgroundTransparency = 1
    TabContent.Visible = false
    TabContent.Parent = self.ContentContainer
    
    TabButton.MouseButton1Click:Connect(function()
        if self.CurrentTab then
            self.CurrentTab.Content.Visible = false
            self.CurrentTab.Button.BackgroundColor3 = self.Theme.TabBackground
        end
        
        self.CurrentTab = Tab
        TabContent.Visible = true
        TabButton.BackgroundColor3 = self.Theme.Accent
    end)
    
    Tab.Button = TabButton
    Tab.Content = TabContent
    table.insert(self.Tabs, Tab)
    
    if #self.Tabs == 1 then
        TabButton.BackgroundColor3 = self.Theme.Accent
        TabContent.Visible = true
        self.CurrentTab = Tab
    end
    
    -- Group Creation Method
    function Tab:CreateGroup(name, side)
        local Group = {
            Name = name,
            Options = {}
        }
        
        local GroupContainer = side == "right" and self.RightColumn or self.LeftColumn
        
        local GroupFrame = Instance.new("Frame")
        GroupFrame.Name = name
        GroupFrame.Size = UDim2.new(1, 0, 0, 30) -- Height auto-adjusts
        GroupFrame.BackgroundColor3 = self.Theme.GroupBackground
        GroupFrame.BackgroundTransparency = 0.1
        GroupFrame.BorderSizePixel = 0
        GroupFrame.Parent = TabContent
        
        local GroupLabel = Instance.new("TextLabel")
        GroupLabel.Name = "Label"
        GroupLabel.Text = "  " .. name
        GroupLabel.Font = self.Theme.GroupFont
        GroupLabel.TextSize = self.Theme.TextSize + 1
        GroupLabel.TextColor3 = self.Theme.TextColor
        GroupLabel.TextXAlignment = Enum.TextXAlignment.Left
        GroupLabel.Size = UDim2.new(1, 0, 0, 25)
        GroupLabel.BackgroundColor3 = self.Theme.HeaderBackground
        GroupLabel.BorderSizePixel = 0
        GroupLabel.Parent = GroupFrame
        
        local Content = Instance.new("Frame")
        Content.Name = "Content"
        Content.Position = UDim2.new(0, 5, 0, 25)
        Content.Size = UDim2.new(1, -10, 1, -25)
        Content.BackgroundTransparency = 1
        Content.Parent = GroupFrame
        
        local Layout = Instance.new("UIListLayout")
        Layout.Padding = UDim.new(0, 8)
        Layout.Parent = Content
        Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            GroupFrame.Size = UDim2.new(1, 0, 0, Layout.AbsoluteContentSize.Y + 30)
        end)
        
        -- Control Creation Methods
        function Group:AddToggle(config)
            local Toggle = {
                Name = config.Text,
                Value = config.Default or false
            }
            
            local ToggleFrame = Instance.new("Frame")
            ToggleFrame.Name = config.Text
            ToggleFrame.Size = UDim2.new(1, 0, 0, 25)
            ToggleFrame.BackgroundTransparency = 1
            ToggleFrame.Parent = Content
            
            local ToggleLabel = Instance.new("TextLabel")
            ToggleLabel.Name = "Label"
            ToggleLabel.Text = config.Text
            ToggleLabel.Font = self.Theme.Font
            ToggleLabel.TextSize = self.Theme.TextSize
            ToggleLabel.TextColor3 = self.Theme.TextColor
            ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
            ToggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
            ToggleLabel.BackgroundTransparency = 1
            ToggleLabel.Parent = ToggleFrame
            
            local ToggleButton = Instance.new("TextButton")
            ToggleButton.Name = "Toggle"
            ToggleButton.Size = UDim2.new(0, 40, 0, 20)
            ToggleButton.Position = UDim2.new(1, -40, 0.5, -10)
            ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            ToggleButton.AutoButtonColor = false
            ToggleButton.Text = ""
            ToggleButton.Parent = ToggleFrame
            
            local ToggleDot = Instance.new("Frame")
            ToggleDot.Name = "Dot"
            ToggleDot.Size = UDim2.new(0, 16, 0, 16)
            ToggleDot.Position = UDim2.new(0, 2, 0, 2)
            ToggleDot.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
            ToggleDot.Parent = ToggleButton
            
            local function UpdateToggle()
                if Toggle.Value then
                    game:GetService("TweenService"):Create(ToggleDot, TweenInfo.new(0.15), {
                        Position = UDim2.new(1, -18, 0, 2),
                        BackgroundColor3 = self.Theme.Accent
                    }):Play()
                    game:GetService("TweenService"):Create(ToggleButton, TweenInfo.new(0.15), {
                        BackgroundColor3 = Color3.fromRGB(
                            math.floor(self.Theme.Accent.R * 255 * 0.2),
                            math.floor(self.Theme.Accent.G * 255 * 0.2),
                            math.floor(self.Theme.Accent.B * 255 * 0.2)
                        ) / 255
                    }):Play()
                else
                    game:GetService("TweenService"):Create(ToggleDot, TweenInfo.new(0.15), {
                        Position = UDim2.new(0, 2, 0, 2),
                        BackgroundColor3 = Color3.fromRGB(150, 150, 150)
                    }):Play()
                    game:GetService("TweenService"):Create(ToggleButton, TweenInfo.new(0.15), {
                        BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                    }):Play()
                end
                
                if config.Callback then
                    config.Callback(Toggle.Value)
                end
            end
            
            ToggleButton.MouseButton1Click:Connect(function()
                Toggle.Value = not Toggle.Value
                UpdateToggle()
            end)
            
            UpdateToggle()
            
            function Toggle:SetValue(value)
                Toggle.Value = value
                UpdateToggle()
            end
            
            table.insert(self.Options, Toggle)
            return Toggle
        end
        
        function Group:AddSlider(config)
            local Slider = {
                Name = config.Text,
                Value = config.Default or config.Min,
                Min = config.Min or 0,
                Max = config.Max or 100,
                Rounding = config.Rounding or 0,
                Suffix = config.Suffix or ""
            }
            
            local SliderFrame = Instance.new("Frame")
            SliderFrame.Name = config.Text
            SliderFrame.Size = UDim2.new(1, 0, 0, 45)
            SliderFrame.BackgroundTransparency = 1
            SliderFrame.Parent = Content
            
            local SliderLabel = Instance.new("TextLabel")
            SliderLabel.Name = "Label"
            SliderLabel.Text = config.Text
            SliderLabel.Font = self.Theme.Font
            SliderLabel.TextSize = self.Theme.TextSize
            SliderLabel.TextColor3 = self.Theme.TextColor
            SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
            SliderLabel.Size = UDim2.new(1, -40, 0, 15)
            SliderLabel.BackgroundTransparency = 1
            SliderLabel.Parent = SliderFrame
            
            local SliderValue = Instance.new("TextLabel")
            SliderValue.Name = "Value"
            SliderValue.Text = tostring(Slider.Value)..Slider.Suffix
            SliderValue.Font = self.Theme.Font
            SliderValue.TextSize = self.Theme.TextSize
            SliderValue.TextColor3 = self.Theme.TextColor
            SliderValue.TextXAlignment = Enum.TextXAlignment.Right
            SliderValue.Size = UDim2.new(0, 40, 0, 15)
            SliderValue.BackgroundTransparency = 1
            SliderValue.Parent = SliderFrame
            
            local SliderTrack = Instance.new("Frame")
            SliderTrack.Name = "Track"
            SliderTrack.Size = UDim2.new(1, 0, 0, 4)
            SliderTrack.Position = UDim2.new(0, 0, 0, 30)
            SliderTrack.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            SliderTrack.BorderSizePixel = 0
            SliderTrack.Parent = SliderFrame
            
            local SliderFill = Instance.new("Frame")
            SliderFill.Name = "Fill"
            SliderFill.Size = UDim2.new((Slider.Value - Slider.Min) / (Slider.Max - Slider.Min), 0, 1, 0)
            SliderFill.BackgroundColor3 = self.Theme.Accent
            SliderFill.BorderSizePixel = 0
            SliderFill.Parent = SliderTrack
            
            local SliderHandle = Instance.new("TextButton")
            SliderHandle.Name = "Handle"
            SliderHandle.Size = UDim2.new(0, 12, 0, 12)
            SliderHandle.Position = UDim2.new(SliderFill.Size.X.Scale, -6, 0.5, -6)
            SliderHandle.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
            SliderHandle.AutoButtonColor = false
            SliderHandle.Text = ""
            SliderHandle.Parent = SliderTrack
            
            local function UpdateSlider(value)
                local rounded = Slider.Rounding > 0 and math.floor((value / Slider.Rounding) + 0.5) * Slider.Rounding or value
                Slider.Value = math.clamp(rounded, Slider.Min, Slider.Max)
                
                local scale = (Slider.Value - Slider.Min) / (Slider.Max - Slider.Min)
                SliderFill.Size = UDim2.new(scale, 0, 1, 0)
                SliderHandle.Position = UDim2.new(scale, -6, 0.5, -6)
                SliderValue.Text = tostring(Slider.Value)..Slider.Suffix
                
                if config.Callback then
                    config.Callback(Slider.Value)
                end
            end
            
            -- Slider interaction
            local dragging = false
            SliderHandle.MouseButton1Down:Connect(function()
                dragging = true
            end)
            
            game:GetService("UserInputService").InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                end
            end)
            
            game:GetService("UserInputService").InputChanged:Connect(function(input)
                if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    local pos = SliderTrack.AbsolutePosition
                    local size = SliderTrack.AbsoluteSize
                    local relative = math.clamp((game:GetService("Players").LocalPlayer:GetMouse().X - pos.X) / size.X, 0, 1)
                    local value = Slider.Min + (relative * (Slider.Max - Slider.Min))
                    UpdateSlider(value)
                end
            end)
            
            SliderTrack.MouseButton1Down:Connect(function(x, y)
                local relative = math.clamp((x - SliderTrack.AbsolutePosition.X) / SliderTrack.AbsoluteSize.X, 0, 1)
                local value = Slider.Min + (relative * (Slider.Max - Slider.Min))
                UpdateSlider(value)
            end)
            
            function Slider:SetValue(value)
                UpdateSlider(value)
            end
            
            table.insert(self.Options, Slider)
            return Slider
        end
        
        function Group:AddButton(config)
            local Button = {
                Name = config.Text,
                Callback = config.Callback
            }
            
            local ButtonFrame = Instance.new("TextButton")
            ButtonFrame.Name = config.Text
            ButtonFrame.Size = UDim2.new(1, 0, 0, 25)
            ButtonFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            ButtonFrame.AutoButtonColor = false
            ButtonFrame.Text = config.Text
            ButtonFrame.Font = self.Theme.Font
            ButtonFrame.TextSize = self.Theme.TextSize
            ButtonFrame.TextColor3 = self.Theme.TextColor
            ButtonFrame.Parent = Content
            
            local ButtonHighlight = Instance.new("Frame")
            ButtonHighlight.Name = "Highlight"
            ButtonHighlight.Size = UDim2.new(1, 0, 1, 0)
            ButtonHighlight.BackgroundColor3 = self.Theme.Accent
            ButtonHighlight.BackgroundTransparency = 1
            ButtonHighlight.BorderSizePixel = 0
            ButtonHighlight.Parent = ButtonFrame
            
            ButtonFrame.MouseEnter:Connect(function()
                game:GetService("TweenService"):Create(ButtonHighlight, TweenInfo.new(0.15), {
                    BackgroundTransparency = 0.8
                }):Play()
            end)
            
            ButtonFrame.MouseLeave:Connect(function()
                game:GetService("TweenService"):Create(ButtonHighlight, TweenInfo.new(0.15), {
                    BackgroundTransparency = 1
                }):Play()
            end)
            
            ButtonFrame.MouseButton1Click:Connect(function()
                if Button.Callback then
                    Button.Callback()
                end
                
                -- Click animation
                game:GetService("TweenService"):Create(ButtonHighlight, TweenInfo.new(0.1), {
                    BackgroundTransparency = 0.6
                }):Play()
                game:GetService("TweenService"):Create(ButtonHighlight, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    BackgroundTransparency = 0.8
                }):Play()
            end)
            
            table.insert(self.Options, Button)
            return Button
        end
        
        -- [Additional control methods would go here...]
        
        table.insert(self.Groups, Group)
        return Group
    end
    
    return Tab
end

-- Return the constructor
return function(config)
    return ZyrenLib.new(config)
end
