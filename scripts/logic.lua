---[[
function has(item, amount)
    local count = Tracker:ProviderCountForCode(item)
    amount = tonumber(amount)
    if not amount then
      return count > 0
    else
      return count >= amount
    end
end

-- basic functions
function groundpound()
    return has("groundpound")
end

function supergroundpound()
  return has("supergroundpound")
end

function swim()
  return has("swim")
end

function headsmash()
  return has("headsmash")
end

function grab()
  return has("grab")
end

function supergrab()
  return has("supergrab")
end

function dashattack()
  return has("dashattack")
end

function enemyjump()
  return has("enemyjump")
end



function spoiled()
  local jewelneCount = Tracker:ProviderCountForCode("entryne")
  local jewelseCount = Tracker:ProviderCountForCode("entryse")
  local jewelswCount = Tracker:ProviderCountForCode("entrysw")
  local jewelnwCount = Tracker:ProviderCountForCode("entrynw")
  local jewelReq = 3
  local jewelCount = jewelneCount + jewelseCount + jewelswCount + jewelnwCount
  return jewelCount - jewelReq
end

function cractus()
  local jewelneCount = Tracker:ProviderCountForCode("emeraldne")
  local jewelseCount = Tracker:ProviderCountForCode("emeraldse")
  local jewelswCount = Tracker:ProviderCountForCode("emeraldsw")
  local jewelnwCount = Tracker:ProviderCountForCode("emeraldnw")
  local jewelReq = 15
  local jewelCount = jewelneCount + jewelseCount + jewelswCount + jewelnwCount
  return jewelCount - jewelReq
end

function cuckoo()
  local jewelneCount = Tracker:ProviderCountForCode("rubyne")
  local jewelseCount = Tracker:ProviderCountForCode("rubyse")
  local jewelswCount = Tracker:ProviderCountForCode("rubysw")
  local jewelnwCount = Tracker:ProviderCountForCode("rubynw")
  local jewelReq = 15
  local jewelCount = jewelneCount + jewelseCount + jewelswCount + jewelnwCount
  return jewelCount - jewelReq
end

function aerodent()
  local jewelneCount = Tracker:ProviderCountForCode("topazne")
  local jewelseCount = Tracker:ProviderCountForCode("topazse")
  local jewelswCount = Tracker:ProviderCountForCode("topazsw")
  local jewelnwCount = Tracker:ProviderCountForCode("topaznw")
  local jewelReq = 15
  local jewelCount = jewelneCount + jewelseCount + jewelswCount + jewelnwCount
  return jewelCount - jewelReq
end

function catbat()
  local jewelneCount = Tracker:ProviderCountForCode("sapphirene")
  local jewelseCount = Tracker:ProviderCountForCode("sapphirese")
  local jewelswCount = Tracker:ProviderCountForCode("sapphiresw")
  local jewelnwCount = Tracker:ProviderCountForCode("sapphirenw")
  local jewelReq = 15
  local jewelCount = jewelneCount + jewelseCount + jewelswCount + jewelnwCount
  return jewelCount - jewelReq
end

function diva()
  local jewelneCount = Tracker:ProviderCountForCode("goldenne")
  local jewelseCount = Tracker:ProviderCountForCode("goldense")
  local jewelswCount = Tracker:ProviderCountForCode("goldensw")
  local jewelnwCount = Tracker:ProviderCountForCode("goldennw")
  local jewelReq = 3
  local jewelCount = jewelneCount + jewelseCount + jewelswCount + jewelnwCount
  return jewelCount - jewelReq
end

