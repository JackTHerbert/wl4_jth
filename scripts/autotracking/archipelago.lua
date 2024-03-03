ScriptHost:LoadScript("scripts/autotracking/item_mapping.lua")
ScriptHost:LoadScript("scripts/autotracking/location_mapping.lua")
ScriptHost:LoadScript("scripts/autotracking/ap_slot.lua")

CUR_INDEX = -1
SLOT_DATA = nil
LOCAL_ITEMS = {}
GLOBAL_ITEMS = {}

function onClear(slot_data)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("called onClear, slot_data:\n%s", dump_table(slot_data)))
    end
    SLOT_DATA = slot_data
    CUR_INDEX = -1
    -- reset locations
    for _, v in pairs(LOCATION_MAPPING) do
        if v[1] then
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onClear: clearing location %s", v[1]))
            end
            local obj = Tracker:FindObjectForCode(v[1])
            if obj then
                if v[1]:sub(1, 1) == "@" then
                    obj.AvailableChestCount = obj.ChestCount
                else
                    obj.Active = false
                end
            elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onClear: could not find object for code %s", v[1]))
            end
        end
    end
    -- reset items
    for _, v in pairs(ITEM_MAPPING) do
        if v[1] and v[2] then
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onClear: clearing item %s of type %s", v[1], v[2]))
            end
            local obj = Tracker:FindObjectForCode(v[1])
            if obj then
                if v[2] == "toggle" then
                    obj.Active = false
                elseif v[2] == "progressive" then
                    obj.CurrentStage = 0
                    obj.Active = false
                elseif v[2] == "consumable" then
                    obj.AcquiredCount = 0
                elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                    print(string.format("onClear: unknown item type %s for code %s", v[2], v[1]))
                end
            elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onClear: could not find object for code %s", v[1]))
            end
        end
    end
    
    LOCAL_ITEMS = {}
    GLOBAL_ITEMS = {}

    if SLOT_DATA == nil then
        return
    end
    PLAYER_ID = Archipelago.PlayerNumber or -1
	TEAM_NUMBER = Archipelago.TeamNumber or 0
	
	--print(dump_table(slot_data))

	for k,v in pairs(slot_data) do
		if SLOT_CODES[k] then
			Tracker:FindObjectForCode(SLOT_CODES[k].code).CurrentStage = SLOT_CODES[k].mapping[v]
		end
	end

    -- Thank you @alwaysintreble on the poptracker discord for help here
    if slot_data["required_jewels"] then
        Tracker:FindObjectForCode("op_reqjewel").AcquiredCount = tonumber(slot_data["required_jewels"])
        if slot_data["required_jewels"] == 0 then
            Tracker:FindObjectForCode("op_reqgjewel").AcquiredCount = tonumber(slot_data["required_jewels"])
        else
            Tracker:FindObjectForCode("op_reqgjewel").AcquiredCount = 1
        end
    end

    if Tracker:FindObjectForCode("op_doors").CurrentStage == 0 then
        Tracker:FindObjectForCode("keyzerhoh").Active = true
        Tracker:FindObjectForCode("keyzerptp").Active = true
        Tracker:FindObjectForCode("keyzerwf").Active = true
        Tracker:FindObjectForCode("keyzerml").Active = true
        Tracker:FindObjectForCode("keyzermj").Active = true
        Tracker:FindObjectForCode("keyzercf").Active = true
        Tracker:FindObjectForCode("keyzertl").Active = true
        Tracker:FindObjectForCode("keyzerbf").Active = true
        Tracker:FindObjectForCode("keyzerpz").Active = true
        Tracker:FindObjectForCode("keyzertbt").Active = true
        Tracker:FindObjectForCode("keyzerbb").Active = true
        Tracker:FindObjectForCode("keyzerdw").Active = true
        Tracker:FindObjectForCode("keyzerdr").Active = true
        Tracker:FindObjectForCode("keyzercmv").Active = true
        Tracker:FindObjectForCode("keyzeran").Active = true
        Tracker:FindObjectForCode("keyzerfc").Active = true
        Tracker:FindObjectForCode("keyzerhh").Active = true
        Tracker:FindObjectForCode("keyzergp").Active = true
    elseif Tracker:FindObjectForCode("op_doors").CurrentStage == 1 then
        Tracker:FindObjectForCode("keyzerhoh").Active = true
        Tracker:FindObjectForCode("keyzerptp").Active = true
        Tracker:FindObjectForCode("keyzerwf").Active = true
        Tracker:FindObjectForCode("keyzerml").Active = true
        Tracker:FindObjectForCode("keyzermj").Active = true
        Tracker:FindObjectForCode("keyzercf").Active = true
        Tracker:FindObjectForCode("keyzertl").Active = true
        Tracker:FindObjectForCode("keyzerbf").Active = true
        Tracker:FindObjectForCode("keyzerpz").Active = true
        Tracker:FindObjectForCode("keyzertbt").Active = true
        Tracker:FindObjectForCode("keyzerbb").Active = true
        Tracker:FindObjectForCode("keyzerdw").Active = true
        Tracker:FindObjectForCode("keyzerdr").Active = true
        Tracker:FindObjectForCode("keyzercmv").Active = true
        Tracker:FindObjectForCode("keyzeran").Active = true
        Tracker:FindObjectForCode("keyzerfc").Active = true
        Tracker:FindObjectForCode("keyzerhh").Active = true
    end
