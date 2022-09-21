local buttons_prompt = GetRandomIntInRange(0, 0xffffff)
local near = 1000

function Button_Prompt()
	Citizen.CreateThread(function()
		local str = "Fill canteen"
		canteen = Citizen.InvokeNative(0x04F97DE45A519419)
		PromptSetControlAction(canteen, 0xA1ABB953)
		str = CreateVarString(10, 'LITERAL_STRING', str)
		PromptSetText(canteen, str)
		PromptSetEnabled(canteen, true)
		PromptSetVisible(canteen, true)
		PromptSetHoldMode(canteen, true)
		PromptSetGroup(canteen, buttons_prompt)
		PromptRegisterEnd(canteen)
	end)
end  
function Button_Prompt2()
	Citizen.CreateThread(function()
		local str = "Fill Bucket"
		bucket = Citizen.InvokeNative(0x04F97DE45A519419)
		PromptSetControlAction(bucket, 0x0522B243)
		str = CreateVarString(10, 'LITERAL_STRING', str)
		PromptSetText(bucket, str)
		PromptSetEnabled(bucket, true)
		PromptSetVisible(bucket, true)
		PromptSetHoldMode(bucket, true)
		PromptSetGroup(bucket, buttons_prompt)
		PromptRegisterEnd(bucket)
	end)
end
function Button_Prompt3()
    Citizen.CreateThread(function()
    local str = "Drink"
    Drink = Citizen.InvokeNative(0x04F97DE45A519419)
    PromptSetControlAction(Drink, 0x8FFC75D6)
    str = CreateVarString(10, 'LITERAL_STRING', str)
    PromptSetText(Drink, str)
    PromptSetEnabled(Drink, true)
    PromptSetVisible(Drink, true)
    PromptSetHoldMode(Drink, true)
    PromptSetGroup(Drink, buttons_prompt)
    PromptRegisterEnd(Drink)
end)
end

Citizen.CreateThread(function()
	Button_Prompt()
    while true do 
        Citizen.Wait(near)
        local player = PlayerPedId()
        local Coords = GetEntityCoords(player)
        local waterpump = DoesObjectOfTypeExistAtCoords(Coords.x, Coords.y, Coords.z, 1.0, GetHashKey("p_waterpump01x"), 0) -- prop required to interact
        if waterpump then
            near = 5
			local pump = CreateVarString(10, 'LITERAL_STRING', 'water pump')
			PromptSetActiveGroupThisFrame(buttons_prompt, pump)
			if PromptHasHoldModeCompleted(canteen) then
				TriggerServerEvent('checkcanteen')
			end
        else 
			near = 1000
        end
    end
end)
Citizen.CreateThread(function()
	Button_Prompt2()
    while true do 
        Citizen.Wait(near)
        local player = PlayerPedId()
        local Coords = GetEntityCoords(player)
        local waterpump = DoesObjectOfTypeExistAtCoords(Coords.x, Coords.y, Coords.z, 1.0, GetHashKey("p_waterpump01x"), 0) -- prop required to interact
        if waterpump then
            near = 5
			local pump = CreateVarString(10, 'LITERAL_STRING', 'water pump')
			PromptSetActiveGroupThisFrame(buttons_prompt, pump)
			if PromptHasHoldModeCompleted(bucket) then
				TriggerServerEvent('checkbucket')
			end
        else 
			near = 1000
        end
    end
end)
Citizen.CreateThread(function()
	Button_Prompt3()
    while true do 
        Citizen.Wait(near)
        local player = PlayerPedId()
        local Coords = GetEntityCoords(player)
        local waterpump = DoesObjectOfTypeExistAtCoords(Coords.x, Coords.y, Coords.z, 1.0, GetHashKey("p_waterpump01x"), 0) -- prop required to interact
        if waterpump then
            near = 5
			local pump = CreateVarString(10, 'LITERAL_STRING', 'water pump')
			PromptSetActiveGroupThisFrame(buttons_prompt, pump)
			if PromptHasHoldModeCompleted(Drink) then
				TriggerServerEvent('checkdrink')
			end
        else 
			near = 1000
        end
    end
end)

RegisterNetEvent('canteencheck')
AddEventHandler('canteencheck', function()
    doPromptAnim("amb_work@prop_human_pump_water@female_b@idle_a", "idle_a", 2);
    Wait(10000)
    ClearPedTasks(PlayerPedId())
    TriggerServerEvent("fillup1")
end)
RegisterNetEvent('bucketcheck')
AddEventHandler('bucketcheck', function()
    doPromptAnim("amb_work@prop_human_pump_water@female_b@idle_a", "idle_a", 2);
    Wait(10000)
    ClearPedTasks(PlayerPedId())
    TriggerServerEvent("fillup2")
end)
RegisterNetEvent('drinkcheck')
AddEventHandler('drinkcheck', function()
    doPromptAnim("amb_work@prop_human_pump_water@female_b@idle_a", "idle_a", 2);
    Wait(10000)
    ClearPedTasks(PlayerPedId())
    TriggerEvent("fred_meta:consume", 0, 25, 0, 0, 0.0, 0.0, 0, 0.0, 0.0)
     PlaySoundFrontend("Core_Fill_Up", "Consumption_Sounds", true, 0)
end)


function doPromptAnim(dict, anim, loop)
    activate = false
    toggle = 0
    local playerPed = PlayerPedId()
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(100)
    end
    TaskPlayAnim(playerPed, dict, anim, 8.0, -8.0, 13000, loop, 0, true, 0, false, 0, false)
	play_anim = false
end
