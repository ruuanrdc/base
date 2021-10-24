-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("hospital",cRP)
vCLIENT = Tunnel.getInterface("hospital")
vSURVIVAL = Tunnel.getInterface("survival")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local dnaList = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKSERVICES
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkServices()
	local amountMedics = vRP.numPermission("Paramedic")
	if parseInt(#amountMedics) > 1 then
		TriggerClientEvent("Notify",source,"amarelo","Existem médicos em serviço.",3000)
		Wait(1000)
		return false
	end
	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTCHECKIN
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.paymentCheckin()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Police") or vRP.hasPermission(user_id,"Paramedic") or vRP.hasPermission(user_id,"Mechanic") then
			TriggerClientEvent("Notify",source,"verde","Seu tratamento ficou por conta da casa.",5000)
			return true
		end
		
		local value = 500
		if GetEntityHealth(GetPlayerPed(source)) <= 101 then
			value = value + 1000
		end
		
		if vRP.tryGetInventoryItem(user_id,"dollars",parseInt(value)) then
			TriggerClientEvent("Notify",source,"amarelo","Você pagou <b>$"..value.."</b> dólares pelo atendimento.",3000)
			return true
		else
			TriggerClientEvent("Notify",source,"vermelho","Você não tem <b>$"..value.."</b> dólares.",3000)
			Wait(1000)
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLEEDING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("hospital:sangramento")
AddEventHandler("hospital:sangramento",function()
	local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"Paramedic") then
        local nplayer = vRPclient.nearestPlayer(source,3)
        if nplayer then
            TriggerClientEvent("resetBleeding",nplayer)
            TriggerClientEvent("Notify",source,"verde","O sangramento parou.",5000)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TREAT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("hospital:tratamento")
AddEventHandler("hospital:tratamento",function()
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"Paramedic") then
		local nplayer = vRPclient.nearestPlayer(source,5)
		if nplayer then
			if not vSURVIVAL.deadPlayer(nplayer) then
				vSURVIVAL._startCure(nplayer)
				TriggerClientEvent("resetBleeding",nplayer)
				TriggerClientEvent("resetDiagnostic",nplayer)
				TriggerClientEvent("Notify",source,"verde","O tratamento começou.",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REANIMAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("hospital:reanimar")
AddEventHandler("hospital:reanimar",function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Paramedic") or vRP.hasPermission(user_id,"Police") then
			local nplayer = vRPclient.nearestPlayer(source,2)
			if nplayer then
				if vSURVIVAL.deadPlayer(nplayer) then
					TriggerClientEvent("Progress",source,10000,"Revivendo...")
					TriggerClientEvent("cancelando",source,true)
					vRPclient._playAnim(source,false,{"mini@cpr@char_a@cpr_str","cpr_pumpchest"},true)
					SetTimeout(10000,function()
						vRPclient._removeObjects(source)
						vSURVIVAL._revivePlayer(nplayer,110)
						TriggerClientEvent("resetBleeding",nplayer)
						TriggerClientEvent("cancelando",source,false)
					end)
				end
			end
		end
	end
end)

-- DNA

-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPDNA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("dna:dropDna")
AddEventHandler("dna:dropDna",function(r,g,b)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local x,y,z,grid = vCLIENT.getPostions(source)
		if dnaList[grid] == nil then
			dnaList[grid] = {}
		end

		table.insert(dnaList[grid],{ x,y,z,r,g,b,user_id,1800 })

		TriggerClientEvent("dna:dnaUpdates",-1,dnaList)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEDNA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("dna:removeDna")
AddEventHandler("dna:removeDna",function(grid,tables)
	dnaList[grid][tables] = nil
	TriggerClientEvent("dna:dnaUpdates",-1,dnaList)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMER
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		for k,v in pairs(dnaList) do
			for y,w in pairs(v) do
				if w[8] > 0 then
					w[8] = w[8] - 10
					if w[8] <= 0 then
						dnaList[k][y] = nil
						TriggerClientEvent("dna:dnaUpdates",-1,dnaList)
					end
				end
			end
		end
		Citizen.Wait(10000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKDNA
-----------------------------------------------------------------------------------------------------------------------------------------
local resultTimers = 0
local dnaResult = "Nenhum"
RegisterCommand("dna",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vCLIENT.checkDistance(source) and resultTimers <= 0 and vRP.hasPermission(user_id,"Paramedic") then
			if vRP.tryGetInventoryItem(user_id,"gsrkit",1,true) then
				local grid = parseInt(args[1])
				local tables = parseInt(args[2])
				if dnaList[grid][tables] then
					resultTimers = 120
					local identity = vRP.getUserIdentity(parseInt(dnaList[grid][tables][7]))
					if identity then
						dnaResult = identity.name.." "..identity.name2
					else
						dnaResult = "Individuo Indigente"
					end
					TriggerClientEvent("dna:lastResult",-1,"teste em andamento")
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADRESULTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if resultTimers > 0 then
			resultTimers = resultTimers - 10
			if resultTimers <= 0 then
				if math.random(100) >= 50 then
					TriggerClientEvent("dna:lastResult",-1,dnaResult)
				else
					TriggerClientEvent("dna:lastResult",-1,"falhou")
				end
			end
		end
		Citizen.Wait(10000)
	end
end)