end

-- called when an item gets collected
function onItem(index, item_id, item_name, player_number)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("called onItem: %s, %s, %s, %s, %s", index, item_id, item_name, player_number, CUR_INDEX))
    end
    if index <= CUR_INDEX then
        return
    end
    local is_local = player_number == Archipelago.PlayerNumber
    CUR_INDEX = index;
    local v = ITEM_MAPPING[item_id]
    if not v then
        if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print(string.format("onItem: could not find item mapping for id %s", item_id))
        end
        return
    end
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("onItem: code: %s, type %s", v[1], v[2]))
    end
    if not v[1] then
        return
    end
    local obj = Tracker:FindObjectForCode(v[1])
    if obj then
        if v[2] == "toggle" then
            obj.Active = true
        elseif v[2] == "progressive" then
            if obj.Active then
                obj.CurrentStage = obj.CurrentStage + 1
            else
                obj.Active = true
            end
        elseif v[2] == "consumable" then
            obj.AcquiredCount = obj.AcquiredCount + obj.Increment
        elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print(string.format("onItem: unknown item type %s for code %s", v[2], v[1]))
        end
    elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("onItem: could not find object for code %s", v[1]))
    end
    -- track local items via snes interface
    if is_local then
        if LOCAL_ITEMS[v[1]] then
            LOCAL_ITEMS[v[1]] = LOCAL_ITEMS[v[1]] + 1
        else
            LOCAL_ITEMS[v[1]] = 1
        end
    else
        if GLOBAL_ITEMS[v[1]] then
            GLOBAL_ITEMS[v[1]] = GLOBAL_ITEMS[v[1]] + 1
        else
            GLOBAL_ITEMS[v[1]] = 1
        end
    end
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("local items: %s", dump_table(LOCAL_ITEMS)))
        print(string.format("global items: %s", dump_table(GLOBAL_ITEMS)))
    end
    if PopVersion < "0.20.1" or AutoTracker:GetConnectionState("SNES") == 3 then
        -- add snes interface functions here for local item tracking
    end
end

--called when a location gets cleared
function onLocation(location_id, location_name)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("called onLocation: %s, %s", location_id, location_name))
    end
    local v = LOCATION_MAPPING[location_id]
    if not v and AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("onLocation: could not find location mapping for id %s", location_id))
    end
    if not v[1] then
        return
    end
    local obj = Tracker:FindObjectForCode(v[1])
    if obj then
        if v[1]:sub(1, 1) == "@" then
            obj.AvailableChestCount = obj.AvailableChestCount - 1
        else
            obj.Active = true
        end
    elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("onLocation: could not find object for code %s", v[1]))
    end
end

Archipelago:AddClearHandler("clear handler", onClear)
Archipelago:AddItemHandler("item handler", onItem)
Archipelago:AddLocationHandler("location handler", onLocation)