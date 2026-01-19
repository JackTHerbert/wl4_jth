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

diffmap={[0]=0,[1]=1,[2]=2}
normalmap={[0]=0,[1]=1}
treasuremap={[0]=0,[1]=1,[2]=1,[3]=1,[4]=1}
doormap={[0]=2,[1]=1,[2]=0}

SLOT_CODES = {
    difficulty={
        code="op_difficulty",
        mapping=diffmap
    },
    portal={
        code="op_openportal",
        mapping=normalmap
    },
    logic={
        code="op_advancedlogic",
        mapping=normalmap
	},	
	goal={
		code="op_treasurehunt",
		mapping=treasuremap	
    },
	open_doors={
		code="op_doors",
		mapping=doormap
	},
	diamond_shuffle={
		code="op_diamond",
		mapping=normalmap
	},
	keyzer_shuffle={
		code="op_keyzershuffle",
		mapping=normalmap
	}
}