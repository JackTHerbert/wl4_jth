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
  local jewelCount = Tracker:ProviderCountForCode("entryne","entrynw","entryse","entrysw")
  local jewelReq = 3
  return jewelCount - jewelReq
end

function cractus()
  local jewelCount = Tracker:ProviderCountForCode("emeraldne","emeraldse","emeraldsw","emeraldnw")
  local jewelReq = 15
  return jewelCount - jewelReq
end

function cuckoo()
  local jewelCount = Tracker:ProviderCountForCode("rubyne","rubyse","rubysw","rubynw")
  local jewelReq = 15
  return jewelCount - jewelReq
end

function aerodent()
  local jewelCount = Tracker:ProviderCountForCode("topazne","topazse","topazsw","topaznw")
  local jewelReq = 15
  return jewelCount - jewelReq
end

function catbat()
  local jewelCount = Tracker:ProviderCountForCode("sapphirene","sapphirese","sapphiresw","sapphirenw")
  local jewelReq = 15
  return jewelCount - jewelReq
end

function diva()
  local jewelneCount = Tracker:ProviderCountForCode("goldenne")
  local jewelseCount = Tracker:ProviderCountForCode("goldense")
  local jewelswCount = Tracker:ProviderCountForCode("goldensw")
  local jewelnwCount = Tracker:ProviderCountForCode("goldennw")
  local jewelReq = 4
  local jewelCount = jewelneCount + jewelseCount + jewelswCount + jewelnwCount
  return jewelCount - jewelReq
end

