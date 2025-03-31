# ZyrenLib
This documentation is for the stable release of ZyrenLib.

## Booting the Library
```lua
local Zyren = loadstring(game:HttpGet("https://raw.githubusercontent.com/SpxzyFire/ZyrenLib/refs/heads/main/Source.lua"))({
    WindowTitle = "Your Title",  -- Window title text
    ColorTheme = "Synapse"       -- Theme name (Synapse, Dark, Red, Ocean, Midnight, GrapeTheme)
})
```
## Creating a Tab
```lua
local Tab = Zyren:CreateTab("Main")

```
## Creating Groupboxes
```lua
local LeftGroupbox = Tab:CreateGroup("Combat", "left")  -- "left" or "right" column
local RightGroupbox = Tab:CreateGroup("Movement", "right")
```
You can add elements to sections the same way you would add them to a tab normally.

## Creating a Button
```lua
Tab:AddButton({
    Text = "Button",
    Callback = function()
        print("Button pressed!")
    end
})
```


## Creating Toggle
```lua
Tab:AddToggle({
    Text = "Toggle",
    Default = false,
    Callback = function(value)
        print("Aimbot:", value)
    end
})
```

## Creating a Color Picker
```lua
Tab:AddColorPicker(config)
    local ColorPicker = {
        Name = "Color Picker",
        Value = (255, 255, 255),
        Callback = config.Callback
    }
    
    -- Implementation would go here
    -- Returns color picker object
end
```

## Creating a Slider
```lua
CombatGroup:AddSlider({
    Text = "Slider",
    Min = 1,
    Max = 360,
    Default = 90,
    Rounding = 1,
    Suffix = "°",  -- Optional suffix
    Callback = function(value)
        print(value)
    end
})
```

## Creating a Dropdown menu
```lua
function Group:AddDropdown(config)
    local Dropdown = {
        Name = "",
        Value = "Default",
        Options = ("Default, Default 2"),
        Open = false
    }
    
    -- Implementation would go here
    -- Returns dropdown object
end
```
