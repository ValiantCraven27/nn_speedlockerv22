ESX = nil
Citizen.CreateThread(function() while ESX == nil do TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) Citizen.Wait(0) end end)
SpeedMultiplier, IsInSpeedLock, IsInSuspensionMenu, getDriftMode = 2.236936, false, false, "OFF"

TriggerEvent('chat:addSuggestion', '/cam', 'Turn on/off or Lock Cinematic Cam', {
  { name="on or off", help ="on | off" }
})

RegisterCommand("cam", function(source, args)     
  camState = args[1]        
if camState == "on" then
  VehCamOff = false
end
if camState == "off" then
  VehCamOff = true
end               
end)

if Config.UseSpeedLock then
 Citizen.CreateThread(function()
  while true do
      Citizen.Wait(0)
          local ped = GetPlayerPed(-1)
          local vehicleId = GetVehiclePedIsIn(ped, false)
          local vehicleMPH = GetEntitySpeed(vehicleId)          
          local driverPed = GetPedInVehicleSeat(vehicleId,-1)
          
   if not IsPedInAnyBoat(ped) and not IsPedInAnyPlane(ped) and not IsPedInAnyHeli(ped) and not IsOnBike then 
     if IsControlJustPressed(0, Config.SpeedKey) and driverPed == ped then 
              Menu_SpeedLock()                      
              Citizen.Wait(1)             
      end
    end
  end
 end)
end

if Config.UseRideHeight then
 Citizen.CreateThread(function()
  while true do
        Citizen.Wait(0)
            local ped = GetPlayerPed(-1)
            local vehicleId = GetVehiclePedIsIn(ped, false)
            local vehicleMPH = GetEntitySpeed(vehicleId)
            local driverPed = GetPedInVehicleSeat(vehicleId,-1)
         
    if IsControlJustPressed(0,Config.RideKey) and driverPed == ped and not IsPedInAnyBoat(ped) and not IsPedInAnyPlane(ped) and not IsPedInAnyHeli(ped) and not IsPedOnAnyBike(ped) then
        Citizen.Wait(150)
     if IsControlJustPressed(0, Config.RideKey) and driverPed == ped and not IsPedInAnyBoat(ped) and not IsPedInAnyPlane(ped) and not IsPedInAnyHeli(ped) and not IsPedOnAnyBike(ped) then                
         Menu_RideHeight()                 
     end
    end 
  end  
 end)
end

Citizen.CreateThread(function() -- Settings Thread --
 while true do 
  Citizen.Wait(1)
    local ped = GetPlayerPed(-1)
    local vehicleId = GetVehiclePedIsIn(ped, false)
    local driverPed = GetPedInVehicleSeat(vehicleId, -1) 

   if Config.noAutoReloadOrSwap then
     SetWeaponsNoAutoreload(true)
     SetWeaponsNoAutoswap(true)    
   end

   if Config.disableVehicleCamForAll then
     DisableControlAction(0, 80, true) -- no cin cam or lock it in cin mode
   end  
   
   if driverPed == ped then
     if Config.noDriverWeapons then
        SetCurrentPedWeapon(ped,GetHashKey("WEAPON_UNARMED"),true)
        DisableControlAction(0, 37, true) -- Weapon wheel
        DisableControlAction(0, 106, true) -- Weapon wheel
        if IsDisabledControlJustPressed(2, 37) then
		     --SetCurrentPedWeapon(ped,GetHashKey("WEAPON_UNARMED"),true) 	
        end
        if IsDisabledControlJustPressed(0, 106) then 
		     SetCurrentPedWeapon(ped,GetHashKey("WEAPON_UNARMED"),true)
        end
     end      
     if VehCamOff then
        DisableControlAction(0, 80, true) -- no cin cam or lock it in cin mode
        SetFollowPedCamViewMode(1)
     end   
     if IsInSuspensionMenu then
        DisableControlAction(0, 74, true)  
        DisableControlAction(0, 82, true)  
        DisableControlAction(0, 83, true)
        DisableControlAction(0, 84, true)  
        DisableControlAction(0, 85, true)             
     end 
    end
 end
end)

function Menu_SpeedLock() -- Speedlock Menu
   local ped = GetPlayerPed(-1)
   local vehicleId = GetVehiclePedIsIn(ped, false)
   local vehicleMPH = GetEntitySpeed(vehicleId)

 if IsInSpeedLock == true then
   PlaySoundFrontend(-1, 'NAV', 'HUD_AMMO_SHOP_SOUNDSET', false)   
   Util.Notify(" 🚦 Speedometer Lock : Inactive ", "info", math.random(2000, 2000))
   SetEntityMaxSpeed(GetVehiclePedIsIn(ped, false), 299.9)              
   IsInSpeedLock = false  
 else
   PlaySoundFrontend(-1, 'NAV', 'HUD_AMMO_SHOP_SOUNDSET', false)
   Util.Notify(" 🚦 Speedometer Lock : "..Round(GetEntitySpeed(vehicleId) * SpeedMultiplier).." MPH", "warning", math.random(2000, 2000))  
   SetEntityMaxSpeed(GetVehiclePedIsIn(ped, false), vehicleMPH )     
   IsInSpeedLock = true  
 end 
Citizen.Wait(300)   
end
 
