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
Tunnel.bindInterface("dynamic",cRP)
vSERVER = Tunnel.getInterface("dynamic")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local menuOpen = false
local policeService = false
local paramedicService = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANIMAL
-----------------------------------------------------------------------------------------------------------------------------------------
local animalHahs = nil
local animalFollow = false
local animalName = ""
local emotePlaying = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:UPDATESERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("police:updateService")
AddEventHandler("police:updateService",function(status)
	policeService = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARAMEDIC:UPDATESERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("paramedic:updateService")
AddEventHandler("paramedic:updateService",function(status)
	paramedicService = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDBUTTON
-----------------------------------------------------------------------------------------------------------------------------------------
exports("AddButton",function(title,description,trigger,par,id,server)
	SetNuiFocus(true,true)
	SendNUIMessage({ addbutton = true, title = title, description = description, trigger = trigger, par = par, id = id, server = server })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SUBMENU
-----------------------------------------------------------------------------------------------------------------------------------------
exports("SubMenu",function(title,description,menuid)
	SetNuiFocus(true,true)
	SendNUIMessage({ addmenu = true, title = title, description = description, menuid = menuid })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLICKED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("clicked",function(data,cb)
	if data["server"] == "true" then
		TriggerServerEvent(data["trigger"],data["param"])
	else
		TriggerEvent(data["trigger"],data["param"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("close",function(data,cb)
	SetNuiFocus(false,false)
	menuOpen = false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSESYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("dynamic:closeSystem")
AddEventHandler("dynamic:closeSystem",function()
	if menuOpen then
		SendNUIMessage({ close = true })
		SetNuiFocus(false,false)
		menuOpen = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GLOBALFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("globalFunctions",function(source,args)
	if not exports["player"]:blockCommands() and not exports["player"]:handCuff() and not menuOpen then
		local ped = PlayerPedId()
		if GetEntityHealth(ped) > 101 then
			menuOpen = true

			exports["dynamic"]:AddButton("Remover","Remover a roupa atual.","player:outfitFunctions","remover","outfit",true)
            exports["dynamic"]:AddButton("Salvar","Salvar a roupa atual.","player:outfitPlayerSave","","outfit",true)
            exports["dynamic"]:AddButton("Aplicar","Aplicar a roupa salva.","player:outfitPlayerApply","","outfit",true)   

			if animalHahs ~= nil then
				exports["dynamic"]:AddButton("Seguir","Seguir o proprietário.","dynamic:animalFunctions","seguir","animal",false)
				exports["dynamic"]:AddButton("Colocar no Veículo","Colocar o animal no veículo.","dynamic:animalFunctions","colocar","animal",false)
				exports["dynamic"]:AddButton("Remover do Veículo","Remover o animal no veículo.","dynamic:animalFunctions","remover","animal",false)
				exports["dynamic"]:AddButton("Enterrar","Remover animal kkkk.","dynamic:animalFunctions","deletar","animal",false)
				exports["dynamic"]:AddButton("Guardar","Guardar animal.","dynamic:animalFunctions","guardar","animal",false)
				exports["dynamic"]:AddButton("Brincar","Brincar com o animal.","dynamic:animalFunctions","brincar","animal",false)
			end

			if animalHahs ~= nil then
				exports["dynamic"]:AddButton("Deitar","Mandar o cachorro deitar.","dynamic:animalAnimations","1","animations",false)
				exports["dynamic"]:AddButton("Latir","Mandar o cachorro latir.","dynamic:animalAnimations","2","animations",false)
				exports["dynamic"]:AddButton("Sentar","Mandar o cachorro sentar.","dynamic:animalAnimations","3","animations",false)
				exports["dynamic"]:AddButton("Coçar","Sei lá doideira.","dynamic:animalAnimations","4","animations",false)
				exports["dynamic"]:AddButton("Bricar","Brincar com o cachorro.","dynamic:animalAnimations","5","animations",false)
				exports["dynamic"]:AddButton("Ataque","Mandar o cachorro atacar.","dynamic:animalAnimations","6","animations",false)
				exports["dynamic"]:AddButton("Pular","Mandar o cachorro pular.","dynamic:animalAnimations","7","animations",false)
				exports["dynamic"]:AddButton("Postura","Cachorro fica posturado.","dynamic:animalAnimations","8","animations",false)
			end

			exports["dynamic"]:AddButton("Informações","Todas as informações de sua identidade.","player:identityFunctions","","others",true)
			exports["dynamic"]:AddButton("Desmanche","Listagem dos veículos.","dismantle:invokeDismantle","","others",true)
			exports["dynamic"]:AddButton("Comercialização","Iniciar/Finalizar venda de drogas.","drugs:toggleService","","others",false)

			if not IsPedInAnyVehicle(ped) then
				exports["dynamic"]:AddButton("Rebocar","Colocar veículo na prancha do reboque.","towdriver:invokeTow","","others",false)

				exports["dynamic"]:AddButton("Colocar no Veículo","Colocar no veículo mais próximo.","dynamic:EnterTrunk","","otherPlayers",true)
				exports["dynamic"]:AddButton("Remover do Veículo","Remover do veículo mais próximo.","emergency:rv","rv","otherPlayers",true)
				exports["dynamic"]:AddButton("Checar Porta-Malas","Vericar pessoa dentro do mesmo.","player:CheckTrunk","","otherPlayers",true)

				exports["dynamic"]:SubMenu("Jogador","Pessoa mais próxima de você.","otherPlayers")
			else
				exports["dynamic"]:AddButton("Banco Dianteiro Esquerdo","Sentar no banco do motorista.","player:seatPlayer","0","vehicle",false)
				exports["dynamic"]:AddButton("Banco Dianteiro Direito","Sentar no banco do passageiro.","player:seatPlayer","1","vehicle",false)
				exports["dynamic"]:AddButton("Banco Traseiro Esquerdo","Sentar no banco do passageiro.","player:seatPlayer","2","vehicle",false)
				exports["dynamic"]:AddButton("Banco Traseiro Direito","Sentar no banco do passageiro.","player:seatPlayer","3","vehicle",false)
				exports["dynamic"]:AddButton("Levantar Vidros","Levantar todos os vidros.","player:winsFunctions","1","vehicle",true)
				exports["dynamic"]:AddButton("Abaixar Vidros","Abaixar todos os vidros.","player:winsFunctions","0","vehicle",true)

				exports["dynamic"]:SubMenu("Veículo","Funções do veículo.","vehicle")
			end

			exports["dynamic"]:AddButton("Propriedades","Ativa/Desativa as propriedades no mapa.","homes:togglePropertys","","propertys",false)

			exports["dynamic"]:SubMenu("Roupas","Mudança de roupas rápidas.","outfit")
			
			exports["dynamic"]:SubMenu("Propriedades","Todas as funções das propriedades.","propertys")

			exports["dynamic"]:SubMenu("Outros","Todas as funções do personagem.","others")

				if animalHahs ~= nil then
					exports["dynamic"]:SubMenu("Domésticos","Todas as funções dos animais domésticos.","animal")
				end
				if animalHahs ~= nil then
					exports["dynamic"]:SubMenu("Animações do Animal","Todas as animações dos animais.","animations")
				end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- EMERGENCYFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("emergencyFunctions",function(source,args)
	if policeService or paramedicService then
		if not exports["player"]:blockCommands() and not exports["player"]:handCuff() and not menuOpen then

			local ped = PlayerPedId()
			if GetEntityHealth(ped) > 101 then
				menuOpen = true

				exports["dynamic"]:AddButton("Serviço","Verificar companheiros em serviço.","emergency:servicoFunctions","","utilitys",true)

				if not IsPedInAnyVehicle(ped) then
					exports["dynamic"]:AddButton("Carregar pelos Braços","Carregar a pessoa mais próxima.","emergency:carryb","","player",true)
					exports["dynamic"]:AddButton("Carregar nos Ombros","Carregar a pessoa mais próxima.","emergency:carrya","","player",true)
					exports["dynamic"]:AddButton("Colocar no Veículo","Colocar no veículo mais próximo.","emergency:cv","4","player",true)
					exports["dynamic"]:AddButton("Remover do Veículo","Remover do veículo mais próximo.","emergency:rv","","player",true)

					exports["dynamic"]:SubMenu("Jogador","Pessoa mais próxima de você.","player")
				end

				if policeService then
					exports["dynamic"]:AddButton("Computador","Abrir o dispositivo móvel.","police:openSystem","","utilitys",false)
					exports["dynamic"]:AddButton("Barreira","Colocar barreira na frente.","police:insertBarrier","","utilitys",false)
					exports["dynamic"]:AddButton("Invadir","Invadir a residência.","homes:invadeSystem","","utilitys",true)

					exports["dynamic"]:AddButton("Remover Chapéu","Remover da pessoa mais próxima.","emergency:removeHat","","player",true)
					exports["dynamic"]:AddButton("Remover Máscara","Remover da pessoa mais próxima.","emergency:removeMask","","player",true)
					exports["dynamic"]:AddButton("Defusar","Desativar bomba do veículo.","races:defuseBomb","","player",true)

					exports["dynamic"]:AddButton("Sheriff","Fardamento de oficial.","emergency:presetFunctions","1","prePolice",true)
					exports["dynamic"]:AddButton("State Police","Fardamento de oficial.","emergency:presetFunctions","2","prePolice",true)
					exports["dynamic"]:AddButton("State Park","Fardamento de oficial.","emergency:presetFunctions","3","prePolice",true)
					exports["dynamic"]:AddButton("Los Santos Police","Fardamento de oficial.","emergency:presetFunctions","4","prePolice",true)
					exports["dynamic"]:AddButton("Los Santos Police","Fardamento de oficial.","emergency:presetFunctions","5","prePolice",true)

					exports["dynamic"]:SubMenu("Fardamentos","Todos os fardamentos policiais.","prePolice")
					exports["dynamic"]:SubMenu("Utilidades","Todas as funções dos policiais.","utilitys")
				elseif paramedicService then
					exports["dynamic"]:AddButton("Medical Center","Fardamento de doutor.","emergency:presetFunctions","6","preMedic",true)
					exports["dynamic"]:AddButton("Medical Center","Fardamento de paramédico.","emergency:presetFunctions","7","preMedic",true)
					exports["dynamic"]:AddButton("Medical Center","Fardamento de paramédico interno.","emergency:presetFunctions","8","preMedic",true)
					exports["dynamic"]:AddButton("Fire Departament","Fardamento de atendimentos.","emergency:presetFunctions","9","preMedic",true)
					exports["dynamic"]:AddButton("Fire Departament","Fardamento de mergulhador.","emergency:presetFunctions","10","preMedic",true)

					exports["dynamic"]:SubMenu("Fardamentos","Todos os fardamentos médicos.","preMedic")
					exports["dynamic"]:SubMenu("Utilidades","Todas as funções dos paramédicos.","utilitys")
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYMAPPING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("globalFunctions","Abrir menu principal.","keyboard","f1")
RegisterKeyMapping("emergencyFunctions","Abrir menu de emergência.","keyboard","f10")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PETS
-----------------------------------------------------------------------------------------------------------------------------------------
local pets = {
	["Cat"] = 1462895032,
	["Husky"] = 1318032802,
	["Pug"] = 1832265812,
	["Poodle"] = 1125994524,
	["Rottweiler"] = -1788665315,
	["Retriever"] = 882848737,
	["Shepherd"] = 1126154828,
	["Westy"] = -1384627013
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DYNAMIC:SPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("dynamic:spawn")
AddEventHandler("dynamic:spawn",function(names)
	local coords = GetEntityCoords(PlayerPedId())
	if animalHahs == nil then
		animalHahs = CreateAPed(pets[names],{x = coords.x, y = coords.y+1.05, z = coords.z, rot = GetEntityHeading(PlayerPedId())})
		animalName = names
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEAPED
-----------------------------------------------------------------------------------------------------------------------------------------
function CreateAPed(hash, pos)
	local handle = nil
	RequestModel(hash)
	while not HasModelLoaded(hash) do
		Citizen.Wait(1)
	end

	handle = CreatePed(5, hash, pos.x, pos.y, pos.z, rot, false, true)

	SetEntityInvincible(handle, true)
	SetBlockingOfNonTemporaryEvents(handle, true)
	SetPedFleeAttributes(handle, 0, 0)
	SetModelAsNoLongerNeeded(hash)
	return handle
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DYNAMIC:ANIMALFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("dynamic:animalFunctions")
AddEventHandler("dynamic:animalFunctions",function(functions)
    if animalHahs ~= nil then
        local ped = PlayerPedId()

        if functions == "seguir" then
            if not animalFollow then
                TaskFollowToOffsetOfEntity(animalHahs,ped,1.0,1.0,0.0,5.0,-1,2.5,1)
                SetPedKeepTask(animalHahs,true)
                animalFollow = true
            else
                SetPedKeepTask(animalHahs,false)
                ClearPedTasks(animalHahs)
                animalFollow = false
            end
        elseif functions == "colocar" then
            if IsPedInAnyVehicle(ped) and not IsPedOnAnyBike(ped) then
                local vehicle = GetVehiclePedIsUsing(ped)
                if IsVehicleSeatFree(vehicle,0) then
                    TaskEnterVehicle(animalHahs,vehicle,-1,0,2.0,16,0)
                end
            end
        elseif functions == "remover" then
            if IsPedInAnyVehicle(ped) and not IsPedOnAnyBike(ped) then
                TaskLeaveVehicle(animalHahs,GetVehiclePedIsUsing(ped),256)
                TriggerEvent("dynamic:animalFunctions","seguir")
            end
		elseif functions == "guardar" then
            DeletePed(animalHahs)
			animalHahs = nil
			animalFollow = false
			vSERVER.giveAnimal(animalName)
			animalName = ""
        elseif functions == "deletar" then
            DeletePed(animalHahs)
			animalHahs = nil
			animalFollow = false
		elseif functions == "brincar" then
            local pedCoords = GetEntityCoords(animalHahs)
            object = GetClosestObjectOfType(pedCoords, 190.0, GetHashKey('w_am_baseball'))

            if DoesEntityExist(object) then
                balle = true
                objCoords = GetEntityCoords(object)
                TaskGoToCoordAnyMeans(animalHahs, objCoords, 5.0, 0, 0, 786603, 0xbf800000)
                local GroupHandle = GetPlayerGroup(PlayerId())
                SetGroupSeparationRange(GroupHandle, 1.9)
                SetPedNeverLeavesGroup(animalHahs, false)
            else
                TriggerEvent("Notify","vermelho","No ball.",1500)
			end
        end
	end
end)

function cancelEmote()
	ClearPedTasksImmediately(animalHahs)
	emotePlaying = false
end

function playAnimation(dictionary, animation)
	if emotePlaying then
		cancelEmote()
	end
	RequestAnimDict(dictionary)
	while not HasAnimDictLoaded(dictionary) do
		Wait(1)
	end
	TaskPlayAnim(animalHahs, dictionary, animation, 8.0, 0.0, -1, 1, 0, 0, 0, 0)
	emotePlaying = true
end

RegisterNetEvent("dynamic:animalAnimations")
AddEventHandler("dynamic:animalAnimations",function(anims)
	if animalHahs ~= nil then
    	if anims == "1" then
          playAnimation("creatures@rottweiler@amb@sleep_in_kennel@","sleep_in_kennel")
	    elseif anims == "2" then
            playAnimation("creatures@rottweiler@amb@world_dog_barking@idle_a","idle_a")
		elseif anims == "3" then
			playAnimation("creatures@rottweiler@amb@world_dog_sitting@base","base")
		elseif anims == "4" then
			playAnimation("creatures@rottweiler@amb@world_dog_sitting@idle_a","idle_a")
		elseif anims == "5" then
			playAnimation("creatures@rottweiler@indication@","indicate_high")
		elseif anims == "6" then
			playAnimation("creatures@rottweiler@melee@","dog_takedown_from_back")
		elseif anims == "7" then
			playAnimation("creatures@rottweiler@melee@streamed_taunts@","taunt_02")
		elseif anims == "8" then
			playAnimation("creatures@rottweiler@swim@","swim")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETEPED
-----------------------------------------------------------------------------------------------------------------------------------------
function DeletePed(handle)
	if DoesEntityExist(handle) then
		SetEntityAsMissionEntity(handle, true, true)
		DeleteEntity(handle)
	end
	animalHahs = nil
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADINIT
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(30)

        if balle then
            local coords1 = GetEntityCoords(PlayerPedId())
            local coords2 = GetEntityCoords(animalHahs)
            local distance  = GetDistanceBetweenCoords(objCoords, coords2, true)
            local distance2 = GetDistanceBetweenCoords(coords1, coords2, true)

            if distance < 0.5 then
                local boneIndex = GetPedBoneIndex(animalHahs, 17188)
                AttachEntityToEntity(object, animalHahs, boneIndex, 0.120, 0.010, 0.010, 5.0, 150.0, 0.0, true, true, false, true, 1, true)
                TaskGoToCoordAnyMeans(animalHahs, coords1, 5.0, 0, 0, 786603, 0xbf800000)
                balle = false
                getball = true
            end
        end

        if getball then
            local coords1 = GetEntityCoords(PlayerPedId())
            local coords2 = GetEntityCoords(animalHahs)
            local distance2 = GetDistanceBetweenCoords(coords1, coords2, true)

            if distance2 < 1.5 then
                DetachEntity(object,false,false)
                Citizen.Wait(50)
                SetEntityAsMissionEntity(object)
                DeleteEntity(object)
                GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_BALL"), 1, false, true)
                local GroupHandle = GetPlayerGroup(PlayerId())
                SetGroupSeparationRange(GroupHandle, 999999.9)
                SetPedNeverLeavesGroup(animalHahs, true)
                SetPedAsGroupMember(animalHahs, GroupHandle)
                getball = false
            end
        end
    end
end)