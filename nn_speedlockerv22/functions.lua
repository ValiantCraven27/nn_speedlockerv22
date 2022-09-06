Util = {}



Util.Notify = function(text, type, timeout, sfx)
  if sfx then
  TriggerServerEvent('InteractSound_SV:PlayOnSource', 'notify', Config.Volume)
  end
    exports.pNotify:SendNotification({ text = text, type = type, timeout = timeout, theme = Config.PNotifyTheme, layout = "centerLeft", queue = "left"
})
end

Util.FuelMsg = function(text, type, timeout)
  TriggerServerEvent('InteractSound_SV:PlayOnSource', 'chime', Config.Volume)
    exports.pNotify:SendNotification({ text = text, type = type, timeout = timeout, theme = Config.PNotifyTheme, layout = "centerLeft", queue = "left"
})
end

Util.ShowAlert = function(message, playNotificationSound)
  SetTextComponentFormat('STRING')
  AddTextComponentString(message)
  DisplayHelpTextFromStringLabel(0, 0, playNotificationSound, -1)
end

Util.DrawText3D = function(x, y, z, text)
  local onScreen,_x,_y=World3dToScreen2d(x, y, z)
  local px,py,pz=table.unpack(GetGameplayCamCoords())
  SetTextScale(0.5, 0.5)
  SetTextFont(4)
  SetTextProportional(1)
  SetTextColour(255, 255, 255, 215)
  SetTextEntry("STRING")
  SetTextCentre(1)
  AddTextComponentString(text)
  DrawText(_x,_y)
  local factor = (string.len(text)) / 370
  DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end