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
Tunnel.bindInterface("dynamic",cRP)
vPLAYER = Tunnel.getInterface("player")
vTASKBAR = Tunnel.getInterface("taskbar")
vSKINSHOP = Tunnel.getInterface("skinshop")
vHOMES = Tunnel.getInterface("homes")
-----------------------------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------------------------
-- PRESET
-----------------------------------------------------------------------------------------------------------------------------------------
local preset = {
	["Police"] = {
		["1"] = {
			["homem"] = {
				["hat"] = { item = 62, texture = 8, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 130, texture = 1, defaultItem = 0, defaultTexture = 0 },
				["vest"] = { item = 18, texture = 1, defaultItem = 0, defaultTexture = 0 },
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = -1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 25, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["t-shirt"] = { item = 132, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso2"] = { item = 316, texture = 5, defaultItem = 0, defaultTexture = 0 },
				["accessory"] = { item = 1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["arms"] = { item = 20, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["glass"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
			},
			["mulher"] = {
				["hat"] = { item = 62, texture = 8, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 136, texture = 1, defaultItem = 0, defaultTexture = 0 },
				["vest"] = { item = 20, texture = 1, defaultItem = 0, defaultTexture = 0 },
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = -1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 25, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["t-shirt"] = { item = 162, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso2"] = { item = 367, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["accessory"] = { item = 1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["arms"] = { item = 23, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["glass"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
			}
		},
		["2"] = {
			["homem"] = {
				["hat"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 130, texture = 1, defaultItem = 0, defaultTexture = 0 },
				["vest"] = { item = 18, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = -1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 25, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["t-shirt"] = { item = 132, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso2"] = { item = 318, texture = 5, defaultItem = 0, defaultTexture = 0 },
				["accessory"] = { item = 1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["arms"] = { item = 26, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["glass"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
			},
			["mulher"] = {
				["hat"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 136, texture = 1, defaultItem = 0, defaultTexture = 0 },
				["vest"] = { item = 20, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = -1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 25, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["t-shirt"] = { item = 162, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso2"] = { item = 329, texture = 2, defaultItem = 0, defaultTexture = 0 },
				["accessory"] = { item = 1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["arms"] = { item = 22, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["glass"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
			}
		},
		["3"] = {
			["homem"] = {
				["hat"] = { item = 142, texture = 6, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 130, texture = 1, defaultItem = 0, defaultTexture = 0 },
				["vest"] = { item = 18, texture = 2, defaultItem = 0, defaultTexture = 0 },
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = -1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 25, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["t-shirt"] = { item = 132, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso2"] = { item = 316, texture = 3, defaultItem = 0, defaultTexture = 0 },
				["accessory"] = { item = 1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["arms"] = { item = 20, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["glass"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
			},
			["mulher"] = {
				["hat"] = { item = 141, texture = 6, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 136, texture = 1, defaultItem = 0, defaultTexture = 0 },
				["vest"] = { item = 20, texture = 2, defaultItem = 0, defaultTexture = 0 },
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = -1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 25, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["t-shirt"] = { item = 162, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso2"] = { item = 367, texture = 4, defaultItem = 0, defaultTexture = 0 },
				["accessory"] = { item = 1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["arms"] = { item = 31, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["glass"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
			}
		},
		["4"] = {
			["homem"] = {
				["hat"] = { item = 142, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 130, texture = 1, defaultItem = 0, defaultTexture = 0 },
				["vest"] = { item = 18, texture = 3, defaultItem = 0, defaultTexture = 0 },
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = -1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 25, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["t-shirt"] = { item = 132, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso2"] = { item = 316, texture = 8, defaultItem = 0, defaultTexture = 0 },
				["accessory"] = { item = 1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["arms"] = { item = 20, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["glass"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
			},
			["mulher"] = {
				["hat"] = { item = 141, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 136, texture = 1, defaultItem = 0, defaultTexture = 0 },
				["vest"] = { item = 20, texture = 3, defaultItem = 0, defaultTexture = 0 },
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = -1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 25, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["t-shirt"] = { item = 162, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso2"] = { item = 367, texture = 3, defaultItem = 0, defaultTexture = 0 },
				["accessory"] = { item = 1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["arms"] = { item = 31, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["glass"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
			}
		},
		["5"] = {
			["homem"] = {
				["hat"] = { item = 143, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 130, texture = 1, defaultItem = 0, defaultTexture = 0 },
				["vest"] = { item = 18, texture = 4, defaultItem = 0, defaultTexture = 0 },
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = -1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 25, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["t-shirt"] = { item = 132, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso2"] = { item = 316, texture = 8, defaultItem = 0, defaultTexture = 0 },
				["accessory"] = { item = 1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["arms"] = { item = 20, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["glass"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
			},
			["mulher"] = {
				["hat"] = { item = 142, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 136, texture = 1, defaultItem = 0, defaultTexture = 0 },
				["vest"] = { item = 20, texture = 4, defaultItem = 0, defaultTexture = 0 },
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = -1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 25, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["t-shirt"] = { item = 162, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso2"] = { item = 367, texture = 3, defaultItem = 0, defaultTexture = 0 },
				["accessory"] = { item = 1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["arms"] = { item = 31, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["glass"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
			}
		}
	},
	["Prisao"] = {
		["1"] = {
			["homem"] = {
				["hat"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 5, texture = 7, defaultItem = 0, defaultTexture = 0 },
				["vest"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 7, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["t-shirt"] = { item = -1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso2"] = { item = 22, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["accessory"] = { item = 126, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["arms"] = { item = 15, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["glass"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
			},
			["mulher"] = {
				["hat"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 23, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["vest"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = 121, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 7, texture = 3, defaultItem = 1, defaultTexture = 0 },
				["t-shirt"] = { item = 101, texture = 1, defaultItem = 1, defaultTexture = 0 },
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso2"] = { item = 58, texture = 7, defaultItem = 0, defaultTexture = 0 },
				["accessory"] = { item = 96, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["arms"] = { item = 91, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["glass"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
			}
		}
	}
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- CARREGAR PELOS OMBROS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("emergency:carrya")
AddEventHandler("emergency:carrya",function()
    local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Police") or vRP.hasPermission(user_id,"Paramedic") then
			if vRPclient.getHealth(source) > 101 and not vPLAYER.getHandcuff(source) then
				local nplayer = vRPclient.nearestPlayer(source,2)
				if nplayer then
					TriggerClientEvent("rope:toggleRope",source,nplayer)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CARREGAR PELOS BRAÇOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("emergency:carryb")
AddEventHandler("emergency:carryb",function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Police") or vRP.hasPermission(user_id,"Paramedic") then
			if vRPclient.getHealth(source) > 101 and not vPLAYER.getHandcuff(source) then
				local nplayer = vRPclient.nearestPlayer(source,2)
				if nplayer then
					vPLAYER.toggleCarry(nplayer,source)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("emergency:rv")
AddEventHandler("emergency:rv",function()
    local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Police") or vRP.hasPermission(user_id,"Paramedic") or vRP.getInventoryItemAmount(user_id,"rope") >= 1 then
			if vRPclient.getHealth(source) > 101 and not vPLAYER.getHandcuff(source) and not vRPclient.inVehicle(source) then
				local vehicle,vehNet,vehPlate,vehName,vehLock = vRPclient.vehList(source,11)
				if vehicle then
					if vehLock ~= 1 then
						local nplayer = vRPclient.nearestPlayer(source,11)
						if nplayer then
							vPLAYER.removeVehicle(nplayer)
						end
					end
				end
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("emergency:cv")
AddEventHandler("emergency:cv",function(number)
    local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Police") or vRP.hasPermission(user_id,"Paramedic") or vRP.getInventoryItemAmount(user_id,"rope") >= 1 then
			if vRPclient.getHealth(source) > 101 and not vPLAYER.getHandcuff(source) and not vRPclient.inVehicle(source) then
				local vehicle,vehNet,vehPlate,vehName,vehLock = vRPclient.vehList(source,11)
				if vehicle then
					if vehLock ~= 1 then
						local nplayer = vRPclient.nearestPlayer(source,2)
						if nplayer then
							vPLAYER.putVehicle(nplayer,number)
						end
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVER CHAPEU
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("emergency:removeHat")
AddEventHandler("emergency:removeHat",function()
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.wantedReturn(user_id) and not vRP.reposeReturn(user_id) then
		return
	end
		local nplayer = vRPclient.nearestPlayer(source,2)
		if nplayer then
			TriggerClientEvent('player:removeHat',nplayer)
		end
	end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVER MASCARA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("emergency:removeMask")
AddEventHandler("emergency:removeMask",function()
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.wantedReturn(user_id) and not vRP.reposeReturn(user_id) then
		return
	end
		local nplayer = vRPclient.nearestPlayer(source,2)
		if nplayer then
			TriggerClientEvent('player:removeMask',nplayer)
		end
	end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVIÇO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("emergency:servicoFunctions")
AddEventHandler("emergency:servicoFunctions",function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if not vRP.wantedReturn(user_id) and not vRP.reposeReturn(user_id) then
        local onDuty = ""
        local service = {}
    
            if vRP.hasPermission(user_id,"Police") then
                service = vRP.numPermission("Police")
            elseif vRP.hasPermission(user_id,"Paramedic") then
                service = vRP.numPermission("Paramedic")
            elseif vRP.hasPermission(user_id,"Mechanic") then
                service = vRP.numPermission("Mechanic")
            end    
			
            for k,v in pairs(service) do
                local nuser_id = vRP.getUserId(v)
                local identity = vRP.getUserIdentity(nuser_id)
    
                onDuty = onDuty.."<b>Passaporte:</b> "..vRP.format(parseInt(nuser_id)).."   -   <b>Nome:</b> "..identity.name.." "..identity.name2.."<br>"
            end

    
            TriggerClientEvent("Notify",source,"amarelo",onDuty,30000)
        end
	end
end)

RegisterServerEvent("emergency:presetFunctions")
AddEventHandler("emergency:presetFunctions",function(number)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if not vRP.wantedReturn(user_id) and not vRP.reposeReturn(user_id) then
				if vRPclient.getHealth(source) > 101 and not vPLAYER.getHandcuff(source) then
					local model = vRPclient.getModelPlayer(source)
				if vRP.hasPermission(user_id,"Paramedic") and preset["Paramedic"][number] then
					if model == "mp_m_freemode_01" then
						TriggerClientEvent("updateRoupas",source,preset["Paramedic"][number]["homem"])
					elseif model == "mp_f_freemode_01" then
						TriggerClientEvent("updateRoupas",source,preset["Paramedic"][number]["mulher"])
					end
				elseif vRP.hasPermission(user_id,"Police") and preset["Police"][number] then
					if model == "mp_m_freemode_01" then
						TriggerClientEvent("updateRoupas",source,preset["Police"][number]["homem"])
					elseif model == "mp_f_freemode_01" then
						TriggerClientEvent("updateRoupas",source,preset["Police"][number]["mulher"])
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:OUTFITFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:outfitFunctions")
AddEventHandler("player:outfitFunctions",function(outfitFunctions)
	local user_id = vRP.getUserId(source)
	if user_id then
	    if vRPclient.getHealth(source) > 101 and not vPLAYER.getHandcuff(source) then
			vPLAYER.setRemoveoutfit(source)
	    end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OUTFIT SAVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:outfitPlayerSave")
AddEventHandler("player:outfitPlayerSave",function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if not vRP.wantedReturn(user_id) and not vRP.reposeReturn(user_id) then
            local custom = vSKINSHOP.getCustomization(source)
            if custom then
                vRP.setSData("saveClothes:"..parseInt(user_id),json.encode(custom))
                TriggerClientEvent("Notify",source,"verde","Outfit salvo com sucesso.",3000)
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OUTFIT APPLY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:outfitPlayerApply")
AddEventHandler("player:outfitPlayerApply",function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if not vRP.wantedReturn(user_id) and not vRP.reposeReturn(user_id) then
            local consult = vRP.getSData("saveClothes:"..parseInt(user_id))
            local result = json.decode(consult)
            if result then
                TriggerClientEvent("updateRoupas",source,result)
                TriggerClientEvent("Notify",source,"verde","Outfit aplicado com sucesso.",3000)
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GIVEANIMAL
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.giveAnimal(animal)
	local source = source
    local user_id = vRP.getUserId(source)
	if user_id then
		vRP.giveInventoryItem(user_id,animal:lower(),1,true)
	end
end