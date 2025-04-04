local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- Main UI Setup
local Zyren = {
	Tabs = {},
	CurrentTab = nil,
	Theme = {
		Background = Color3.fromRGB(24, 24, 24),
		TabBackground = Color3.fromRGB(30, 30, 30),
		GroupBackground = Color3.fromRGB(20, 20, 20),
		Accent = Color3.fromRGB(0, 146, 255),
		TextColor = Color3.fromRGB(240, 240, 240),
		TextSize = 14,
		Font = Enum.Font.Gotham
	}
}

--[[
    Creates the main UI container
    Returns: ScreenGui object
]]
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ZyrenLib"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Main container frame (centered by default)
local MainContainer = Instance.new("Frame")
MainContainer.Name = "Main"
MainContainer.Size = UDim2.new(0, 550, 0, 400)
MainContainer.Position = UDim2.new(0.5, -275, 0.5, -200) -- Centered on screen
MainContainer.AnchorPoint = Vector2.new(0.5, 0.5) -- Ensures perfect center
MainContainer.BackgroundColor3 = Zyren.Theme.Background
MainContainer.BorderSizePixel = 0
MainContainer.Parent = ScreenGui

--[[
    UI Structure:
    - TopBar (contains title and tabs)
    - ContentContainer (holds all tab content)
      - LeftColumn (for groups)
      - RightColumn (for groups)
]]

-- Top navigation bar
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Zyren.Theme.TabBackground
TopBar.BorderSizePixel = 0
TopBar.Parent = MainContainer

-- Title label
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Text = "Zyren"
Title.Font = Zyren.Theme.Font
Title.TextSize = 18
Title.TextColor3 = Zyren.Theme.TextColor
Title.Size = UDim2.new(0, 100, 1, 0)
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar
Title.Position = UDim2.new(0, 10, 0, 0)

-- Tab container
local TabContainer = Instance.new("Frame")
TabContainer.Name = "TabContainer"
TabContainer.Size = UDim2.new(1, -110, 1, 0)
TabContainer.Position = UDim2.new(0, 110, 0, 0)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = TopBar

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.FillDirection = Enum.FillDirection.Horizontal
TabListLayout.Padding = UDim.new(0, 5)
TabListLayout.Parent = TabContainer

-- Main content area
local ContentContainer = Instance.new("Frame")
ContentContainer.Name = "Content"
ContentContainer.Size = UDim2.new(1, -20, 1, -50)
ContentContainer.Position = UDim2.new(0, 10, 0, 45)
ContentContainer.BackgroundTransparency = 1
ContentContainer.Parent = MainContainer

-- Columns for organization
local LeftColumn = Instance.new("Frame")
LeftColumn.Name = "Left"
LeftColumn.Size = UDim2.new(0.5, -5, 1, 0)
LeftColumn.BackgroundTransparency = 1
LeftColumn.Parent = ContentContainer

local RightColumn = Instance.new("Frame")
RightColumn.Name = "Right"
RightColumn.Size = UDim2.new(0.5, -5, 1, 0)
RightColumn.Position = UDim2.new(0.5, 5, 0, 0)
RightColumn.BackgroundTransparency = 1
RightColumn.Parent = ContentContainer

-- Draggable window implementation
local dragging, dragInput, dragStart, startPos

local function UpdateDrag(input)
	local delta = input.Position - dragStart
	MainContainer.Position = startPos + UDim2.new(0, delta.X, 0, delta.Y)
end

TopBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = MainContainer.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

TopBar.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		UpdateDrag(input)
	end
end)

