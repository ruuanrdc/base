-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXAO
-----------------------------------------------------------------------------------------------------------------------------------------
vRPclient = Tunnel.getInterface("vRP")
vCLIENT = Tunnel.getInterface("police")
vPRISON = Tunnel.getInterface("prison")
vPLAYER = Tunnel.getInterface("player")
local fines = "https://discord.com/api/webhooks/897723613275357185/rh5lk05IlVyylRGGbB5MNZefINlBTbCXyzuBNb2TDFVvycxbLomgu7Kk_LYrgAPCJxD8"
local prisonlog = "https://discord.com/api/webhooks/897684538589859840/LzakDeCUQQATM89H6tyFWecj7c09nZ6_yriEXJCMqaJbcsC0jPWuxzJoROuC3yyn5jTn"
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXAO
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("police",cRP)

local preset = {
	["Prisao"] = {
		["1"] = {
			["homem"] = {
				["hat"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 5, texture = 7, defaultItem = 0, defaultTexture = 0 },
				["vest"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 5, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["t-shirt"] = { item = -1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso2"] = { item = 22, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["accessory"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
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
-- PREPARES PRISAO 
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vRP/get_prison","SELECT * FROM vrp_prison WHERE user_id = @user_id ")
vRP.prepare("vRP/tablet_prison","INSERT INTO vrp_prison(user_id,name,prison,multa,text,date,date2) VALUES(@user_id,@name,@prison,@multa,@text,@date,@date2)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- INITPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.initPrison(passaporte,services,multas,texto)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(parseInt(passaporte))
	local identity2 = vRP.getUserIdentity(parseInt(user_id))
	local lastname = identity2.name.." "..identity2.name2
	local nplayer = vRP.getUserSource(parseInt(passaporte))
	if nplayer then
		vRP.execute("vRP/set_prison",{ user_id = parseInt(passaporte), prison = parseInt(services), locate = parseInt(1), desc = texto })
		vRP.execute("vRP/tablet_prison",{ user_id = passaporte, name = lastname, prison = parseInt(services), multa = parseInt(multas), text = texto, date = os.date("%d.%m.%Y"), date2 = os.date("%H:%M") })
		vPRISON.startPrison(nplayer,1)
		vRPclient.teleport(nplayer,1677.72,2509.68,45.57)
		TriggerClientEvent("police:Update",source,"reloadPrison")
		vRP.setFines(passaporte,multas,user_id,texto)
		local model = vRP.modelPlayer(source)
		TriggerClientEvent("updateRoupas",source,preset["Prisao"]["1"][model])
		TriggerClientEvent("Notify",source,"verde","<b>"..identity.name.." "..identity.name2.."</b> enviado para a prisão <b>"..parseInt(services).." serviços</b>.",5000)
		vRP.createWeebHook(prisonlog,"```PASSPORT: "..parseInt(passaporte).."\nNAME: "..identity.name.." "..identity.name2.."\nSERVICES: "..parseInt(services).."\nCRIMES: "..texto.."\nBY: "..identity2.name.." "..identity2.name2..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").."```")
		end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INITFINE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.initFine(passaporte,multas,texto)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Police") then
			local nuser_id = passaporte

			local value = multas

			local reason = texto

			local identity = vRP.getUserIdentity(parseInt(nuser_id))
			local identity2 = vRP.getUserIdentity(parseInt(user_id))
			local source2 = vRP.getUserSource(nuser_id)
			if identity then
				vRP.setFines(parseInt(nuser_id),parseInt(value),parseInt(user_id),tostring(reason))
				TriggerClientEvent("police:Update",source,"reloadFine")
				TriggerClientEvent("Notify",source,"verde","Multa aplicada em <b>"..identity.name.." "..identity.name2.."</b> no valor de <b>$"..vRP.format(parseInt(value)).." dólares</b>.",5000)
				TriggerClientEvent("Notify",source2,"amarelo","Você recebeu uma multa </b> no valor de <b>$ "..vRP.format(parseInt(value)).." dólares</b>.",5000)
				vRP.createWeebHook(fines,"```PASSPORT: "..parseInt(nuser_id).."\nNAME: "..identity.name.." "..identity.name2.."\nVALUE: $"..vRP.format(parseInt(value)).."\nCRIMES: "..reason.."\nBY: "..identity2.name.." "..identity2.name2..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").."```")
			end
		end
	end
end

function cRP.searchUser(passaporte)
    local user_id = passaporte
	local identity = vRP.getUserIdentity(user_id)
	-- local query = vRP.query("vRP/get_prison",{ user_id = user_id })
	-- if query[1] == nil then
	-- 	teste = false
	-- else
	-- 	teste = true
	-- end
	if identity then
		local lastname = identity.name.." "..identity.name2
		local telefone = identity.phone
		local dados = {}
		local query = vRP.query("vRP/get_prison",{ user_id = user_id })
		local fines = 0
		local consult = vRP.getFines(user_id)
		for k,v in pairs(consult) do
			fines = parseInt(fines) + parseInt(v.price)
		end
		local multa = vRP.format(parseInt(fines))
		for k2,v2 in pairs(query) do
			police2 = v2.name
			services = v2.prison
			multas = v2.multa
			date = v2.date
			date2 = v2.date2
			text = v2.text
			table.insert(dados,{ k = k2 , name = lastname , phone = telefone, multa = multa, police = police2, services = services, fines = multas, date = date, date2 = date2, text = text  })
		end
		if #dados <= 0 then 
			table.insert(dados,{name = lastname , phone = telefone, multa = multa or nil})
		end
		return dados
	else
		return {{name = nil , phone = nil, multa = nil}}
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKTABLET
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkPoliceTablet()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.getInventoryItemAmount(user_id,"coptablet") <= 1 then
            return true
        end
        return false
    end
end
