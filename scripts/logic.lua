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

function spoiledne()
  local jewelCount = Tracker:ProviderCountForCode("entryne")
  local jewelReq = Tracker:ProviderCountForCode("op_reqgjewel")
  return jewelCount + 1 - jewelReq
end
function spoiledse()
  local jewelCount = Tracker:ProviderCountForCode("entryse")
  local jewelReq = Tracker:ProviderCountForCode("op_reqgjewel")
  return jewelCount + 1 - jewelReq
end
function spoiledsw()
  local jewelCount = Tracker:ProviderCountForCode("entrysw")
  local jewelReq = Tracker:ProviderCountForCode("op_reqgjewel")
  return jewelCount + 1 - jewelReq
end
function spoilednw()
  local jewelCount = Tracker:ProviderCountForCode("entrynw")
  local jewelReq = Tracker:ProviderCountForCode("op_reqgjewel")
  return jewelCount + 1 - jewelReq
end

function cractusne()
  local jewelCount = Tracker:ProviderCountForCode("emeraldne")
  local jewelReq = Tracker:ProviderCountForCode("op_reqjewel")
  return jewelCount + 1 - jewelReq
end
function cractusse()
  local jewelCount = Tracker:ProviderCountForCode("emeraldse")
  local jewelReq = Tracker:ProviderCountForCode("op_reqjewel")
  return jewelCount + 1 - jewelReq
end
function cractussw()
  local jewelCount = Tracker:ProviderCountForCode("emeraldsw")
  local jewelReq = Tracker:ProviderCountForCode("op_reqjewel")
  return jewelCount + 1 - jewelReq
end
function cractusnw()
  local jewelCount = Tracker:ProviderCountForCode("emeraldnw")
  local jewelReq = Tracker:ProviderCountForCode("op_reqjewel")
  return jewelCount + 1 - jewelReq
end


function cuckoone()
  local jewelCount = Tracker:ProviderCountForCode("rubyne")
  local jewelReq = Tracker:ProviderCountForCode("op_reqjewel")
  return jewelCount + 1 - jewelReq
end
function cuckoose()
  local jewelCount = Tracker:ProviderCountForCode("rubyse")
  local jewelReq = Tracker:ProviderCountForCode("op_reqjewel")
  return jewelCount + 1 - jewelReq
end
function cuckoosw()
  local jewelCount = Tracker:ProviderCountForCode("rubysw")
  local jewelReq = Tracker:ProviderCountForCode("op_reqjewel")
  return jewelCount + 1 - jewelReq
end
function cuckoonw()
  local jewelCount = Tracker:ProviderCountForCode("rubynw")
  local jewelReq = Tracker:ProviderCountForCode("op_reqjewel")
  return jewelCount + 1 - jewelReq
end

function aerodentne()
  local jewelCount = Tracker:ProviderCountForCode("topazne")
  local jewelReq = Tracker:ProviderCountForCode("op_reqjewel")
  return jewelCount + 1 - jewelReq
end
function aerodentse()
  local jewelCount = Tracker:ProviderCountForCode("topazse")
  local jewelReq = Tracker:ProviderCountForCode("op_reqjewel")
  return jewelCount + 1 - jewelReq
end
function aerodentsw()
  local jewelCount = Tracker:ProviderCountForCode("topazsw")
  local jewelReq = Tracker:ProviderCountForCode("op_reqjewel")
  return jewelCount + 1 - jewelReq
end
function aerodentnw()
  local jewelCount = Tracker:ProviderCountForCode("topaznw")
  local jewelReq = Tracker:ProviderCountForCode("op_reqjewel")
  return jewelCount + 1 - jewelReq
end

function catbatne()
  local jewelCount = Tracker:ProviderCountForCode("sapphirene")
  local jewelReq = Tracker:ProviderCountForCode("op_reqjewel")
  return jewelCount + 1 - jewelReq
end
function catbatse()
  local jewelCount = Tracker:ProviderCountForCode("sapphirese")
  local jewelReq = Tracker:ProviderCountForCode("op_reqjewel")
  return jewelCount + 1 - jewelReq