--[[
    Creates a new tab in the UI
    @param name: string - The display name of the tab
    Returns: Tab object
]]
function Zyren:CreateTab(name)
	local Tab = {
		Name = name,
		Groups = {}
	}

	local TabButton = Instance.new("TextButton")
	TabButton.Name = name
	TabButton.Text = name
	TabButton.Font = Zyren.Theme.Font
	TabButton.TextSize = Zyren.Theme.TextSize
	TabButton.TextColor3 = Zyren.Theme.TextColor
	TabButton.Size = UDim2.new(0, 80, 1, 0)
	TabButton.BackgroundColor3 = Zyren.Theme.TabBackground
	TabButton.BorderSizePixel = 0
	TabButton.AutoButtonColor = false
	TabButton.Parent = TabContainer

	local TabContent = Instance.new("Frame")
	TabContent.Name = name
	TabContent.Size = UDim2.new(1, 0, 1, 0)
	TabContent.BackgroundTransparency = 1
	TabContent.Visible = false
	TabContent.Parent = ContentContainer

	TabButton.MouseButton1Click:Connect(function()
		if Zyren.CurrentTab then
			Zyren.CurrentTab.Content.Visible = false
			Zyren.CurrentTab.Button.BackgroundColor3 = Zyren.Theme.TabBackground
		end

		Zyren.CurrentTab = Tab
		TabContent.Visible = true
		TabButton.BackgroundColor3 = Zyren.Theme.Accent
	end)

	Tab.Button = TabButton
	Tab.Content = TabContent
	table.insert(self.Tabs, Tab)

	if #self.Tabs == 1 then
		TabButton.BackgroundColor3 = Zyren.Theme.Accent
		TabContent.Visible = true
		self.CurrentTab = Tab
	end

    --[[
        Creates a new group within this tab
        @param name: string - The display name of the group
        @param side: string ("left" or "right") - Which column to place the group in
        Returns: Group object
    ]]
	function Tab:CreateGroup(name, side)
		local Group = {
			Name = name,
			Options = {}
		}

		local GroupContainer = side == "right" and RightColumn or LeftColumn

		local GroupFrame = Instance.new("Frame")
		GroupFrame.Name = name
		GroupFrame.Size = UDim2.new(1, 0, 0, 30) -- Height will auto-adjust
		GroupFrame.BackgroundColor3 = Zyren.Theme.GroupBackground
		GroupFrame.BorderSizePixel = 0
		GroupFrame.Parent = TabContent

		local GroupLabel = Instance.new("TextLabel")
		GroupLabel.Name = "Label"
		GroupLabel.Text = "  " .. name
		GroupLabel.Font = Zyren.Theme.Font
		GroupLabel.TextSize = Zyren.Theme.TextSize
		GroupLabel.TextColor3 = Zyren.Theme.TextColor
		GroupLabel.TextXAlignment = Enum.TextXAlignment.Left
		GroupLabel.Size = UDim2.new(1, 0, 0, 25)
		GroupLabel.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
		GroupLabel.BorderSizePixel = 0
		GroupLabel.Parent = GroupFrame

		local Content = Instance.new("Frame")
		Content.Name = "Content"
		Content.Position = UDim2.new(0, 0, 0, 25)
		Content.Size = UDim2.new(1, 0, 1, -25)
		Content.BackgroundTransparency = 1
		Content.Parent = GroupFrame

		local Layout = Instance.new("UIListLayout")
		Layout.Padding = UDim.new(0, 5)
		Layout.Parent = Content
		Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			GroupFrame.Size = UDim2.new(1, 0, 0, Layout.AbsoluteContentSize.Y + 30)
		end)

		Group.Frame = GroupFrame
		Group.Content = Content

        --[[
            Adds a toggle switch to this group
            @param config: table - Configuration options:
                - Text: string - Display text
                - Default: boolean - Initial state
                - Callback: function - Called when value changes
            Returns: Toggle object
        ]]
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
			ToggleLabel.Font = Zyren.Theme.Font
			ToggleLabel.TextSize = Zyren.Theme.TextSize
			ToggleLabel.TextColor3 = Zyren.Theme.TextColor
			ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
			ToggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
			ToggleLabel.BackgroundTransparency = 1
			ToggleLabel.Parent = ToggleFrame

			local ToggleButton = Instance.new("TextButton")
			ToggleButton.Name = "Toggle"
			ToggleButton.Size = UDim2.new(0, 35, 0, 20)
			ToggleButton.Position = UDim2.new(1, -35, 0.5, -10)
			ToggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
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
					TweenService:Create(ToggleDot, TweenInfo.new(0.15), {
						Position = UDim2.new(1, -18, 0, 2),
						BackgroundColor3 = Zyren.Theme.Accent
					}):Play()
					TweenService:Create(ToggleButton, TweenInfo.new(0.15), {
						BackgroundColor3 = Color3.fromRGB(30, 60, 90)
					}):Play()
				else
					TweenService:Create(ToggleDot, TweenInfo.new(0.15), {
						Position = UDim2.new(0, 2, 0, 2),
						BackgroundColor3 = Color3.fromRGB(150, 150, 150)
					}):Play()
					TweenService:Create(ToggleButton, TweenInfo.new(0.15), {
						BackgroundColor3 = Color3.fromRGB(60, 60, 60)
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

        --[[
            Adds a slider control to this group
            @param config: table - Configuration options:
                - Text: string - Display text
                - Min: number - Minimum value
                - Max: number - Maximum value
                - Default: number - Starting value
                - Rounding: number - Decimal precision (0 = integers)
                - Callback: function - Called when value changes
            Returns: Slider object
        ]]
		function Group:AddSlider(config)
			local Slider = {
				Name = config.Text,
				Value = config.Default or config.Min,
				Min = config.Min or 0,
				Max = config.Max or 100,
				Rounding = config.Rounding or 0
			}

			local SliderFrame = Instance.new("Frame")
			SliderFrame.Name = config.Text
			SliderFrame.Size = UDim2.new(1, 0, 0, 40)
			SliderFrame.BackgroundTransparency = 1
			SliderFrame.Parent = Content

			local SliderLabel = Instance.new("TextLabel")
			SliderLabel.Name = "Label"
			SliderLabel.Text = config.Text
			SliderLabel.Font = Zyren.Theme.Font
			SliderLabel.TextSize = Zyren.Theme.TextSize
			SliderLabel.TextColor3 = Zyren.Theme.TextColor
			SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
			SliderLabel.Size = UDim2.new(1, 0, 0, 15)
			SliderLabel.BackgroundTransparency = 1
			SliderLabel.Parent = SliderFrame

			local SliderValue = Instance.new("TextLabel")
			SliderValue.Name = "Value"
			SliderValue.Text = tostring(Slider.Value)
			SliderValue.Font = Zyren.Theme.Font
			SliderValue.TextSize = Zyren.Theme.TextSize
			SliderValue.TextColor3 = Zyren.Theme.TextColor
			SliderValue.TextXAlignment = Enum.TextXAlignment.Right
			SliderValue.Size = UDim2.new(1, 0, 0, 15)
			SliderValue.BackgroundTransparency = 1
			SliderValue.Parent = SliderFrame

			local SliderTrack = Instance.new("Frame")
			SliderTrack.Name = "Track"
			SliderTrack.Size = UDim2.new(1, 0, 0, 4)
			SliderTrack.Position = UDim2.new(0, 0, 0, 25)
			SliderTrack.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
			SliderTrack.BorderSizePixel = 0
			SliderTrack.Parent = SliderFrame

			local SliderFill = Instance.new("Frame")
			SliderFill.Name = "Fill"
			SliderFill.Size = UDim2.new((Slider.Value - Slider.Min) / (Slider.Max - Slider.Min), 0, 1, 0)
			SliderFill.BackgroundColor3 = Zyren.Theme.Accent
			SliderFill.BorderSizePixel = 0
			SliderFill.Parent = SliderTrack

			local SliderHandle = Instance.new("TextButton")
			SliderHandle.Name = "Handle"
			SliderHandle.Size = UDim2.new(0, 15, 0, 15)
			SliderHandle.Position = UDim2.new(SliderFill.Size.X.Scale, -7, 0.5, -7)
			SliderHandle.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
			SliderHandle.AutoButtonColor = false
			SliderHandle.Text = ""
			SliderHandle.Parent = SliderTrack

			local function UpdateSlider(value)
				local rounded = Slider.Rounding > 0 and math.floor((value / Slider.Rounding) + 0.5) * Slider.Rounding or value
				Slider.Value = math.clamp(rounded, Slider.Min, Slider.Max)

				local scale = (Slider.Value - Slider.Min) / (Slider.Max - Slider.Min)
				SliderFill.Size = UDim2.new(scale, 0, 1, 0)
				SliderHandle.Position = UDim2.new(scale, -7, 0.5, -7)
				SliderValue.Text = tostring(Slider.Value)

				if config.Callback then
					config.Callback(Slider.Value)
				end
			end

			-- Slider interaction logic
			local dragging = false
			SliderHandle.MouseButton1Down:Connect(function()
				dragging = true
			end)

			UserInputService.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					dragging = false
				end
			end)

			UserInputService.InputChanged:Connect(function(input)
				if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
					local pos = SliderTrack.AbsolutePosition
					local size = SliderTrack.AbsoluteSize
					local relative = math.clamp((Mouse.X - pos.X) / size.X, 0, 1)
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

		table.insert(self.Groups, Group)
		return Group
	end

	return Tab
end



return Zyren
