local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- First disable key system for testing
local Window = Rayfield:CreateWindow({
   Name = "👽OwareV1👽",
   LoadingTitle = "Loading...",
   LoadingSubtitle = "by developer",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "OwareConfigs",
      FileName = "OwareSettings"
   },
   KeySystem = false, -- Disabled for testing
   -- Remove key settings completely for now
})

-- Improved module loader with delays
local function LoadModule(name, url)
    print("Attempting to load:", name)
    local success, err = pcall(function()
        local module = loadstring(game:HttpGet(url, true))()
        if type(module) == "function" then
            module(Rayfield, Window)
            print(name, "loaded successfully")
            return true
        else
            error(name.." didn't return a function")
        end
    end)
    
    if not success then
        warn("FAILED TO LOAD "..name..": "..err)
        Rayfield:Notify({
            Title = "Load Error",
            Content = name.." failed to load: "..err,
            Duration = 6.5
        })
    end
    return success
end

-- Load modules with proper delays
task.spawn(function()
    -- Load Aimbot first
    if LoadModule("Aimbot", "https://raw.githubusercontent.com/oskar4000/OwareV1-Recode/main/Aimbott") then
        task.wait(1) -- Important delay
        
        -- Then load ESP
        if LoadModule("ESP", "https://raw.githubusercontent.com/oskar4000/OwareV1-Recode/main/ESP") then
            task.wait(1)
            
            -- Then load Misc
            if LoadModule("Misc", "https://raw.githubusercontent.com/oskar4000/OwareV1-Recode/main/Misc") then
                task.wait(1)
                
                -- Finally load Movement
                LoadModule("Movement", "https://raw.githubusercontent.com/oskar4000/OwareV1-Recode/main/Movement")
            end
        end
    end
end)

Rayfield:Notify({
   Title = "OwareV1 Initialized",
   Content = "UI is loading...",
   Duration = 5,
})
