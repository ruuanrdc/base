-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cnVRP = {}
Tunnel.bindInterface("shops",cnVRP)
vCLIENT = Tunnel.getInterface("shops")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local shops = {
	["departamentStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
		    ["absolut"] = 215,
			["coffee"] = 195,
			["chandon"] = 215,
			["chocolate"] = 15,
			["cigarette"] = 75,
			["dewars"] = 215,
			["energetic"] = 500,
			["emptybottle"] = 20,
			["hennessy"] = 215,
			["lighter"] = 175,
			["backpack"] = 15000,
			["hamburger"] = 150,
			["sandwich"] = 125,
			["cola"] = 50,
			["donut"] = 50,
			["tires"] = 2500,
			["toolbox"] = 5000
		}
	},
	["eletronicos"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["radio"] = 2000,
			["cellphone"] = 2000,
			["binoculars"] = 500,
			["camera"] = 1000,
			["vape"] = 2000,
			["cellbattery"] = 250
		}
	},
	["Malibu"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["hamburger"] = 250
		}
	},
	["pneus"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["tires"] = 2500
		}
	},
	["mec"] = {
		["perm"] = "Mechanic",
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["tires"] = 500,
			["toolbox"] = 1000
		}
	},
	["Armaporte"] = {
		["perm"] = "ChiefPolice",
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["WEAPON_PISTOL"] = 25000,
			["WEAPON_PISTOL_AMMO"] = 10
		}
	},
	["porte"] = {
		["perm"] = "Medic",
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["porte"] = 50000,
		}
	},
	["ferramentas"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["toolbox"] = 5000
		}
	},
	["ammunationStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["WEAPON_BAT"] = 975,
			["WEAPON_MACHETE"] = 975,
			["WEAPON_FLASHLIGHT"] = 675,
			["WEAPON_HATCHET"] = 975,
			["WEAPON_BATTLEAXE"] = 975,
			["WEAPON_STONE_HATCHET"] = 975,
			["WEAPON_HAMMER"] = 725,
			["GADGET_PARACHUTE"] = 475,
			["WEAPON_KNUCKLE"] = 975,
			["WEAPON_GOLFCLUB"] = 975,
			["WEAPON_KNIFE"] = 5000,
			["WEAPON_POOLCUE"] = 975
		}
	},
	["casinoStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["chips"] = 500
		}
	},
	["normalpharmacyStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["adrenaline"] = 5000,
			["analgesic"] = 200,
			["bandage"] = 370,
			["gauze"] = 200,
			["warfarin"] = 925,
			["ritmoneury"] = 475,
			["sinkalmy"] = 325
		}
	},
	["hospitalpharmacyStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["perm"] = "Paramedic",
		["list"] = {
			["adrenaline"] = 675,
			["analgesic"] = 55,
			["bandage"] = 105,
			["gauze"] = 105,
			["warfarin"] = 225,
			["ritmoneury"] = 275,
			["sinkalmy"] = 120
		}
	},
	["Sucos"] = {
		["mode"] = "Buy",
		["type"] = "Sell",
		["list"] = {
			["bananajuice"] = 300,
			["orangejuice"] = 320,
			["passionjuice"] = 280,
			["strawberryjuice"] = 300,
			["tangejuice"] = 300,
			["grapejuice"] = 270
		}
	},
	["premiumStore"] = {
		["mode"] = "Buy",
		["type"] = "Premium",
		["list"] = {
			["premium01"] = 15,
			["premium02"] = 25,
			["premium03"] = 35,
			["premium04"] = 45,
			["premiumplate"] = 25,
			["newgarage"] = 25,
			["newchars"] = 25,
			["namechange"] = 15
		}
	},
	["jewelryStore"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["ametista"] = 22,
			["diamante"] = 26,
			["esmeralda"] = 30,
			["rubi"] = 22,
			["safira"] = 20,
			["turquesa"] = 20,
			["ambar"] = 20
		}
	},
	["huntingStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["WEAPON_SWITCHBLADE"] = 725,
			["WEAPON_MUSKET_AMMO"] = 7,
			["WEAPON_MUSKET"] = 3250
		}
	},
	["fishingStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["bait"] = 10,
			["fishingrod"] = 5000
		}
	},
	["fishingSell"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["shrimp"] = 50,
			["octopus"] = 45,
			["carp"] = 40
		}
	},
	["Colheita"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["orange"] = 50,
			["strawberry"] = 45,
			["grape"] = 40,
			["tange"] = 40,
			["banana"] = 50,
			["passion"] = 30,
			["tomato"] = 20
		}
	},
	["recyclingSell"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["plastic"] = 150,
			["glass"] = 150,
			["rubber"] = 150,
			["aluminum"] = 200,
			["copper"] = 200,
			["eletronics"] = 20,
			["emptybottle"] = 20,
			["lighter"] = 300,
			["bucket"] = 100,
			["divingsuit"] = 2500,
			["teddy"] = 250,
			["fishingrod"] = 2500,
			["identity"] = 300,
			["radio"] = 2000,
			["cellphone"] = 1000,
			["binoculars"] = 500,
			["camera"] = 1000,
			["vape"] = 1500,
			["pager"] = 3000,
			["keyboard"] = 250,
			["mouse"] = 225,
			["ring"] = 200,
			["watch"] = 350,
			["goldbar"] = 500,
			["playstation"] = 400,
			["xbox"] = 400,
			["legos"] = 200,
			["ominitrix"] = 350,
			["bracelet"] = 500,
			["dildo"] = 250,
			["notepad"] = 10
		}
	},
	["registryStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["identity"] = 600
		}
	},
	["megaMallStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["postit"] = 20,
			["rope"] = 2500,
			["emptybottle"] = 50,
			["cigarette"] = 20,
			["lighter"] = 600,
			["teddy"] = 500,
			["rose"] = 50,
			["silk"] = 3,
			["paperbag"] = 50,
			["firecracker"] = 1000,
			["bucket"] = 200,
			["compost"] = 10,
			["cannabisseed"] = 10,
			["postit"] = 10
		}
	},
	["VitaleFood"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["tacos"] = 745,
			["hamburger"] = 900,
			["hotdog"] = 500,
			["sandwich"] = 875,
			["soda"] = 515,
			["cola"] = 515,
			["chocolate"] = 315,
			["donut"] = 500,
			["hennessy"] = 300,
			["absolut"] = 500,
			["chandon"] = 450,
			["dewars"] = 250
		}
	},
	["barsStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["energetic"] = 325,
			["cola"] = 515,
			["soda"] = 515,
			["absolut"] = 200,
			["chandon"] = 200,
			["dewars"] = 200,
			["hennessy"] = 200
		}
	},
	["coffeeMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["coffee"] = 205
		}
	},
	["sodaMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["soda"] = 515
		}
	},
	["colaMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["cola"] = 515
		}
	},
	["donutMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["donut"] = 9,
			["chocolate"] = 315
		}
	},
	["burgerMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["hamburger"] = 920
		}
	},
	["hotdogMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["hotdog"] = 900
		}
	},
	["waterMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["water"] = 850
		}
	},
	["policeStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["perm"] = "Police",
		["list"] = {
			["vest"] = 1000,
			["gsrkit"] = 200,
			["gdtkit"] = 200,
			["WEAPON_SMG"] = 700,
			["WEAPON_PUMPSHOTGUN"] = 2000,
			["WEAPON_CARBINERIFLE"] = 1200,
			["WEAPON_FIREEXTINGUISHER"] = 200,
			["WEAPON_STUNGUN"] = 200,
			["WEAPON_NIGHTSTICK"] = 200,
			["WEAPON_COMBATPISTOL"] = 750,
			["WEAPON_SMG_AMMO"] = 15,
			["WEAPON_PUMPSHOTGUN_AMMO"] = 15,
			["WEAPON_CARBINERIFLE_AMMO"] = 15,
			["WEAPON_COMBATPISTOL_AMMO"] = 15
		}
	},
	["drugsSelling"] = {
		["mode"] = "Buy",
		["type"] = "Consume",
		["item"] = "dollars2",
		["list"] = {
			["meth"] = 500,
			["lean"] = 500,
			["ecstasy"] = 500
		}
	},
	["robberysSelling"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["meth"] = 500,
			["lean"] = 500,
			["ecstasy"] = 500
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTPERM
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.requestPerm(shopType)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.wantedReturn(user_id) then
			return false
		end

		if shops[shopType]["perm"] ~= nil then
			if not vRP.hasPermission(user_id,shops[shopType]["perm"]) then
				return false
			end
		end
		
		return true
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.requestShop(name)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		local inventoryShop = {}
		for k,v in pairs(shops[name]["list"]) do
			table.insert(inventoryShop,{ price = parseInt(v), name = vRP.itemNameList(k), desc = vRP.itemDescList(k), tipo = vRP.itemTipoList(k), unity = vRP.itemUnityList(k), economy = vRP.itemEconomyList(k), index = vRP.itemIndexList(k), key = k, weight = vRP.itemWeightList(k) })
		end

		local inventoryUser = {}
		local inv = vRP.getInventory(user_id)
		if inv then
			for k,v in pairs(inv) do
				if string.sub(v.item,1,9) == "toolboxes" then
					local advFile = LoadResourceFile("logsystem","toolboxes.json")
					local advDecode = json.decode(advFile)

					v.durability = advDecode[v.item]
				end
				if v.item and v.timestamp then
						local actualTime = os.time()
						local finalTime = v.timestamp
						local durabilityInSeconds = vRP.itemDurabilityList(v.item)
						local startTime = (v.timestamp - durabilityInSeconds)
						
						local actualTimeInSeconds = (actualTime - startTime)
						local porcentage = (actualTimeInSeconds/durabilityInSeconds)-1
						if porcentage < 0 then porcentage = porcentage*-1 end
						if porcentage <= 0.0 then
							porcentage = 0.0
						elseif porcentage >= 100.0 then
							porcentage = 100.0
						end
						if porcentage then
							v.durability = porcentage
						end
					end

				v.amount = parseInt(v.amount)
				v.name = vRP.itemNameList(v.item)
				v.desc = vRP.itemDescList(v.item)
				v.tipo = vRP.itemTipoList(v.item)
				v.unity = vRP.itemUnityList(v.item)
				v.economy = vRP.itemEconomyList(v.item)
				v.peso = vRP.itemWeightList(v.item)
				v.index = vRP.itemIndexList(v.item)
				v.key = v.item
				v.slot = k

				inventoryUser[k] = v
			end
		end

		return inventoryShop,inventoryUser,vRP.computeInvWeight(user_id),vRP.getBackpack(user_id),{ identity.name.." "..identity.name2,parseInt(user_id),parseInt(identity.bank),parseInt(vRP.getGmsId(user_id)),identity.phone,identity.registration }
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETSHOPTYPE
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.getShopType(name)
    return shops[name].mode
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.functionShops(shopType,shopItem,shopAmount,slot)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if shopAmount == nil then shopAmount = 1 end
		if shopAmount <= 0 then shopAmount = 1 end
		local inv = vRP.getInventory(user_id)
		if inv then
			if shops[shopType]["mode"] == "Buy" then
				if vRP.computeInvWeight(parseInt(user_id)) + vRP.itemWeightList(shopItem) * parseInt(shopAmount) <= vRP.getBackpack(parseInt(user_id)) then
					if shops[shopType]["type"] == "Cash" then
						if shops[shopType]["list"][shopItem] then

							if vRP.itemSubTypeList(shopItem) then
								if vRP.getInventoryItemAmount(user_id,shopItem) > 0 then
									TriggerClientEvent("Notify",source,"vermelho","Você já possui esse tipo de item.",5000) return
								end
							end

							if vRP.itemSubTypeList(shopItem) then
								TriggerClientEvent("Notify",source,"amarelo","Esse item pode ser comprado em apenas uma unidade",5000)
								if vRP.paymentBank(parseInt(user_id),parseInt(shops[shopType]["list"][shopItem])) then
									if inv[tostring(slot)] then
										vRP.giveInventoryItem(parseInt(user_id),shopItem,parseInt(shopAmount),false)
									else
										TriggerClientEvent("shops:Update",source,"requestShop")
										vRP.giveInventoryItem(parseInt(user_id),shopItem,parseInt(shopAmount),false,slot) return
									end				
								end
							end

							if vRP.paymentBank(parseInt(user_id),parseInt(shops[shopType]["list"][shopItem]*shopAmount)) then
								if inv[tostring(slot)] then
									vRP.giveInventoryItem(parseInt(user_id),shopItem,parseInt(shopAmount),false)
								else
									vRP.giveInventoryItem(parseInt(user_id),shopItem,parseInt(shopAmount),false,slot)
								end						
							else
								TriggerClientEvent("Notify",source,"vermelho","Dólares insuficientes.",5000)
							end
						end
					elseif shops[shopType]["type"] == "Consume" then
						if vRP.tryGetInventoryItem(parseInt(user_id),shops[shopType]["item"],parseInt(shops[shopType]["list"][shopItem]*shopAmount)) then
							if inv[tostring(slot)] then
								vRP.giveInventoryItem(parseInt(user_id),shopItem,parseInt(shopAmount),false)
							else
								vRP.giveInventoryItem(parseInt(user_id),shopItem,parseInt(shopAmount),false,slot)
							end
						else
							TriggerClientEvent("Notify",source,"vermelho","Insuficiente "..vRP.itemNameList(shops[shopType]["item"])..".",5000)
						end
					elseif shops[shopType]["type"] == "Premium" then
						local identity = vRP.getUserIdentity(parseInt(user_id))
						local consult = vRP.getInfos(identity.steam)
						if parseInt(consult[1].gems) >= parseInt(shops[shopType]["list"][shopItem]*shopAmount) then
							if inv[tostring(slot)] then
								vRP.giveInventoryItem(parseInt(user_id),shopItem,parseInt(shopAmount),false)
							else
								vRP.giveInventoryItem(parseInt(user_id),shopItem,parseInt(shopAmount),false,slot)
							end							vRP.remGmsId(user_id,parseInt(shops[shopType]["list"][shopItem]*shopAmount))
							TriggerClientEvent("Notify",source,"verde","Você comprou <b>"..vRP.format(parseInt(shopAmount)).."x "..vRP.itemNameList(shopItem).."</b> por <b>"..vRP.format(parseInt(shops[shopType]["list"][shopItem]*shopAmount)).." coins</b>.",5000)
						else
							TriggerClientEvent("Notify",source,"vermelho","Coins Insuficientes.",5000)
						end
					end
				else
					TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
				end
			elseif shops[shopType]["mode"] == "Sell" then
				if shops[shopType]["list"][shopItem] then
					if shops[shopType]["type"] == "Cash" then

						if vRP.tryGetInventoryItem(parseInt(user_id),shopItem,parseInt(shopAmount),true,slot) then	
							vRP.giveInventoryItem(parseInt(user_id),"dollars",parseInt(shops[shopType]["list"][shopItem]*shopAmount),false)
							TriggerClientEvent("Notify",source,"amarelo","Você recebeu $"..shops[shopType]["list"][shopItem]*shopAmount.." Dólares.",5000)
						end
					elseif shops[shopType]["type"] == "Consume" then
						if vRP.tryGetInventoryItem(parseInt(user_id),shopItem,parseInt(shopAmount),true,slot) then

							vRP.giveInventoryItem(parseInt(user_id),shops[shopType]["item"],parseInt(shops[shopType]["list"][shopItem]*shopAmount),false)
						end
					end
				end
			end
		end

		TriggerClientEvent("shops:Update",source,"requestShop")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("shops:populateSlot")
AddEventHandler("shops:populateSlot",function(itemName,slot,target,amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if amount == nil then amount = 1 end
		if amount <= 0 then amount = 1 end

		if vRP.tryGetInventoryItem(user_id,itemName,amount,false,slot) then
			vRP.giveInventoryItem(user_id,itemName,amount,false,target)
			TriggerClientEvent("shops:Update",source,"requestShop")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("shops:updateSlot")
AddEventHandler("shops:updateSlot",function(itemName,slot,target,amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if amount == nil then amount = 1 end
		if amount <= 0 then amount = 1 end

		local inv = vRP.getInventory(user_id)
		if inv then
			if inv[tostring(slot)] and inv[tostring(target)] and inv[tostring(slot)].item == inv[tostring(target)].item then
				if vRP.tryGetInventoryItem(user_id,itemName,amount,false,slot) then
					vRP.giveInventoryItem(user_id,itemName,amount,false,target)
				end
			else
				vRP.swapSlot(user_id,slot,target)
			end
		end

		TriggerClientEvent("shops:Update",source,"requestShop")
	end
end)