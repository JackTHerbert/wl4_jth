-- Borrowed from Pokemon Emerald AP Poptracker
function resetItems() 
	for _, v in pairs(ITEM_MAPPING) do
		if v[1] then
			local obj = Tracker:FindObjectForCode(v[1])
			if obj then
				obj.Active = false
			end
		end
	end
end

function resetLocations() 
	for _, v in pairs(LOCATION_MAPPING) do
		if v[1] then
			local obj = Tracker:FindObjectForCode(v[1])
			if obj then
				obj.AvailableChestCount = 1
			end
		end
	end
end

jewelmap={[0]=0,[1]=1,[2]=2,[3]=3,[4]=4}
diffmap={[0]=0,[1]=1,[2]=2}
normalmap={[0]=0,[1]=1}
-- goldjewelmap={[0]=0,[1]=1,[2]=1,[3]=1,[4]=1}

SLOT_CODES = {
    difficulty={
        code="op_difficulty",
        mapping=diffmap
    },
-- This code works if Required Jewels item in items.json is a progressive item, but logic.lua doesnt seem to pull any numbers from it, essentially breaking the actual tracking
--    required_jewels={
--        code="op_reqjewel",
--        mapping=jewelmap
--    },
-- This code breaks things either way! Something else needs to be done.
--    required_jewels={
--        code="op_reqgjewel",
--        mapping=goldjewelmap
--    },
    portal={
        code="op_openportal",
        mapping=normalmap
    },
    logic={
        code="op_advancedlogic",
        mapping=normalmap
    }
}