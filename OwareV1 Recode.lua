local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "👽OwareV1👽",
   LoadingTitle = "Made For FPS Combat",
   LoadingSubtitle = "by 0skar12345_86784 On Discord",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "ConfigSave",
      FileName = "OwareV1"
   },
   Discord = {
      Enabled = true,
      Invite = "n7uBZDpV",
      RememberJoins = true
   },
   KeySystem = true,
   KeySettings = {
      Title = "Key ! OwareV1",
      Subtitle = "Key System",
      Note = "Join our [Discord](https://discord.gg/n7uBZDpV) to get the key",
      FileName = "OwareV1Key",
      SaveKey = true,
      GrabKeyFromSite = true,
      Key = {"https://pastebin.com/raw/Sge1uUwm"}
   }
})

Rayfield:LoadConfiguration()

-- Load modules
local function LoadModule(name, url)
    local success, err = pcall(function()
        loadstring(game:HttpGet(url, true))(Rayfield, Window)
    end)
    if not success then
        warn("Failed to load "..name..": "..err)
        Rayfield:Notify({
            Title = "Load Error",
            Content = name.." failed to load",
            Duration = 6.5
        })
    end
end

LoadModule("Aimbot", "https://raw.githubusercontent.com/oskar4000/OwareV1-Recode/main/Aimbott")
LoadModule("ESP", "https://raw.githubusercontent.com/oskar4000/OwareV1-Recode/main/ESP")
LoadModule("Misc", "https://raw.githubusercontent.com/oskar4000/OwareV1-Recode/main/Misc")
LoadModule("Movement", "https://raw.githubusercontent.com/oskar4000/OwareV1-Recode/main/Movement")

Rayfield:Notify({
   Title = "👽OwareV1👽 Loaded",
   Content = "Key verified successfully!",
   Duration = 5,
   Image = nil,
   Actions = {
      Ignore = {
         Name = "Okay!",
         Callback = function() print("Script initialized") end
      },
   },
})
