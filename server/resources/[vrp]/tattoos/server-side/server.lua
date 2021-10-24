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
Tunnel.bindInterface("tattoos",cRP)
vCLIENT = Tunnel.getInterface("tattoos")
vSKINSHOP = Tunnel.getInterface("skinshop")
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATETATTOO
----------------------------------------------------------------------------- ------------------------------------------------------------
function cRP.updateTattoo(status)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.setUData(user_id,"Tattoos",json.encode(status))
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVE ROUPAS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.saveClothes()
	local source = source
	local user_id = vRP.getUserId(source)
	local custom = vSKINSHOP.getCustomization(source)
	if custom then
		vRP.setSData("tattoosClothes:"..parseInt(user_id),json.encode(custom))
	end
end

function cRP.applyClothes()
    local source = source
    local user_id = vRP.getUserId(source)
    local consult = vRP.getSData("tattoosClothes:"..parseInt(user_id))
    local result = json.decode(consult)
    if result then
        TriggerClientEvent("updateRoupas",source,result)
    end
end