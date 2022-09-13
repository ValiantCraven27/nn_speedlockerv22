Config = {}

Config.MenuTitle = 'Native Nerdz v2.2'

Config.UseSpeedLock = true
Config.UseRideHeight = true
Config.SpeedKey = 68    --LB or Right Mouse Click | https://docs.fivem.net/docs/game-references/controls/ and Config.UseSpeedLock = true
Config.RideKey = 76 -- Double Tap RB or Spacebar quickly and Config.UseRideHeight = true
Config.noDriverWeapons = true   -- No driver drive bys
Config.noAutoReloadOrSwap = true -- No Weapon Auto-Reload or Auto-Swap on empty ammo
Config.disableVehicleCamForAll = false -- Disable Vehicle Cinema Cam
Config.fuelWarning = true  -- fuel level warning / Need pNotify and Fuel Script
Config.fuelPercent = 20 -- what level to warn you about fuel
Config.fuelTimer = 25000 -- Warning loop 25secs
Config.Volume = 0.3 -- Volume for Chime
Config.PNotifyTheme = "gta" -- You need to have pNotify

--[[ Themes: You can create more themes inside html/themes.css, use the gta theme as a template.
    gta
    mint
    relax
    metroui]]

Config.ColliderModifier = {
    [0]  = 2.1,   --Compacts  
    [1]  = 2.0,  --Sedans  
    [2]  = 2.0,  --SUVs  
    [3]  = 2.0,   --Coupes  
    [4]  = 2.0,   --Muscle  
    [5]  = 2.0,   --Sports Classics  
    [6]  = 2.0,   --Sports  
    [7]  = 2.0,   --Super  
    [8]  = 0,   --Motorcycles  
    [9]  = 1.89,  --Off-road  
    [10] = 1.80, --Industrial  
    [11] = 2.0,  --Utility  
    [12] = 2.0,  --Vans  
    [13] = 0,  --Cycles  
    [14] = 0,    --Boats  
    [15] = 0,  --Helicopters  
    [16] = 0,  --Planes  
    [17] = 2.0,  --Service  
    [18] = 2.0,  --Emergency  
    [19] = 2.0,  --Military  
    [20] = 1.90, --Commercial  
    [21] = 0,  --Trains
  }

