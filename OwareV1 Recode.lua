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

-- Load modules from GitHub
local Aimbot = loadstring(game:HttpGet("https://raw.githubusercontent.com/oskar4000/OwareV1-Recode/main/Aimbot.lua"))()
local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/oskar4000/OwareV1-Recode/main/ESP.lua"))()
local Misc = loadstring(game:HttpGet("https://raw.githubusercontent.com/oskar4000/OwareV1-Recode/main/Misc.lua"))()
local Movement = loadstring(game:HttpGet("https://raw.githubusercontent.com/oskar4000/OwareV1-Recode/main/Movement.lua"))()

-- Initialize modules with the Rayfield window
local MainTab = Window:CreateTab("💢Main💢", nil)
Aimbot.Init(MainTab)
ESP.Init(MainTab)
Misc.Init(MainTab)

local MoveTab = Window:CreateTab("🏃‍♀️‍➡️Movement🏃‍♀️‍➡️", nil)
Movement.Init(MoveTab)

-- Initial notification
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
