Basic Usage
Creating UI Structure
lua
Copy
-- Create tabs
local MainTab = Zyren:CreateTab("Main")
local SettingsTab = Zyren:CreateTab("Settings")

-- Create group boxes (left/right columns)
local CombatGroup = MainTab:CreateGroup("Combat", "left")
local VisualGroup = MainTab:CreateGroup("Visuals", "right")
Adding Controls
Button:

```lua
CombatGroup:AddButton({
    Text = "Execute",
    Callback = function()
        print("Button pressed!")
        -- Your code here
    end
})
```
```lua
CombatGroup:AddToggle({
    Text = "Enable Aimbot",
    Default = false,
    Callback = function(value)
        print("Aimbot:", value)
        -- Your toggle logic
    end
})
```

```lua
CombatGroup:AddSlider({
    Text = "Aimbot FOV",
    Min = 1,
    Max = 360,
    Default = 90,
    Rounding = 1,  -- Decimal precision (0 for integers)
    Suffix = "°",
    Callback = function(value)
        print("FOV set to:", value)
        -- Your slider logic
    end
})
```
```lua
VisualGroup:AddColorPicker({
    Text = "ESP Color",
    Default = Color3.fromRGB(255, 0, 0),  -- Red
    Callback = function(color)
        print("Color changed to:", color)
        -- Your color change logic
    end
})
```
```lua
CombatGroup:AddDropdown({
    Text = "Weapon Selection",
    Default = "AK-47",
    Options = {"AK-47", "M4A1", "AWP", "Deagle"},
    Callback = function(value)
        print("Selected:", value)
        -- Your selection logic
    end
})
```

```lua
CombatGroup:AddKeybind({
    Text = "Aimbot Key",
    Default = Enum.KeyCode.E,
    Callback = function(key)
        print("Key pressed:", key)
        -- Your keybind logic
    end
})
```

```lua
SettingsTab:AddTextbox({
    Text = "Player Name",
    Default = "",
    Callback = function(text)
        print("Input:", text)
        -- Your text processing
    end
})
```
```lua
SettingsTab:AddLabel({
    Text = "Status: Ready",
    Color = Color3.fromRGB(0, 255, 0)  -- Optional
})
```
```lua
-- Change values programmatically
aimbotToggle:SetValue(true)  -- Turn on toggle
Custom Themes
lua
Copy
Zyren:SetTheme({
    Background = Color3.fromRGB(30, 30, 30),
    Accent = Color3.fromRGB(0, 200, 255),
    -- Add all theme properties...
})
```
