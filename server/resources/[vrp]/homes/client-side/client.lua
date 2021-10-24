-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("homes", cRP)
vSERVER = Tunnel.getInterface("homes")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local houseOpen = ""
local theftOpen = ""
local homesList = {}
local houseNetwork = {}
local internLocates = {}
local theftRobberys = {}
local blips = {}
local objectsLocker = nil
local objectsShells = nil
local fridge = false
local casas = false
local houseTimer = 0
local called = false
local attempt = false
local time = 0
local vasculhando = false
local intern = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("chestClose",function(data)
	vSERVER.chestClose()
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
	fridge = false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("takeItem",function(data)
	vSERVER.takeItem(tostring(houseOpen),data.item,data.slot,data.amount,fridge)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("storeItem",function(data)
	vSERVER.storeItem(tostring(houseOpen),data.item,data.slot,data.amount,fridge)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("populateSlot",function(data,cb)
	TriggerServerEvent("homes:populateSlot",data.item,data.slot,data.target,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSlot",function(data,cb)
	TriggerServerEvent("homes:updateSlot",data.item,data.slot,data.target,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("sumSlot",function(data,cb)
	TriggerServerEvent("homes:sumSlot",data.item,data.slot,data.amount,fridge)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOMES:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("homes:Update")
AddEventHandler("homes:Update",function(action)
	SendNUIMessage({ action = action })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTVAULT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestVault",function(data,cb)
	if fridge then
		local inventario,inventario2,peso,maxpeso,peso2,maxpeso2,infos = vSERVER.openChest2(tostring(houseOpen),fridge)
		if inventario then
			cb({ inventario = inventario, inventario2 = inventario2, peso = peso, maxpeso = maxpeso, peso2 = peso2, maxpeso2 = maxpeso2, infos = infos })
		end
	else
		local inventario,inventario2,peso,maxpeso,peso2,maxpeso2,infos = vSERVER.openChest(tostring(houseOpen),fridge)
		if inventario then
			cb({ inventario = inventario, inventario2 = inventario2, peso = peso, maxpeso = maxpeso, peso2 = peso2, maxpeso2 = maxpeso2, infos = infos })
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOUSETIMER
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    SetNuiFocus(false, false)
    while true do
        if houseTimer > 0 then
            houseTimer = houseTimer - 1
        end
        Citizen.Wait(1000)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRANCAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("trancar", function(source, args)
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)

    for k, v in pairs(homesList) do
        local distance = #(coords - vector3(v[6], v[7], v[8]))
        if distance <= 1.5 then
            vSERVER.tryUnlock(k)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYBIND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping('entrar','Entrar Casa','keyboard','e')
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("entrar", function(source, args)
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)

    for k, v in pairs(homesList) do
        local distance = #(coords - vector3(v[6], v[7], v[8]))
        if distance <= 1.5 and vSERVER.checkPermissions(k) then
            entranceHomes(k, v, false)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVADE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("invadir", function(source, args)
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)

    for k, v in pairs(homesList) do
        local distance = #(coords - vector3(v[6], v[7], v[8]))
        if distance <= 1.5 and vSERVER.checkPolice() then
            entranceHomes(k, v, false)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKHOMESTHEFT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkHomesTheft()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)

    for k, v in pairs(homesList) do
        local distance = #(coords - vector3(v[6], v[7], v[8]))
        if distance <= 1.5 and vSERVER.checkHomeTheft(k) then
            theftRobberys = {}
            return true,tostring(k)
        end
    end
    return false, nil
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTERHOMESTHEFT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.enterHomesTheft(homeName)
	entranceHomes(homeName, homesList[homeName], true)
	TriggerServerEvent("homes:ApplyTime",homeName)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTRANCEHOMES
-----------------------------------------------------------------------------------------------------------------------------------------
function entranceHomes(homeName, v, theft)
    DoScreenFadeOut(0)

    theftRobberys = {}
    houseOpen = homeName
    local ped = PlayerPedId()
    vSERVER.setNetwork(homeName)
    vSERVER.applyHouseOpen(homeName)
    TriggerEvent("homes:Hours", true)
    TriggerEvent("sound:source", "enterhouse", 0.7)

    if v[1] == "Middle" then
		createShells(ped,v[6],v[7],1500.0,"creative_middle")
		SetEntityCoords(ped,v[6] + 1.36,v[7] - 14.23,1499.5)
		table.insert(internLocates,{ v[6] + 1.36,v[7] - 14.23,1499.5,"exit","" })

		if not theft then
			table.insert(internLocates,{ v[5] + 7.15,v[7] - 1.00,1499.0,"vault","ABRIR" })
			table.insert(internLocates,{ v[5] - 0.54,v[7] - 2.46,1499.5,"fridge","ABRIR" })
		end
    elseif v[1] == "Mansion" then
		createShells(ped,v[6],v[7],1499.0,"creative_mansion")
		SetEntityCoords(ped,v[6] - 8.68,v[7] - 3.43,1500.5)
		table.insert(internLocates,{ v[6] - 8.68,v[7] - 3.43,1501.0,"exit","" })

		if not theft then
			table.insert(internLocates,{ v[6] - 3.97,v[7] - 13.58,1500.5,"vault","ABRIR" })
			table.insert(internLocates,{ v[6] + 5.81,v[7] - 11.88,1500.5,"fridge","ABRIR" })
		end
    elseif v[1] == "Trailer" then
		createShells(ped,v[6],v[7],1500.0,"creative_trailer")
		SetEntityCoords(ped,v[6] - 1.44,v[7] - 2.02,1499.5)
		table.insert(internLocates,{ v[6] - 1.44,v[7] - 2.02,1499.5,"exit","" })

		if not theft then
			table.insert(internLocates,{ v[6] - 4.36,v[7] - 1.97,1499.2,"vault","ABRIR" })
			table.insert(internLocates,{ v[6] + 0.20,v[7] + 1.70,1499.5,"fridge","ABRIR" })
		end
    elseif v[1] == "Beach" then
		createShells(ped,v[6],v[7],1500.0,"creative_beach")
		SetEntityCoords(ped,v[6] + 0.11,v[7] - 3.68,1499.5)
		table.insert(internLocates,{ v[6] + 0.11,v[7] - 3.68,1499.5,"exit","" })

		if not theft then
			table.insert(internLocates,{ v[6] + 8.36,v[7] - 3.60,1499.8,"vault","ABRIR" })
			table.insert(internLocates,{ v[6] - 1.47,v[7] - 0.96,1499.8,"fridge","ABRIR" })
		end
    elseif v[1] == "Motel" then
		createShells(ped,v[6],v[7],1500.0,"creative_motel")
		SetEntityCoords(ped,v[6] + 4.6,v[7] - 6.36,1498.3)
		table.insert(internLocates,{ v[6] + 4.6,v[7] - 6.36,1498.5,"exit","" })
		
		if not theft then
			table.insert(internLocates,{ v[6] + 5.08,v[7] + 2.05,1500.3,"vault","ABRIR" })
			table.insert(internLocates,{ v[6] + 4.89,v[7] + 3.40,1500.5,"fridge","ABRIR" })
		end
    elseif v[1] == "Modern" then
		createShells(ped,v[6],v[7],1500.0,"creative_modern")
		SetEntityCoords(ped,v[6] - 1.63,v[7] - 5.94,1499.5)
		table.insert(internLocates,{ v[6] - 1.63,v[7] - 5.94,1499.7,"exit","" })

		if not theft then
			table.insert(internLocates,{ v[6] - 0.59,v[7] + 2.95,1499.8,"vault","ABRIR" })
			table.insert(internLocates,{ v[6] + 2.15,v[7] + 7.27,1499.8,"fridge","ABRIR" })
		end
    elseif v[1] == "Hotel" then
		createShells(ped,v[6],v[7],1500.0,"creative_hotel")
		SetEntityCoords(ped,v[6] - 1.69,v[7] - 3.91,1499.6)
		table.insert(internLocates,{ v[6] - 1.69,v[7] - 3.91,1499.8,"exit","" })

		if not theft then
			table.insert(internLocates,{ v[6] - 2.25,v[7] + 0.95,1499.4,"vault","ABRIR" })
		end
    elseif v[1] == "Franklin" then
		createShells(ped,v[6],v[7],1500.0,"creative_franklin")
		SetEntityCoords(ped,v[6] - 0.47,v[7] - 5.91,1499.6)
		table.insert(internLocates,{ v[6] - 0.47,v[7] - 5.91,1499.6,"exit","" })

		if not theft then
			table.insert(internLocates,{ v[6] - 2.60,v[7] - 5.59,1499.3,"vault","ABRIR" })
			table.insert(internLocates,{ v[6] + 4.31,v[7] + 4.58,1499.8,"fridge","ABRIR" })
		end
	elseif v[1] == "Container" then
		createShells(ped,v[6],v[7],1499.0,"creative_container")
		SetEntityCoords(ped,v[6] - 1.14,v[7] - 1.38,1500.0,1,0,0,0)
		table.insert(internLocates,{ v[6] - 0.47,v[7] - 1.38,1500.5,"exit","" })
		
		if not theft then
			table.insert(internLocates["intern"],{ v[6] + 4.47,v[7] - 1.32,1500.5,"vault","ABRIR" })
		end
	end
	
    if theft then
        theftOpen = v[1]
		
		time = 0
		attempt = true
		intern = true
		
        if math.random(100) >= 75 then
			if DoesEntityExist(objectsLocker) then
				DeleteEntity(objectsLocker)
				objectsLocker = nil
			end
			
			local mHash = GetHashKey("prop_ld_int_safe_01")
			
			RequestModel(mHash)
			while not HasModelLoaded(mHash) do
				Citizen.Wait(1)
			end

			if interior == "Middle" then
				objectsLocker = CreateObjectNoOffset(mHash,v[5] + 4.52,v[6] - 1.13,1499.00,false,false,false)
				SetEntityHeading(objectsLocker,180.0)
			elseif interior == "Mansion" then
				objectsLocker = CreateObjectNoOffset(mHash,v[5] - 2.37,v[6] + 11.14,1499.20,false,false,false)
				SetEntityHeading(objectsLocker,90.0)
			elseif interior == "Trailer" then
				objectsLocker = CreateObjectNoOffset(mHash,v[5] + 3.49,v[6] - 2.00,1499.00,false,false,false)
				SetEntityHeading(objectsLocker,180.0)
			elseif interior == "Beach" then
				objectsLocker = CreateObjectNoOffset(mHash,v[5] + 8.76,v[6] + 0.49,1499.05,false,false,false)
				SetEntityHeading(objectsLocker,270.0)
			elseif interior == "Motel" then
				objectsLocker = CreateObjectNoOffset(mHash,v[5] - 5.10,v[6] + 2.78,1499.80,false,false,false)
				SetEntityHeading(objectsLocker,90.0)
			elseif interior == "Modern" then
				objectsLocker = CreateObjectNoOffset(mHash,v[5] + 4.64,v[6] + 6.27,1499.10,false,false,false)
				SetEntityHeading(objectsLocker,270.0)
			elseif interior == "Hotel" then
				objectsLocker = CreateObjectNoOffset(mHash,v[5] - 1.04,v[6] + 3.87,1499.10,false,false,false)
				SetEntityHeading(objectsLocker,0.0)
			elseif interior == "Franklin" then
				objectsLocker = CreateObjectNoOffset(mHash,v[5] + 1.19,v[6] + 3.43,1499.00,false,false,false)
				SetEntityHeading(objectsLocker,0.0)
			elseif interior == "Container" then
				objectsLocker = CreateObjectNoOffset(mHash,v[5] + 1.19,v[6] + 3.43,1499.00,false,false,false)
				SetEntityHeading(objectsLocker,0.0)
			end

			FreezeEntityPosition(objectsLocker,true)
			SetModelAsNoLongerNeeded(mHash)
		else
			theftRobberys["LOCKER"] = true
		end
    end
	
    FreezeEntityPosition(ped, true)
    Citizen.Wait(2000)
    FreezeEntityPosition(ped, false)
    DoScreenFadeIn(1000)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATESHELLS
-----------------------------------------------------------------------------------------------------------------------------------------
function createShells(ped, x, y, z, hash)
    if DoesEntityExist(objectsShells) then
        DeleteEntity(objectsShells)
        objectsShells = nil
    end
    objectsShells = CreateObjectNoOffset(GetHashKey(hash),x,y,z,false,false,false)
    FreezeEntityPosition(objectsShells,true)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THEFTCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
local theftCoords = {
	["Middle"] = {
		["MOBILE01"] = { 0.45,-2.87,-0.8 },
		["MOBILE02"] = { -4.26,-5.36,-0.3 },
		["MOBILE03"] = { -5.61,-5.21,-0.8 },
		["MOBILE04"] = { -7.57,2.04,-1.0 },
		["MOBILE05"] = { -3.91,2.08,-1.0 },
		["MOBILE06"] = { 0.77,2.96,0.1 },
		["MOBILE07"] = { 5.68,-1.13,-0.8 },
		["MOBILE08"] = { 7.15,-1.00,-1.0 },
		["MOBILE09"] = { 6.38,5.78,-0.3 },
		["MOBILE10"] = { 3.59,3.83,-0.9 },
		["MOBILE11"] = { 1.60,4.58,-0.7 },
		["MOBILE12"] = { -0.54,-2.46,-0.3 },
		["LOCKER"] = { 4.47,-1.00,-0.9 }
	},
	["Mansion"] = {
		["MOBILE01"] = { 0.93,-14.28,-0.2 },
		["MOBILE02"] = { -0.41,-18.88,-0.2 },
		["MOBILE03"] = { -5.93,-18.00,-0.1 },
		["MOBILE04"] = { -3.97,-13.54,0.5 },
		["MOBILE05"] = { 5.80,-11.88,0.5 },
		["MOBILE06"] = { 8.98,0.43,-0.5 },
		["MOBILE07"] = { 4.97,5.94,-0.1 },
		["MOBILE08"] = { -2.41,9.43,-0.6 },
		["MOBILE09"] = { 1.48,8.29,-0.5 },
		["MOBILE10"] = { 3.19,14.13,-0.9 },
		["MOBILE11"] = { -0.08,14.00,-0.9 },
		["MOBILE12"] = { -2.80,17.30,-0.7 },
		["LOCKER"] = { -2.37,11.14,-0.7 }
	},
	["Trailer"] = {
		["MOBILE01"] = { 5.57,-1.36,-0.7 },
		["MOBILE02"] = { 1.82,-1.79,-0.7 },
		["MOBILE03"] = { 0.22,1.70,-0.5 },
		["MOBILE04"] = { -6.10,-1.47,-0.3 },
		["MOBILE05"] = { -4.39,-1.97,-0.8 },
		["MOBILE06"] = { -3.25,-1.85,-0.2 },
		["LOCKER"] = { 3.49,-2.00,-1.0 }
	},
	["Beach"] = {
		["MOBILE01"] = { -0.62,-0.95,-0.6 },
		["MOBILE02"] = { 3.14,-3.75,-0.6 },
		["MOBILE03"] = { 8.36,-3.60,-0.1 },
		["MOBILE04"] = { 7.86,-0.49,-0.8 },
		["MOBILE05"] = { 6.47,0.34,-0.8 },
		["MOBILE06"] = { 7.80,3.72,-0.8 },
		["MOBILE07"] = { 3.63,3.00,-0.1 },
		["MOBILE08"] = { 0.78,2.10,-0.3 },
		["MOBILE09"] = { -1.07,2.79,-0.6 },
		["MOBILE10"] = { -8.31,3.55,-0.9 },
		["MOBILE11"] = { -5.39,-3.83,-0.2 },
		["MOBILE12"] = { -1.45,-2.98,-0.7 },
		["LOCKER"] = { 8.76,0.49,-0.8 }
	},
	["Simple"] = {
		["MOBILE01"] = { -5.74,-1.80,0.6 },
		["MOBILE02"] = { -5.49,2.60,0.8 },
		["MOBILE03"] = { -4.06,2.62,0.8 },
		["MOBILE04"] = { -3.30,2.63,1.2 },
		["MOBILE05"] = { 1.41,-2.15,1.2 },
		["MOBILE06"] = { 5.61,-3.89,0.5 },
		["MOBILE07"] = { 5.53,-0.58,0.5 },
		["MOBILE08"] = { 5.57,0.66,0.8 },
		["LOCKER"] = { 2.60,2.68,0.7 }
	},
	["Motel"] = {
		["MOBILE01"] = { 5.08,2.05,0.3 },
		["MOBILE02"] = { 4.89,3.40,0.6 },
		["MOBILE03"] = { 2.31,6.13,0.2 },
		["MOBILE04"] = { 1.05,6.16,0.0 },
		["MOBILE05"] = { -3.55,0.30,0.6 },
		["LOCKER"] = { -5.10,2.78,0.0 }
	},
	["Modern"] = {
		["MOBILE01"] = { -1.01,0.42,-0.6 },
		["MOBILE02"] = { 3.07,-2.66,-0.8 },
		["MOBILE03"] = { 2.14,7.27,-0.1 },
		["MOBILE04"] = { 1.02,7.27,-0.1 },
		["MOBILE05"] = { 0.05,7.27,-0.1 },
		["MOBILE06"] = { -1.98,7.26,-0.6 },
		["MOBILE07"] = { -3.46,4.33,-0.6 },
		["MOBILE08"] = { -0.56,4.34,-0.6 },
		["MOBILE09"] = { -0.59,2.92,-0.1 },
		["MOBILE10"] = { -0.59,1.53,-0.1 },
		["LOCKER"] = { 4.64,6.27,-0.8 }
	},
	["Hotel"] = {
		["MOBILE01"] = { 2.40,-1.78,-0.8 },
		["MOBILE02"] = { -1.78,2.59,-0.1 },
		["MOBILE03"] = { -2.24,0.95,-0.6 },
		["MOBILE04"] = { -2.26,-0.49,-0.7 },
		["LOCKER"] = { -1.04,3.87,-0.8 }
	},
	["Franklin"] = {
		["MOBILE01"] = { -1.81,-5.41,-0.7 },
		["MOBILE02"] = { -2.59,-5.59,-0.8 },
		["MOBILE03"] = { -5.45,-5.75,-1.0 },
		["MOBILE04"] = { -2.68,-0.50,-1.0 },
		["MOBILE05"] = { -3.74,3.31,-0.6 },
		["MOBILE06"] = { 2.01,7.33,-0.7 },
		["MOBILE07"] = { 4.40,5.50,-0.7 },
		["MOBILE08"] = { 4.31,4.59,-0.2 },
		["MOBILE09"] = { 5.15,-0.81,-0.8 },
		["MOBILE10"] = { 0.93,-0.25,-0.9 },
		["MOBILE11"] = { 4.81,-6.93,-0.8 },
		["LOCKER"] = { 1.19,3.43,-0.9 }
	},
	["Container"] = {
		["MOBILE01"] = { 1.45,-1.29,0.7 },
		["MOBILE02"] = { 4.46,-1.30,0.6 },
		["MOBILE03"] = { 4.62,0.72,0.1 },
		["MOBILE04"] = { 1.75,1.55,0.1 },
		["MOBILE05"] = { 0.59,1.44,0.7 },
		["MOBILE06"] = { -0.51,1.44,0.7 },
		["MOBILE07"] = { -1.63,1.55,0.1 },
		["MOBILE08"] = { -4.62,0.76,0.1 },
		["MOBILE09"] = { -4.44,-1.31,0.6 },
		["LOCKER"] = { 2.80,1.33,0.0 }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADROBBERYS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    SetNuiFocus(false)
    while true do
        local timeDistance = 500
        if theftOpen ~= "" and not vasculhando then
            local ped = PlayerPedId()
            if not IsPedInAnyVehicle(ped) then
                local coords = GetEntityCoords(ped)
				local speed = GetEntitySpeed(ped)

				if not called and IsPedRunning(ped) and IsPedJumping(ped) then
					vSERVER.callPolice(called)
					called = true
					attempt = false
				end

                for k, v in pairs(theftCoords[theftOpen]) do
                    if not theftRobberys[k] then
                        local distance = #(coords - vector3(homesList[houseOpen][6] + v[1], homesList[houseOpen][7] + v[2], 1500.0))
                        if distance <= 1.5 then
                            timeDistance = 1
                            DrawText3Ds(homesList[houseOpen][6] + v[1], homesList[houseOpen][7] + v[2], 1500.0, "~b~E~w~   VASCULHAR")

                            if IsControlJustPressed(1, 38) then
								if k == "LOCKER" then
									TriggerEvent("cancelando", true)
									local homeLocker = exports["safelocker"]:createSafe({ math.random(0,99),math.random(0,99) })
									if homeLocker then
										vSERVER.paymentTheft(k)
									end
									theftRobberys[k] = true
								else
									TriggerEvent("cancelando",true)

									local taskBar = exports["taskbar"]:taskRobbery()
									if taskBar then
										vSERVER.paymentTheft(k)
										theftRobberys[k] = true
									end
								end
								TriggerEvent("cancelando",false)
                            end
                        end
                    end
                end
            end
        end
        Citizen.Wait(timeDistance)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADINTERN
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	DoScreenFadeIn(1000)
    while true do
        local timeDistance = 500
        local ped = PlayerPedId()
        if not IsPedInAnyVehicle(ped) and houseOpen ~= "" then
            local coords = GetEntityCoords(ped)

            for k, v in pairs(internLocates) do
				if coords["z"] <= 1450 and v[4] == "exit" then
					SetEntityCoords(ped,v[1],v[2],v[3],1,0,0,0)
				end

                local distance = #(coords - vector3(v[1], v[2], v[3]))
                if distance <= 1.3 then
                    timeDistance = 1
                    -- DrawText3Ds(v[1], v[2], v[3], "~b~E~w~   " .. v[5])

                    if IsControlJustPressed(1, 38) then
                        if v[4] == "exit" then
                            if distance <= 0.9 then
                                DoScreenFadeOut(0)

                                SetEntityCoords(ped, homesList[houseOpen][6], homesList[houseOpen][7], homesList[houseOpen][8] - 0.4)

                                TriggerEvent("sound:source", "outhouse", 0.5)
                                TriggerEvent("homes:Hours", false)
                                vSERVER.removeNetwork(houseOpen)
                                vSERVER.removeHouseOpen()
                                internLocates = {}
                                houseOpen = ""
                                theftOpen = ""
								called = false
								attempt = false

                                if DoesEntityExist(objectsShells) then
                                    DeleteEntity(objectsShells)
                                    objectsShells = nil
                                end

                                if DoesEntityExist(objectsLocker) then
                                    DeleteEntity(objectsLocker)
                                    objectsLocker = nil
                                end

                                FreezeEntityPosition(ped, true)
                                Citizen.Wait(2000)
                                FreezeEntityPosition(ped, false)
                                DoScreenFadeIn(1000)
                            end
                        elseif v[4] == "vault" then
							local autorizado, user_id = vSERVER.checkIntPermissions(houseOpen)
							if autorizado and user_id then
								SetNuiFocus(true,true)
								SendNUIMessage({ action = "showMenu" })
								TriggerEvent("sound:source","chest",0.2)
							end
                        elseif v[4] == "fridge" then
							local autorizado, user_id = vSERVER.checkIntPermissions(houseOpen)
							if autorizado and user_id then
								SetNuiFocus(true,true)
								SendNUIMessage({ action = "showMenu" })
								TriggerEvent("sound:source","chest",0.2)
								fridge = true
							end
                        end
                    end
                end
            end
        end

        Citizen.Wait(timeDistance)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHOVERFY
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.updateHomes(status)
	local innerTable = {}

	for k,v in pairs(status) do
		table.insert(innerTable,{ v[6],v[7],v[8],1.25,"E","Porta de Acesso","Pressione para entrar" })
	end

	TriggerEvent("hoverfy:insertTable",innerTable)
	homesList = status
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADNETWORK
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        if houseOpen ~= "" then
            houseNetwork = vSERVER.getNetwork(houseOpen)

            for k, v in ipairs(GetActivePlayers()) do
                if PlayerId() ~= v and houseNetwork[GetPlayerServerId(v)] == nil then
                    NetworkFadeOutEntity(GetPlayerPed(v), true)
                end
            end
        end
        Citizen.Wait(1000)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETHOMESTATISTICS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.getHomeStatistics()
	return tostring(houseOpen)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CASAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("homes:togglePropertys")
AddEventHandler("homes:togglePropertys",function(source,args)
	casas = not casas
	
	if casas then
		TriggerEvent("Notify","amarelo","Marcações ativadas.",3000)
		
		for k,v in pairs(homesList) do
			blips[k] = AddBlipForCoord(v[6],v[7],v[8])
			SetBlipSprite(blips[k],411)
			SetBlipAsShortRange(blips[k],true)
			SetBlipColour(blips[k],2)
			SetBlipScale(blips[k],0.4)
		end
	else
		TriggerEvent("Notify","amarelo","Marcações desativadas.",3000)
		
		for k,v in pairs(blips) do
			if DoesBlipExist(v) then
				RemoveBlip(v)
			end
		end
		
		blips = {}
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHOTEL
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)
			local distance = #(coords - vector3(-772.69,312.77,85.7))

			if distance <= 1.5 then
				timeDistance = 1

				if IsControlJustPressed(1,38) and vSERVER.checkHotel() then
					vSERVER.initHotel()
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETBLIPSHOMES
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.setBlipsOwner(status)
	local blip = AddBlipForCoord(status.x,status.y,status.z)
	SetBlipSprite(blip,411)
	SetBlipAsShortRange(blip,true)
	SetBlipColour(blip,36)
	SetBlipScale(blip,0.4)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Residência: ~g~"..status.name)
	EndTextCommandSetBlipName(blip)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3Ds(x, y, z, text)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	SetTextFont(4)
	SetTextScale(0.35, 0.35)
	SetTextColour(255, 255, 255, 100)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x, _y)
	local factor = (string.len(text)) / 450
	DrawRect(_x, _y + 0.0125, 0.01 + factor, 0.03, 0, 0, 0, 100)
end