function Menu_RideHeight() -- Ride Height MENU
  IsInSuspensionMenu = true 
  local ped = GetPlayerPed(-1)
  local playerCoords    = GetEntityCoords(ped)
  local vehicleId = GetVehiclePedIsIn(ped, false) 
  local GetVehClass = GetVehicleClass(vehicleId)
  local vehicleSuspensionHeight = Round(GetVehicleSuspensionHeight(vehicleId) * 100)
  local vehicleWheelSize = Round(GetVehicleWheelSize(vehicleId) * 100)
  local vehicleWheelWidth = Round(GetVehicleWheelWidth(vehicleId) * 100)
  local vehicleBodyHealth = Round(GetVehicleBodyHealth(vehicleId) / 10)
  local vehicleEngineHealth = Round(GetVehicleEngineHealth(vehicleId) / 10)

  

  ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'smenu2',
      {
        title    = Config.MenuTitle,
        align    = 'right',
        elements = { 
                {label = '🚘 Engine: '..vehicleEngineHealth..'%'}, 
                {label = 'Drift Mode: '..getDriftMode..'',value = getDriftMode},             
                {label = 'Ride Height', type = 'slider', value = vehicleSuspensionHeight, min = -15, max = 10},
                {label = 'Wheel Width', type = 'slider', value = vehicleWheelWidth, min = 30, max = 100},
                {label = 'Wheel Size', type = 'slider', value = vehicleWheelSize, min = 50, max = 120},           
          },
      },
      function(data, menu)

        PlaySoundFrontend(-1, 'NAV', 'HUD_AMMO_SHOP_SOUNDSET', false) 
        
        if data.current.value == 'OFF' then        
           getDriftMode = "ON" 
           Citizen.Wait(100)         
           SetDriftTyresEnabled(vehicleId,true)       
           Util.Notify("🚘Drift Mode: "..getDriftMode.."", "gray", math.random(2000, 2000),true)
        end

        if data.current.value == 'ON' then          
           getDriftMode = "OFF"
           Citizen.Wait(100)
           SetDriftTyresEnabled(vehicleId,false)
           Util.Notify("🚘Drift Mode: "..getDriftMode.."", "gray", math.random(2000, 2000),true)            
        end
        
        if data.current.label == 'Ride Height' then
            SetVehicleSuspensionHeight(vehicleId, data.current.value / 100) 
            Util.Notify("🚘 "..data.current.label.." "..data.current.value.."", "gray", math.random(2000, 2000))  
        end
        
        if data.current.label == 'Wheel Width' then
          if vehicleWheelWidth > 0 then
            SetVehicleWheelWidth(vehicleId,data.current.value / 100)
            SetVehicleWheelTireColliderWidth(vehicleId,0,GetVehicleWheelWidth(vehicleId))  
            SetVehicleWheelTireColliderWidth(vehicleId,1,GetVehicleWheelWidth(vehicleId))  
            SetVehicleWheelTireColliderWidth(vehicleId,2,GetVehicleWheelWidth(vehicleId))  
            SetVehicleWheelTireColliderWidth(vehicleId,3,GetVehicleWheelWidth(vehicleId))
            SetVehicleWheelTireColliderWidth(vehicleId,4,GetVehicleWheelWidth(vehicleId))  
            SetVehicleWheelTireColliderWidth(vehicleId,5,GetVehicleWheelWidth(vehicleId)) 
            Util.Notify("🚘 "..data.current.label.." "..data.current.value.."", "gray", math.random(2000, 2000))  
            ResetVehicleWheels(vehicleId,true)
            SetVehicleOnGroundProperly(vehicleId)
          end  
        end
        
        if data.current.label == 'Wheel Size' then 
          local ColliderWheelSize = Config.ColliderModifier[GetVehClass]         
          if vehicleWheelSize > 0 then             
            SetVehicleWheelSize(vehicleId,data.current.value / 100)
            SetVehicleWheelTireColliderSize(vehicleId,0,GetVehicleWheelSize(vehicleId) / ColliderWheelSize)  -- Bigger Tires 1.77 next TODO: implement tire size system
            SetVehicleWheelTireColliderSize(vehicleId,1,GetVehicleWheelSize(vehicleId) / ColliderWheelSize)  
            SetVehicleWheelTireColliderSize(vehicleId,2,GetVehicleWheelSize(vehicleId) / ColliderWheelSize)  
            SetVehicleWheelTireColliderSize(vehicleId,3,GetVehicleWheelSize(vehicleId) / ColliderWheelSize) 
            SetVehicleWheelTireColliderSize(vehicleId,4,GetVehicleWheelSize(vehicleId) / ColliderWheelSize)  
            SetVehicleWheelTireColliderSize(vehicleId,5,GetVehicleWheelSize(vehicleId) / ColliderWheelSize) 
            Util.Notify("🚘 "..data.current.label.." "..data.current.value.."", "gray", math.random(2000, 2000))          
            ResetVehicleWheels(vehicleId,true)
            SetVehicleOnGroundProperly(vehicleId)
          end  
        end        
        IsInSuspensionMenu = false 
        menu.close()
      end,
      function(data, menu)
        IsInSuspensionMenu = false
        menu.close()
      end
    )
end

if Config.fuelWarning then
  Citizen.CreateThread(function() 
   while true do 
    Citizen.Wait(Config.fuelTimer)
       local ped = GetPlayerPed(-1)
       local vehicleId = GetVehiclePedIsIn(ped, false)
       local driverPed = GetPedInVehicleSeat(vehicleId, -1) 
       local IsInVehicle = IsPedInAnyVehicle(ped, false)
       local IsOnBike = IsPedOnAnyBike(ped)
  
       local fuelLevel =  GetVehicleFuelLevel(vehicleId)
       local roundFuel = Round(fuelLevel)    
   
       if fuelLevel < Config.fuelPercent and IsInVehicle and driverPed == ped and not IsOnBike then
           Util.FuelMsg("Low Fuel : ⛽ "..roundFuel.." %", "warning", math.random(3000, 3000))           
           if Config.Chime then
          
           end 
        end
    end
   end)
  end