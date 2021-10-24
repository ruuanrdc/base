-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("hospital",cRP)
vSERVER = Tunnel.getInterface("hospital")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local damaged = {}
local bleeding = 0
local dnaList = {}
local dnaGrids = {}
local lastResult = "Nenhum"
local dnaX,dnaY,dnaZ = 1116.59,-1535.84,34.88
local dnaDeltas = { vector2(-1,-1),vector2(-1,0),vector2(-1,1),vector2(0,-1),vector2(1,-1),vector2(1,0),vector2(1,1),vector2(0,1) }
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKIN
-----------------------------------------------------------------------------------------------------------------------------------------
local checkIn = {
	{ 1146.81,-1542.73,35.39,"Fiacre" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- BEDSIN
-----------------------------------------------------------------------------------------------------------------------------------------
local bedsIn = {
	["Fiacre"] = {
		{ 1136.13,-1585.39,36.29 },
		{ 1140.24,-1585.38,36.29 },
		{ 1144.46,-1585.38,36.29 },
		{ 1148.84,-1585.37,36.29 }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADCHECKIN
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)
			for _,v in pairs(checkIn) do
				local distance = #(coords - vector3(v[1],v[2],v[3]))
				if distance <= 2 then
					timeDistance = 4
					DrawText3D(v[1],v[2],v[3],"~g~E~w~  ATENDIMENTO")
					if distance <= 2 and IsControlJustPressed(1,38) and vSERVER.checkServices() then
						local checkBusy = 0
						local checkSelected = v[4]

						for _,v in pairs(bedsIn[checkSelected]) do
							checkBusy = checkBusy + 1

							local checkPos = nearestPlayer(v[1],v[2],v[3])
							if checkPos == nil then
								if vSERVER.paymentCheckin() then
									TriggerEvent("player:blockCommands",true)
									SetCurrentPedWeapon(ped,GetHashKey("WEAPON_UNARMED"),true)
									
									if GetEntityHealth(ped) <= 101 then
										vRP.revivePlayer(102)
									end

									DoScreenFadeOut(1000)
									Citizen.Wait(1000)

									SetEntityCoords(ped,v[1],v[2],v[3])

									Citizen.Wait(500)
									TriggerEvent("emotes","checkinskyz")

									Citizen.Wait(5000)
									DoScreenFadeIn(1000)
								end
								
								break
							end
						end

						if checkBusy >= #bedsIn[checkSelected] then
							TriggerEvent("Notify","amarelo","Todas as macas estão ocupadas, aguarde.",5000)
						end
					end
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NEARESTPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
function nearestPlayers(x2,y2,z2)
	local r = {}
	local players = vRP.getPlayers()
	for k,v in pairs(players) do
		local player = GetPlayerFromServerId(k)
		if player ~= PlayerId() and NetworkIsPlayerConnected(player) then
			local oped = GetPlayerPed(player)
			local coords = GetEntityCoords(oped)
			local distance = #(coords - vector3(x2,y2,z2))
			if distance <= 2 then
				r[GetPlayerServerId(player)] = distance
			end
		end
	end
	return r
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NEARESTPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
function nearestPlayer(x,y,z)
	local p = nil
	local players = nearestPlayers(x,y,z)
	local min = 2.0001
	for k,v in pairs(players) do
		if v < min then
			min = v
			p = k
		end
	end
	return p
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z,text)
	local onScreen,_x,_y = GetScreenCoordFromWorldCoord(x,y,z)

	if onScreen then
		BeginTextCommandDisplayText("STRING")
		AddTextComponentSubstringKeyboardDisplay(text)
		SetTextColour(255,255,255,150)
		SetTextScale(0.35,0.35)
		SetTextFont(4)
		SetTextCentre(1)
		EndTextCommandDisplayText(_x,_y)

		local width = string.len(text) / 160 * 0.45
		DrawRect(_x,_y + 0.0125,width,0.03,38,42,56,200)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRESSEDDIAGNOSTIC
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()

		if GetEntityHealth(ped) > 110 and not IsPedInAnyVehicle(ped) then
			if not damaged.vehicle and HasEntityBeenDamagedByAnyVehicle(ped) then
				ClearEntityLastDamageEntity(ped)
				damaged.vehicle = true
				bleeding = bleeding + 2
				TriggerServerEvent("dna:dropDna",80,190,40)
			end

			if HasEntityBeenDamagedByWeapon(ped,0,2) then
				ClearEntityLastDamageEntity(ped)
				damaged.bullet = true
				bleeding = bleeding + 1
				TriggerServerEvent("dna:dropDna",30,100,200)
			end

			if not damaged.taser and IsPedBeingStunned(ped) then
				ClearEntityLastDamageEntity(ped)
				damaged.taser = true
			end
		end

		local hit,bone = GetPedLastDamageBone(ped)
		if hit and not damaged[bone] and bone ~= 0 then
			damaged[bone] = true
		end

		Citizen.Wait(500)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRESSEDBLEEDING
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()

		if GetEntityHealth(ped) > 101 then
			if bleeding == 4 then
				SetEntityHealth(ped,GetEntityHealth(ped)-2)
			elseif bleeding == 5 then
				SetEntityHealth(ped,GetEntityHealth(ped)-3)
			elseif bleeding == 6 then
				SetEntityHealth(ped,GetEntityHealth(ped)-4)
			elseif bleeding >= 7 then
				SetEntityHealth(ped,GetEntityHealth(ped)-5)
			end

			if bleeding >= 4 then
				TriggerEvent("Notify","blood","Sangramento encontrado.",2000)
				TriggerServerEvent("dna:dropDna",255,0,0)
			end
		end

		Citizen.Wait(20000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESETDIAGNOSTIC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("resetDiagnostic")
AddEventHandler("resetDiagnostic",function()
	local ped = PlayerPedId()
	ClearPedBloodDamage(ped)

	damaged = {}
	bleeding = 0
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESETDIAGNOSTIC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("resetBleeding")
AddEventHandler("resetBleeding",function()
	bleeding = 0
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWINJURIES
-----------------------------------------------------------------------------------------------------------------------------------------
local exit = true
RegisterNetEvent("drawInjuries")
AddEventHandler("drawInjuries",function(ped,injuries)
	local function draw3dtext(x,y,z,text)
		local onScreen,_x,_y = World3dToScreen2d(x,y,z)
		SetTextFont(4)
		SetTextScale(0.35,0.35)
		SetTextColour(255,255,255,100)
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x,_y)
		local factor = (string.len(text))/300
		DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,100)
	end

	Citizen.CreateThread(function()
		local counter = 0
		exit = not exit

		while true do
			if counter > 1000 or exit then
				exit = true
				break
			end

			for k,v in pairs(injuries) do
				local x,y,z = table.unpack(GetPedBoneCoords(GetPlayerPed(GetPlayerFromServerId(ped)),k))
				draw3dtext(x,y,z,"~w~"..string.upper(v))
			end

			counter = counter + 1
			Citizen.Wait(0)
		end
	end)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETDIAGNOSTIC
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.getDiagnostic()
	return damaged,bleeding
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETBLEEDING
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.getBleeding()
	return bleeding
end

-- DNA

-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMUPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("dna:dnaUpdates")
AddEventHandler("dna:dnaUpdates",function(status)
	dnaList = status

	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)

	dnaGrids = {}
	for k,v in ipairs(dnaDeltas) do
		local h = coords.xy + (v * 20)
		dnaGrids[toChannel(vector2(gridChunk(h.x),gridChunk(h.y)))] = true
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETGRIDCHUNK
-----------------------------------------------------------------------------------------------------------------------------------------
function gridChunk(x)
	return math.floor((x + 8192) / 128)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOCHANNEL
-----------------------------------------------------------------------------------------------------------------------------------------
function toChannel(v)
	return (v.x << 8) | v.y
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADDNA
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) and (GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_FLASHLIGHT") and IsPlayerFreeAiming(PlayerId())) or (GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PETROLCAN") and IsPedShooting(ped)) then
			local coords = GetEntityCoords(ped)

			for grid,v in pairs(dnaGrids) do
				if dnaList[grid] then
					for k,v in pairs(dnaList[grid]) do
						local distance = #(coords - vector3(v[1],v[2],v[3]))
						if distance <= 4 then
							timeDistance = 4
							DrawText3D(v[1],v[2],v[3]+0.2,"~y~"..grid.."   ~w~"..k,500)
							DrawMarker(28,v[1],v[2],v[3]+0.05,0,0,0,180.0,0,0,0.04,0.04,0.04,v[4],v[5],v[6],100,0,0,0,0)
							if distance <= 1.2 and GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PETROLCAN") and IsPedShooting(ped) then
								TriggerServerEvent("dna:removeDna",grid,k)
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
-- LASTRESULT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("dna:lastResult")
AddEventHandler("dna:lastResult",function(status)
	lastResult = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADRESULT
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)
			local distance = #(coords - vector3(dnaX,dnaY,dnaZ))
			if distance <= 3 then
				timeDistance = 4
				DrawText3D(dnaX,dnaY,dnaZ,"~w~"..string.upper(lastResult),300)
			end
		end
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKDISTANCE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkDistance()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	local distance = #(coords - vector3(dnaX,dnaY,dnaZ))
	if distance <= 2 then
		return true
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKDISTANCE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.getPostions()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	local gridChunk = vector2(gridChunk(coords.x),gridChunk(coords.y))
	local _,cdz = GetGroundZFor_3dCoord(coords.x,coords.y,coords.z)

	return coords.x,coords.y,cdz,toChannel(gridChunk)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z,text,width)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,100)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text)) / width
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,125)
end