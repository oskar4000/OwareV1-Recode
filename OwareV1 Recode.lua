local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
loadstring(game:HttpGet("https://raw.githubusercontent.com/oskar4000/OwareV1-Recode/refs/heads/main/start", true))()
   }
})

Rayfield:LoadConfiguration()

local MainTab = Window:CreateTab("💢Main💢", nil)

loadstring(game:HttpGet("https://raw.githubusercontent.com/oskar4000/OwareV1-Recode/refs/heads/main/Aimbott", true))()

loadstring(game:HttpGet("https://raw.githubusercontent.com/oskar4000/OwareV1-Recode/refs/heads/main/ESP", true))()

loadstring(game:HttpGet("https://raw.githubusercontent.com/oskar4000/OwareV1-Recode/refs/heads/main/Misc", true))()
----------------------
-- MOVEMENT SECTION --
----------------------
local MoveTab = Window:CreateTab("🏃‍♀️‍➡️Movement🏃‍♀️‍➡️", nil)
local MovementSection = MoveTab:CreateSection("Movement Modifiers")

loadstring(game:HttpGet("https://raw.githubusercontent.com/oskar4000/OwareV1-Recode/refs/heads/main/Movement", true))()

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
