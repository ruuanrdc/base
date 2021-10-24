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
Tunnel.bindInterface("spawn",cRP)
vCLIENT = Tunnel.getInterface("spawn")
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETUPCHARS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.initSystem()
    local source = source
    local steam = vRP.getSteam(source)
    local identity = getPlayerCharacters(steam)
    local users = {}
    for k,v in pairs(identity) do
        table.insert(users,{ user_id = v["id"], name = v["name"] .. " " .. v["name2"] })
    end

    return users
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARCHOSEN
-----------------------------------------------------------------------------------------------------------------------------------------
local spawnLogin = {}
function cRP.characterChosen(id)
	local source = source
	print(id)
	TriggerEvent("baseModule:idLoaded",source,id,nil)

	if spawnLogin[parseInt(id)] then
		TriggerClientEvent("spawn:justSpawn",source,false)
	else
		spawnLogin[parseInt(id)] = true
		TriggerClientEvent("spawn:justSpawn",source,true)	
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATECHAR
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.newCharacter(name,name2,sex)
	local source = source
	local steam = vRP.getSteam(source)
	local persons = getPlayerCharacters(steam)

	if not vRP.getPremium2(steam) and parseInt(#persons) >= 1 then
		TriggerClientEvent("Notify",source,"amarelo","Você atingiu o limite de personagens.",5000)
		return
	end

	vRP.execute("vRP/create_characters",{ steam = steam, name = name, name2 = name2 })

	local newId = 0
	local chars = getPlayerCharacters(steam)
	for k,v in pairs(chars) do
		if v.id > newId then
			newId = tonumber(v.id)
		end
	end

	spawnLogin[parseInt(newId)] = true
    vCLIENT.closeNew(source)
    TriggerEvent("baseModule:idLoaded",source,newId,sex)
	print(sex)
	TriggerClientEvent("spawn:justSpawn",source,true)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETPLAYERCHARACTERS
-----------------------------------------------------------------------------------------------------------------------------------------
function getPlayerCharacters(steam)
	return vRP.query("vRP/get_characters",{ steam = steam })
end