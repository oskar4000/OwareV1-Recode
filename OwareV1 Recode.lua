-- UI Library Loader with Advanced Fallback System
local function LoadUILibrary()
    local libraries = {
        {
            name = "Official Rayfield",
            url = "https://sirius.menu/rayfield",
            test = function(lib) return lib.CreateWindow ~= nil end
        },
        {
            name = "GitHub Rayfield",
            url = "https://raw.githubusercontent.com/shlexware/Rayfield/release/source.lua",
            test = function(lib) return lib.CreateWindow ~= nil end
        },
        {
            name = "Legacy Sirius",
            url = "https://raw.githubusercontent.com/sirius-uwu/sirius-uwu/main/sirius.lua",
            test = function(lib) return lib.CreateWindow ~= nil end
        }
    }

    for _, libInfo in ipairs(libraries) do
        local success, lib = pcall(function()
            local code = game:HttpGet(libInfo.url, true)
            return loadstring(code)()
        end)
        
        if success and libInfo.test(lib) then
            print("Successfully loaded:", libInfo.name)
            return lib
        else
            warn("Failed to load:", libInfo.name)
        end
    end
    return nil
end

-- Universal UI Element Creator
local function CreateUIElement(container, elementType, properties)
    -- Try modern methods first
    if elementType == "Label" and container.CreateLabel then
        return container:CreateLabel(properties)
    elseif elementType == "Label" and container.CreateParagraph then
        return container:CreateParagraph({Title = properties, Content = ""})
    elseif elementType == "Button" and container.CreateButton then
        return container:CreateButton(properties)
    elseif elementType == "Toggle" and container.CreateToggle then
        return container:CreateToggle(properties)
    elseif elementType == "Slider" and container.CreateSlider then
        return container:CreateSlider(properties)
    elseif elementType == "Section" and container.CreateSection then
        return container:CreateSection(properties)
    end
    
    -- Fallback to basic elements
    if elementType == "Button" then
        local btn = container:AddButton(properties)
        btn.Callback = properties.Callback or function() end
        return btn
    end
    
    warn("Failed to create", elementType, "element")
    return nil
end

-- Initialize UI
local Rayfield = LoadUILibrary()
if not Rayfield then
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "OwareV1 Error",
        Text = "Failed to load UI library",
        Duration = 5
    })
    return
end

-- Create window with compatibility
local Window = Rayfield:CreateWindow({
    Name = "👽 OwareV1 👽",
    LoadingTitle = "Loading Cheat Suite",
    LoadingSubtitle = "Initializing...",
    ConfigurationSaving = {Enabled = false},
    KeySystem = false
})

-- Create tabs using compatibility layer
local MainTab = CreateUIElement(Window, "Tab", "Main")
local MoveTab = CreateUIElement(Window, "Tab", "Movement")

-- Status system that works with all versions
local statusElement
if MainTab.CreateSection then
    local statusSection = CreateUIElement(MainTab, "Section", "System Status")
    statusElement = CreateUIElement(statusSection, "Label", "Initializing...")
else
    statusElement = { Set = function(self, text) print("Status:", text) end }
end

-- Enhanced module loader
local function LoadModule(name, url)
    statusElement:Set("Loading "..name.."...")
    
    local success, err = pcall(function()
        local code = game:HttpGet(url, true)
        if not code then error("Empty response") end
        
        local fn, compileErr = loadstring(code)
        if not fn then error(compileErr) end
        
        -- Execute module with compatibility layer
        local moduleEnv = {
            Rayfield = Rayfield,
            Window = Window,
            MainTab = MainTab,
            MoveTab = MoveTab,
            CreateUIElement = CreateUIElement
        }
        setfenv(fn, moduleEnv)
        
        return fn()
    end)
    
    if not success then
        statusElement:Set(name.." failed!")
        warn(name.." error:", err)
        return false
    end
    
    statusElement:Set(name.." loaded!")
    return true
end

-- Load all modules
local MODULES = {
    {"Aimbot", "https://raw.githubusercontent.com/oskar4000/OwareV1-Recode/main/Aimbot.lua"},
    {"ESP", "https://raw.githubusercontent.com/oskar4000/OwareV1-Recode/main/ESP.lua"},
    {"Misc", "https://raw.githubusercontent.com/oskar4000/OwareV1-Recode/main/Misc.lua"},
    {"Movement", "https://raw.githubusercontent.com/oskar4000/OwareV1-Recode/main/Movement.lua"}
}

for _, module in ipairs(MODULES) do
    LoadModule(module[1], module[2])
    task.wait(1) -- Rate limit
end

statusElement:Set("OwareV1 Ready!")
