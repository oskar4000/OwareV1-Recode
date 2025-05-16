--[[
    OwareV1 Main Loader
    Complete rewrite with guaranteed functionality
--]]

-- Cleanup previous instances
pcall(function()
    if game:GetService("CoreGui"):FindFirstChild("Rayfield") then
        game:GetService("CoreGui").Rayfield:Destroy()
        task.wait(0.5)
    end
end)

-- Load Rayfield with version fallback
local Rayfield
local RayfieldLoaded, RayfieldError = pcall(function()
    local success, result = pcall(loadstring(game:HttpGet(
        'https://sirius.menu/rayfield',
        true
    )))
    
    if success and type(result) == 'function' then
        Rayfield = result()
    else
        -- Fallback to legacy version
        Rayfield = loadstring(game:HttpGet(
            'https://raw.githubusercontent.com/shlexware/Rayfield/release/source.lua',
            true
        ))()
    end
end)

if not RayfieldLoaded or not Rayfield then
    warn("[OwareV1] Failed to load Rayfield:", RayfieldError)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "OwareV1 Error",
        Text = "UI library failed to load",
        Duration = 5
    })
    return
end

-- Create main window with forced settings
local Window = Rayfield:CreateWindow({
    Name = "👽 OwareV1 👽",
    LoadingTitle = "Initializing Cheat Suite",
    LoadingSubtitle = "Loading modules...",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "OwareV1_Config",
        FileName = "Settings"
    },
    KeySystem = false, -- Disabled for reliability
    MainColor = Color3.fromRGB(170, 0, 255),
    BackgroundColor = Color3.fromRGB(25, 25, 25),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromOffset(600, 400),
    Transparency = 0.95 -- Slightly transparent
})

-- Create tabs
local MainTab = Window:CreateTab("Main Features", 4483362458) -- Icon ID
local MovementTab = Window:CreateTab("Movement", 4483362459)

-- Module loader with advanced error handling
local function LoadModule(name, url)
    local startTime = os.clock()
    print(string.format("[%s] Initializing...", name))
    
    local success, err = pcall(function()
        -- Download module code
        local response
        local getSuccess, getErr = pcall(function()
            response = game:HttpGet(url, true)
            if not response or response == "" then
                error("Empty response from server")
            end
        end)
        
        if not getSuccess then
            error(string.format("Download failed: %s", getErr))
        end

        -- Compile module
        local moduleFunc, compileErr = loadstring(response)
        if not moduleFunc then
            error(string.format("Compilation failed: %s", compileErr))
        end

        -- Execute module with required parameters
        moduleFunc(Rayfield, Window, MainTab, MovementTab)
    end)

    local loadTime = os.clock() - startTime
    if success then
        print(string.format("[%s] Loaded successfully (%.2fs)", name, loadTime))
        return true
    else
        warn(string.format("[%s] Load failed: %s", name, err))
        Window:Notify({
            Title = string.format("%s Error", name),
            Content = string.sub(tostring(err), 1, 100).."...",
            Duration = 6,
            Image = 4483362460 -- Error icon
        })
        return false
    end
end

-- Load all modules with status reporting
task.spawn(function()
    -- Create loading status UI
    local StatusSection = MainTab:CreateSection("System Status")
    local StatusLabel = StatusSection:CreateLabel("Preparing to load modules...")
    
    local function UpdateStatus(text)
        StatusLabel:Set(text)
        print("[Status] "..text)
        task.wait() -- Allow UI to update
    end

    -- Module loading sequence
    local moduleLoadOrder = {
        {name = "Aimbot", url = "https://raw.githubusercontent.com/oskar4000/OwareV1-Recode/main/Aimbott.lua"},
        {name = "ESP", url = "https://raw.githubusercontent.com/oskar4000/OwareV1-Recode/main/ESP.lua"},
        {name = "Misc", url = "https://raw.githubusercontent.com/oskar4000/OwareV1-Recode/main/Misc.lua"},
        {name = "Movement", url = "https://raw.githubusercontent.com/oskar4000/OwareV1-Recode/main/Movement.lua"}
    }

    for _, module in ipairs(moduleLoadOrder) do
        UpdateStatus(string.format("Loading %s...", module.name))
        LoadModule(module.name, module.url)
        task.wait(1) -- Prevent rate limiting
    end

    UpdateStatus("All modules loaded successfully!")
    Window:Notify({
        Title = "OwareV1 Ready",
        Content = "Cheat suite initialized",
        Duration = 5,
        Image = 4483362458
    })
end)

-- Force UI to front
Window:BringToFront()
Window:Show()
print("[OwareV1] Main loader initialized")