end
function catbatsw()
  local jewelCount = Tracker:ProviderCountForCode("sapphiresw")
  local jewelReq = Tracker:ProviderCountForCode("op_reqjewel")
  return jewelCount + 1 - jewelReq
end
function catbatnw()
  local jewelCount = Tracker:ProviderCountForCode("sapphirenw")
  local jewelReq = Tracker:ProviderCountForCode("op_reqjewel")
  return jewelCount + 1 - jewelReq
end

function divane()
  local jewelCount = Tracker:ProviderCountForCode("goldenne")
  local jewelReq = Tracker:ProviderCountForCode("op_reqgjewel")
  return jewelCount + 1 - jewelReq
end
function divase()
  local jewelCount = Tracker:ProviderCountForCode("goldense")
  local jewelReq = Tracker:ProviderCountForCode("op_reqgjewel")
  return jewelCount + 1 - jewelReq
end
function divasw()
  local jewelCount = Tracker:ProviderCountForCode("goldensw")
  local jewelReq = Tracker:ProviderCountForCode("op_reqgjewel")
  return jewelCount + 1 - jewelReq
end
function divanw()
  local jewelCount = Tracker:ProviderCountForCode("goldennw")
  local jewelReq = Tracker:ProviderCountForCode("op_reqgjewel")
  return jewelCount + 1 - jewelReq
end

function keyzerptp()
  if has("keyzerptp") then
    return 1
  else
    if has("op_doors_2") then
      return 0
    else
      return 1
    end
  end
end
function keyzerwf()
  if has("keyzerwf") then
    return 1
  else
    if has("op_doors_2") then
      return 0
    else
      return 1
    end
  end
end
function keyzerml()
  if has("keyzerml") then
    return 1
  else
    if has("op_doors_2") then
      return 0
    else
      return 1
    end
  end
end
function keyzermj()
  if has("keyzermj") then
    return 1
  else
    if has("op_doors_2") then
      return 0
    else
      return 1
    end
  end
end
function keyzercf()
  if has("keyzercf") then
    return 1
  else
    if has("op_doors_2") then
      return 0
    else
      return 1
    end
  end
end
function keyzertl()
  if has("keyzertl") then
    return 1
  else
    if has("op_doors_2") then
      return 0
    else
      return 1
    end
  end
end
function keyzerbf()
  if has("keyzerbf") then
    return 1
  else
    if has("op_doors_2") then
      return 0
    else
      return 1
    end
  end
end
function keyzerpz()
  if has("keyzerpz") then
    return 1
  else
    if has("op_doors_2") then
      return 0
    else
      return 1
    end
  end
end
function keyzertbt()
  if has("keyzertbt") then
    return 1
  else
    if has("op_doors_2") then
      return 0
    else
      return 1
    end
  end
end
function keyzerbb()
  if has("keyzerbb") then
    return 1
  else
    if has("op_doors_2") then
      return 0
    else
      return 1
    end
  end
end
function keyzerdw()
  if has("keyzerdw") then
    return 1
  else
    if has("op_doors_2") then
      return 0
    else
      return 1
    end
  end
end
function keyzerdr()
  if has("keyzerdr") then
    return 1
  else
    if has("op_doors_2") then
      return 0
    else
      return 1
    end
  end
end
function keyzercmv()
  if has("keyzercmv") then
    return 1
  else
    if has("op_doors_2") then
      return 0
    else
      return 1
    end
  end
end
function keyzeran()
  if has("keyzeran") then
    return 1
  else
    if has("op_doors_2") then
      return 0
    else
      return 1
    end
  end
end
function keyzerfc()
  if has("keyzerfc") then
    return 1
  else
    if has("op_doors_2") then
      return 0
    else
      return 1
    end
  end
end
function keyzerhh()
  if has("keyzerhh") then
    return 1
  else
    if has("op_doors_2") then
      return 0
    else
      return 1
    end
  end
end
function keyzergp()
  if has("keyzergp") then
    return 1
  else
    if has("op_doors_1") then
      return 0
    else
      return 1
    end
  end
end