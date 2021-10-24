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
Tunnel.bindInterface("tablet",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE RACES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vRP/get_race","SELECT * FROM vrp_races WHERE raceid = @raceid")
vRP.prepare("vRP/update_race","UPDATE vrp_races SET vehicle = @vehicle WHERE user_id = @user_id and raceid = @raceid")
vRP.prepare("vRP/insert_race","INSERT INTO vrp_races(user_id,vehicle,raceid,points ) VALUES(@user_id,@vehicle,@raceid,@points)")
vRP.prepare("vRP/show_race","SELECT * FROM vrp_races WHERE raceid = @raceid ORDER BY points ASC LIMIT 13")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local motos = {}
local carros = {}
local aluguel = {}
local servicos = {}
local bichoSelect = "1"
local registerGames = {}

Citizen.CreateThread(function()
	local vehicles = vRP.vehicleGlobal()
	for k,v in pairs(vehicles) do
		if v[4] == "cars" then
			table.insert(carros,{ k = k, name = v[1], price = v[3], chest = parseInt(v[2]), tax = 1500 })
		elseif v[4] == "bikes" then
			table.insert(motos,{ k = k, name = v[1], price = v[3], chest = parseInt(v[2]), tax = 1500 })
		elseif v[4] == "donate" then
			table.insert(aluguel,{ k = k, name = v[1], price = v[3], chest = parseInt(v[2]), tax = 1500})
		elseif v[4] == "work" then
			table.insert(servicos,{ k = k, name = v[1], price = v[3], chest = parseInt(v[2]), tax = 500})
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookdealership = "https://discord.com/api/webhooks/836693968900194334/JnFu8ADlmUCqqcuJFDw1NVwgS_CLD5xBHBEviDF8FipzqNKIoNU77gtIKUoZpUvpCRmQ"
local webhookpaytax = ""

function creativelogs(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTRANKING
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestRanking(id)
    local query = vRP.query("vRP/show_race",{ raceid = id })
    local dados = {}
    for k,v in pairs(query) do
		local user_id = v.user_id
		local identity = vRP.getUserIdentity(user_id)
		local lastname = identity.name.." "..identity.name2
		local date = v.date
		local points = v.points

        table.insert(dados,{ k = k, vehicle = vRP.vehicleName(v.vehicle), raceid = id, lastname = lastname, date = date, points = points })
    end
    return dados
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CARROS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.Carros()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return carros
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOTOS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.Motos()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return motos
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ALUGUEL
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.Aluguel()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return aluguel
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICOS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.Servicos()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return servicos
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- POSSUIDOS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.Possuidos()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local vehList = {}
		local vehicles = vRP.query("vRP/get_vehicle",{ user_id = parseInt(user_id) })
		for k,v in pairs(vehicles) do
			table.insert(vehList,{ k = v.vehicle, work = v.work, name = vRP.vehicleName(v.vehicle), price = parseInt(vRP.vehiclePrice(v.vehicle)*0.7), chest = parseInt(vRP.vehicleChest(v.vehicle)) })
		end
		return vehList
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTABOUT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestAbout()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local inv = vRP.getInventory(user_id)
		if inv then
			local inventory = {}
			for k,v in pairs(inv) do
					inventory[k] = v
				end

			local identity = vRP.getUserIdentity(user_id)
			return inventory,vRP.computeInvWeight(user_id),vRP.getBackpack(user_id),{ identity.name.." "..identity.name2,parseInt(user_id),parseInt(identity.bank),parseInt(vRP.getGmsId(user_id)),identity.phone,identity.registration }
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BICHOS
-----------------------------------------------------------------------------------------------------------------------------------------
local bichoGames = {
    [1] = "Camelo",
    [2] = "Pavão",
    [3] = "Elefante",
    [4] = "Coelho",
    [5] = "Burro",
    [6] = "Gato",
    [7] = "Galo",
    [8] = "Trigre",
    [9] = "Rato"
}-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION LISTAR OU COMPRAR BICHO VALOR
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.beastGame(value,animal)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if bichoGames[parseInt(animal)] and parseInt(value) > 0 then
            if registerGames[animal] == nil then
                registerGames[animal] = {}
            end
            if registerGames[animal][tostring(user_id)] == nil then
                if vRP.paymentBank(user_id,parseInt(value)) then
                    registerGames[animal][tostring(user_id)] = parseInt(value)
                    TriggerClientEvent("Notify",source,"default","Aposta de $<b>"..vRP.format(value).."</b> no <b>"..bichoGames[parseInt(animal)].."</b>.",4000)
                else
                    TriggerClientEvent("Notify",source,"vermelho","Você está pobre, não aceitamos individados!",7000)
                end
            else
                TriggerClientEvent("Notify",source,"vermelho","Ja existe uma aposta no <b>"..bichoGames[parseInt(animal)].."</b>.",7000)
            end
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread( function()
    while true do
        Wait(30*60000) -- A cada 30 minutos vai dar o resultado do jogo do bixo!
        local winners = 0
        bichoSelect = math.random(#bichoGames)
        local premio = 0 

        if registerGames[bichoSelect] then
            for k,v in pairs(registerGames[bichoSelect]) do
                winners = winners + 1
                valor = parseInt(v * 2)
                --vRP.giveInventoryItem(parseInt(k),"dollars",valor,true) -- Caso queira que de o dinheiro no inv
                vRP.addBank(parseInt(k),valor) -- Caso queira que o valor vá para o banco
                TriggerClientEvent("Notify",parseInt(k),"dinheiro","Recebeu $<b>"..vRP.format(parseInt(v * 2)).."</b> do jogo do <b>Bicho</b>.",7000)
                premio = premio + valor
            end
        end

        if winners then -- Caso queira que a mensagem só seja enviada caso tenha um ganhador, basta colocar: if winners > 0 then
            TriggerClientEvent("Notify",-1,"bixo","<b>Resultado do Jogo do Bixo:</b><br><br> Resultado: <b>"..bichoGames[parseInt(bichoSelect)].."</b><br>Ganhadores: <b>"..winners.."</b><br>Valor total: <b>"..premio.."</b>",11000)
        end

        for i = 1, parseInt(#bichoGames) do
            registerGames[tostring(i)] = {}
        end
        
        registerGames[bichoSelect] = nil
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUYDEALER
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.buyDealer(name)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		local vehName = tostring(name)
		local vehPlate = vRP.vehList(source,11)
		local maxVehs = vRP.query("vRP/con_maxvehs",{ user_id = parseInt(user_id) })
		local myGarages = vRP.getInformation(user_id)
		local plateId = vRP.getVehiclePlate(vehPlate)

		local getInvoice = vRP.getInvoice(user_id)
		if getInvoice[1] ~= nil then
			TriggerClientEvent("Notify",source,"vermelho","Encontramos faturas pendentes.",3000)
			return
		end

		if vRP.getPremium(user_id) then
			if parseInt(maxVehs[1].qtd) >= parseInt(myGarages[1].garage) then
				TriggerClientEvent("Notify",source,"amarelo","Você atingiu o máximo de veículos em sua garagem.",3000)
				return
			end
		elseif vRP.vehicleType(name) ~= "work" then
			if parseInt(maxVehs[1].qtd) >= parseInt(myGarages[1].garage) + 2 then
				TriggerClientEvent("Notify",source,"amarelo","Você atingiu o máximo de veículos em sua garagem.",3000)
				return
			end
		end

		local vehicle = vRP.query("vRP/get_vehicles",{ user_id = parseInt(user_id), vehicle = vehName })
		if vehicle[1] then
			TriggerClientEvent("Notify",source,"amarelo","Você já possui um <b>"..vRP.vehicleName(vehName).."</b>.",3000)
			return
		else
			if vRP.vehicleType(name) == "donate" then
				if vRP.remGmsId(user_id,parseInt(vRP.vehiclePrice(vehName))) then
					vRP.execute("vRP/add_vehicle",{ user_id = parseInt(user_id), vehicle = vehName, plate = vRP.generatePlateNumber(), phone = vRP.getPhone(user_id), work = tostring(false) })
					vRP.execute("vRP/set_rental_time",{ user_id = parseInt(user_id), vehicle = vehName, premiumtime = parseInt(os.time()+30*24*60*60) })	
					vRP.execute("vRP/set_arrest",{ user_id = parseInt(user_id), vehicle = name, arrest = 1, time = parseInt(os.time()) })
					TriggerClientEvent("Notify",source,"verde","A compra foi concluída com sucesso.",5000)
					creativelogs(webhookdealership,"```[NOME]: "..identity.name.." "..identity.name2.." \n[ID]: "..user_id.." \n[COMPROU]: "..vRP.vehicleName(name).." [POR]: $ "..vRP.format(parseInt(vRP.vehiclePrice(name)*0.75)).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				else
					TriggerClientEvent("Notify",source,"vermelho","Gemas insuficientes.",3000)
				end
			elseif vRP.vehicleType(name) == "work" then
				if vRP.paymentBank(user_id,parseInt(vRP.vehiclePrice(vehName))) then
					vRP.execute("vRP/add_vehicle",{ user_id = parseInt(user_id), vehicle = vehName, plate = vRP.generatePlateNumber(), phone = vRP.getPhone(user_id), work = tostring(true) })
					vRP.execute("vRP/set_arrest",{ user_id = parseInt(user_id), vehicle = name, arrest = 1, time = parseInt(os.time()) })
					TriggerClientEvent("Notify",source,"verde","A compra foi concluída com sucesso.",5000)
					creativelogs(webhookdealership,"```[NOME]: "..identity.name.." "..identity.name2.." \n[ID]: "..user_id.." \n[COMPROU]: "..vRP.vehicleName(name).." [POR]: $ "..vRP.format(parseInt(vRP.vehiclePrice(name)*0.75)).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				else
					TriggerClientEvent("Notify",source,"vermelho","Dinheiro insuficiente na sua conta bancária.",5000)
				end
			else
				if vRP.paymentBank(user_id,parseInt(vRP.vehiclePrice(vehName))) then
					vRP.execute("vRP/add_vehicle",{ user_id = parseInt(user_id), vehicle = vehName, plate = vRP.generatePlateNumber(), phone = vRP.getPhone(user_id), work = tostring(false) })
					vRP.execute("vRP/set_arrest",{ user_id = parseInt(user_id), vehicle = name, arrest = 1, time = parseInt(os.time()) })
					TriggerClientEvent("Notify",source,"verde","A compra foi concluída com sucesso.",5000)
					creativelogs(webhookdealership,"```[NOME]: "..identity.name.." "..identity.name2.." \n[ID]: "..user_id.." \n[COMPROU]: "..vRP.vehicleName(name).." [POR]: $ "..vRP.format(parseInt(vRP.vehiclePrice(name)*0.75)).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				else
					TriggerClientEvent("Notify",source,"vermelho","Dinheiro insuficiente na sua conta bancária.",5000)
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SELLDEALER
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.sellDealer(name)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		if vRP.vehicleType(name) == "donate" then
			TriggerClientEvent("Notify",source,"vermelho","Você não pode vender este veiculo.",7000)
		else
			if vRP.vehicleType(name) ~= nil then
				local vehName = tostring(name)
					vRP.execute("vRP/rem_srv_data",{ dkey = "custom:"..parseInt(user_id)..":"..vehName })
					vRP.execute("vRP/rem_srv_data",{ dkey = "chest:"..parseInt(user_id)..":"..vehName })
					vRP.execute("vRP/rem_vehicle",{ user_id = parseInt(user_id), vehicle = vehName })
					vRP.addBank(user_id,parseInt(vRP.vehiclePrice(name)*0.75))
					TriggerClientEvent("Notify",source,"verde","Venda concluida com sucesso.",7000)
					TriggerClientEvent("itensNotify",source,{ "RECEBEU","dollars",vRP.format(parseInt(vRP.vehiclePrice(name)*0.75)),"Dólares" })
					creativelogs(webhookdealership,"```[NOME]: "..identity.name.." "..identity.name2.." \n[ID]: "..user_id.." \n[VENDEU]: "..vRP.vehicleName(name).." [POR]: $ "..vRP.format(parseInt(vRP.vehiclePrice(name)*0.75)).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			else
				TriggerClientEvent("Notify",source,"vermelho","Você não pode vender este veiculo.",7000)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAX
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestTax(name,plate)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local vehPlate = vRP.vehList(source,11)
	local plateId = vRP.getVehiclePlate(vehPlate)

	if user_id and name then
		if vRP.vehicleType(name) == "donate" then
			if vRP.paymentBank(user_id,1500) then
				vRP.execute("vRP/set_arrest",{ user_id = parseInt(user_id), vehicle = name, arrest = 0, time = 0 })
				TriggerClientEvent("Notify",source,"verde","Você pagou as taxas do seguro do seu veículo",5000)
			else
				TriggerClientEvent("Notify",source,"vermelho","Você não possui dinheiro suficiente em sua conta bancária.",5000)
			end
		end
		if vRP.vehicleType(name) == "cars" then
			if vRP.paymentBank(user_id,1500) then
				vRP.execute("vRP/set_arrest",{ user_id = parseInt(user_id), vehicle = name, arrest = 0, time = 0 })
				TriggerClientEvent("Notify",source,"verde","Você pagou as taxas do seguro do seu veículo",5000)
				creativelogs(webhookpaytax,"```[NOME]: "..identity.name.." "..identity.name2.." \n[ID]: "..user_id.." \n[VENDEU]: "..vRP.vehicleName(name).." [POR]: $ "..vRP.format(parseInt(vRP.vehiclePrice(name)*0.75)).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			else
				TriggerClientEvent("Notify",source,"vermelho","Você não possui dinheiro suficiente em sua conta bancária.",5000)
			end
		end
		if vRP.vehicleType(name) == "bikes" then
			if vRP.paymentBank(user_id,1500) then
				vRP.execute("vRP/set_arrest",{ user_id = parseInt(user_id), vehicle = name, arrest = 0, time = 0 })
				TriggerClientEvent("Notify",source,"verde","Você pagou as taxas do seguro do seu veículo",5000)
				creativelogs(webhookpaytax,"```[NOME]: "..identity.name.." "..identity.name2.." \n[ID]: "..user_id.." \n[VENDEU]: "..vRP.vehicleName(name).." [POR]: $ "..vRP.format(parseInt(vRP.vehiclePrice(name)*0.75)).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			else
				TriggerClientEvent("Notify",source,"vermelho","Você não possui dinheiro suficiente em sua conta bancária.",5000)
			end
		end
		if vRP.vehicleType(name) == "work" then
			if vRP.paymentBank(user_id,500) then
				vRP.execute("vRP/set_arrest",{ user_id = parseInt(user_id), vehicle = name, arrest = 0, time = 0 })
				TriggerClientEvent("Notify",source,"verde","Você pagou as taxas do seguro do seu veículo",5000)
				creativelogs(webhookpaytax,"```[NOME]: "..identity.name.." "..identity.name2.." \n[ID]: "..user_id.." \n[VENDEU]: "..vRP.vehicleName(name).." [POR]: $ "..vRP.format(parseInt(vRP.vehiclePrice(name)*0.75)).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			else
				TriggerClientEvent("Notify",source,"vermelho","Você não possui dinheiro suficiente em sua conta bancária.",5000)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTDRIVE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.startDrive(name)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.vehicleType(name) == "work" then
			TriggerClientEvent("Notify",source,"amarelo","Você não pode testar este veículo.",5000)
		else
			local paymentDrive = vRP.request(source,"Deseja iniciar um teste neste veículo por <b>$50</b> dólares?",15)
			if paymentDrive then
				if vRP.paymentBank(user_id,50) then
					TriggerClientEvent("Notify",source,"azul","Teste iniciado, para finalizar saia do veículo.",5000)
					SetPlayerRoutingBucket(source,math.random(1,500))
					return true
				else
					TriggerClientEvent("Notify",source,"vermelho","Você não possui dinheiro em sua conta bancária.")
					return false
				end
			end
			return false
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEDRIVE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.removeDrive()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		TriggerClientEvent("Notify",source,"azul","Você saiu do veículo e seu teste foi encerrado.",5000)
		SetPlayerRoutingBucket(source,0)
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKTABLET
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkTablet()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.getInventoryItemAmount(user_id,"coptablet") <= 1 then
            return true
        end
        return false
    end
end
