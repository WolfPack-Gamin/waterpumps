VORP = exports.vorp_inventory:vorp_inventoryApi()

local VorpCore = {}

TriggerEvent("getCore",function(core)
   VorpCore = core
end)

Citizen.CreateThread(function()
	Citizen.Wait(2000)
	VORP.RegisterUsableItem("empty_canteen", function(data)
		TriggerClientEvent('green:StartFilling', data.source)
	end)
end)
Citizen.CreateThread(function()
	Citizen.Wait(2000)
	VORP.RegisterUsableItem("empty_bucket", function(data)
		TriggerClientEvent('green:StartFilling', data.source)
	end)
end)


RegisterNetEvent("fillup1")
AddEventHandler("fillup1", function()
    local item = "canteen_100"
	local r = 1
    local _source = source 
    if r then
		VORP.subItem(_source, "empty_canteen", 1)
        VORP.addItem(_source, item, 1)
        TriggerClientEvent("vorp:TipBottom", _source, Config.fullupp, 4000)
    end
end)
RegisterNetEvent("fillup2")
AddEventHandler("fillup2", function()
    local item = "bucket_100"
	local r = 1
    local _source = source 
    if r then
		VORP.subItem(_source, "empty_bucket", 1)
        VORP.addItem(_source, item, 1)
        TriggerClientEvent("vorp:TipBottom", _source, Config.fullupp2, 4000)
    end
end)

RegisterServerEvent("checkcanteen")
AddEventHandler("checkcanteen", function(rock)
	local _source = source
	local Character = VorpCore.getUser(_source).getUsedCharacter
	local empty = VORP.getItemCount(_source, 'empty_canteen')

	if empty > 0 then
		TriggerClientEvent("canteencheck", _source)
	else
		TriggerClientEvent("vorp:TipBottom", _source, Config.cantfill1, 4000)
	end
end)
RegisterServerEvent("checkbucket")
AddEventHandler("checkbucket", function(rock)
	local _source = source
	local Character = VorpCore.getUser(_source).getUsedCharacter
	local empty = VORP.getItemCount(_source, 'empty_bucket')

	if empty > 0 then
		TriggerClientEvent("bucketcheck", _source)
	else
		TriggerClientEvent("vorp:TipBottom", _source, Config.cantfill2, 4000)
	end
end)
RegisterServerEvent("checkdrink")
AddEventHandler("checkdrink", function(rock)
	local _source = source
	local Character = VorpCore.getUser(_source).getUsedCharacter
	

	
		TriggerClientEvent("drinkcheck", _source)
	
	
end)