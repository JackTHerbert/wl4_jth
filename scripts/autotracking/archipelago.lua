ScriptHost:LoadScript("scripts/autotracking/item_mapping.lua")
ScriptHost:LoadScript("scripts/autotracking/location_mapping.lua")
ScriptHost:LoadScript("scripts/autotracking/ap_slot.lua")
ScriptHost:LoadScript("scripts/autotracking/flag_mapping.lua")
ScriptHost:LoadScript("scripts/autotracking/room_mapping.lua")

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
    MISSING_LOCATIONS = Archipelago.MissingLocations or -1
--    for i = 0, 3 do
--        print(MISSING_LOCATIONS[i])
--	  end


	--print(dump_table(slot_data))

	for k,v in pairs(slot_data) do
		if SLOT_CODES[k] then
			Tracker:FindObjectForCode(SLOT_CODES[k].code).CurrentStage = SLOT_CODES[k].mapping[v]
		end
	end

    if PLAYER_ID > -1 then
        updateEvents(0, true)
        EVENT_ID = "wl4_events_"..TEAM_NUMBER.."_"..PLAYER_ID
        Archipelago:SetNotify({EVENT_ID})
        Archipelago:Get({EVENT_ID})
        updateMap(0xFFFFFF, true)
        ROOM_ID = "wl4_room_"..TEAM_NUMBER.."_"..PLAYER_ID
        Archipelago:SetNotify({ROOM_ID})
        Archipelago:Get({ROOM_ID})
        updateStatus("CLIENT_UNKNOWN", 0)
        CLIENTSTATUS = "_read_client_status_"..TEAM_NUMBER.."_"..PLAYER_ID
        Archipelago:SetNotify({CLIENTSTATUS})
        Archipelago:Get({CLIENTSTATUS})
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

function onNotify(k, v, old_value)
	if v ~= old_value then
		if k == EVENT_ID then
		    updateEvents(v, false)
        elseif k == ROOM_ID then
            updateMap(v, false)
        elseif k == CLIENTSTATUS then
            updateStatus(_, v)
		end
	end
end

function onNotifyLaunch(k, v)
	if k == EVENT_ID then
		updateEvents(v, false)
    elseif k == ROOM_ID then
        updateMap(v, false)
    elseif k == CLIENTSTATUS then
        updateStatus(_, v)
	end
end

function updateEvents(value, reset)
    if value ~= nil then
      if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("updateEvents: Value - %s", v))
      end
      for _, event in pairs(EVENT_FLAG_MAPPING) do
        local bitmask = 2 ^ event.bit
        if reset or (value & bitmask ~= event.status) then
          event.status = value & bitmask
          for _, code in pairs(event.codes) do
            if code.setting == nil or has(code.setting) then
                Tracker:FindObjectForCode(code.code).Active = value & bitmask ~= 0
            end
          end
        end
      end
    end
end

function updateStatus(_, v)
    local status = v
    if v == 30 then
        Tracker:FindObjectForCode("eventdiva").Active = 1
    end
    if (v == 30 and MISSING_LOCATIONS[1] == nil) then
        Tracker:FindObjectForCode("keyzerptp").Active = 1
        Tracker:FindObjectForCode("keyzerwf").Active = 1
        Tracker:FindObjectForCode("keyzerml").Active = 1
        Tracker:FindObjectForCode("keyzermj").Active = 1
        Tracker:FindObjectForCode("keyzercf").Active = 1
        Tracker:FindObjectForCode("keyzertl").Active = 1
        Tracker:FindObjectForCode("keyzerbf").Active = 1
        Tracker:FindObjectForCode("keyzerpz").Active = 1
        Tracker:FindObjectForCode("keyzertbt").Active = 1
        Tracker:FindObjectForCode("keyzerbb").Active = 1
        Tracker:FindObjectForCode("keyzerdw").Active = 1
        Tracker:FindObjectForCode("keyzerdr").Active = 1
        Tracker:FindObjectForCode("keyzercmv").Active = 1
        Tracker:FindObjectForCode("keyzeran").Active = 1
        Tracker:FindObjectForCode("keyzerfc").Active = 1
        Tracker:FindObjectForCode("keyzerhh").Active = 1
        Tracker:FindObjectForCode("keyzergp").Active = 1
        Tracker:FindObjectForCode("eventcractus").Active = 1
        Tracker:FindObjectForCode("eventcondor").Active = 1
        Tracker:FindObjectForCode("eventaerodent").Active = 1
        Tracker:FindObjectForCode("eventcatbat").Active = 1
    end
end

function updateMap(v, reset)
    if has("op_auto_tab_on") then
        local tabs = ROOM_FLAG_MAPPING[v][0]
        if tabs then
            for _, tab in ipairs(tabs) do
                Tracker:UiHint("ActivateTab", tab)
            end
        end
    end
end

Archipelago:AddClearHandler("clear handler", onClear)
Archipelago:AddItemHandler("item handler", onItem)
Archipelago:AddLocationHandler("location handler", onLocation)
Archipelago:AddSetReplyHandler("notify handler", onNotify)
Archipelago:AddRetrievedHandler("notify launch handler", onNotifyLaunch)