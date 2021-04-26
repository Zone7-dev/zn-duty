ESX = nil

Citizen.CreateThread(function ()
    while ESX == nil do
      TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
       Citizen.Wait(0)
      PlayerData = ESX.GetPlayerData()
    end
end)


local PlayerData = {}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		for k, v in pairs(Config.Dutyonoff) do
			if ESX.PlayerData.job then
				if ESX.PlayerData.job.name == v["meslek"] then
					local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
					local dst = GetDistanceBetweenCoords(x, y, z, v["kordinat"].x, v["kordinat"].y, v["kordinat"].z, true)
                    local dst2 = GetDistanceBetweenCoords(x, y, z, v["kordinat"].x, v["kordinat"].y, v["kordinat"].z, true)
					if dst2 <= 2 then
						DrawText3Ds(v["kordinat"].x, v["kordinat"].y, v["kordinat"].z, "[E] Mesai Gir/Çık", 0.50)
                        if IsControlJustReleased(0, 38) then
                            TriggerServerEvent("zn-dutyonoff")
						end
					end
				end
			end
		end
	end
end)

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end