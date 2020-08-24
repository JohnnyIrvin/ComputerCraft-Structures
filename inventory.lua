local scanned = false
local inventory = { }

local function blockPrefix(name)
    if not string.match(name, '.+:') then
        name = 'minecraft:' .. name
    end
    
    return name
end

local function rangeCheck(slot)
    if slot > 16 then
        slot = 16
    end
    if slot < 1 then
        slot = 1
    end
    return slot
end

local function updateSlot(slot)
    turtle.select(slot)
    details = turtle.getItemDetail()
    if details then
        inventory[slot] = {
            name=details.name,
            count=details.count
        }
    else
        inventory[slot] = {
            name=nil,
            count=0
        }
    end

    return inventory[slot]
end

local function scanInventory()
    for i=1,16 do
        updateSlot(i)
    end
    scanned = true

    return inventory
end

local function cacheInventory()
    if not scanned then
        scanInventory()
    end
end 

local function getSlot(slot)
    slot = rangeCheck(slot)
    return updateSlot(slot)
end

local function getInventory()
    cacheInventory()

    return inventory
end

-- Returns the inventory, unless slot is specified.
-- If a slot is specified returns the specified slot.
-- If slot is less than 1, set to 1.
-- If slot is greater than 16, set to 16.
-- @param slot Optional parameter for inventory slot
-- @return Inventory table, or item table.
function get(slot)
    if slot then
        return getSlot(slot)
    end

    return getInventory()
end

function dropItem(slot, num)
    slot = rangeCheck(slot)
    turtle.select(slot)
    turtle.drop(num)
    return updateSlot(slot)
end

-- Returns true if the named item is in the inventory.
-- If a slot is specified returns the specified slot.
-- @param slot Optional parameter for inventory slot
-- @return True if inventory contains item, else false
function hasItem(name)
    name = blockPrefix(name)

    cacheInventory()
    item = findItem(name)

    if item.name then
        return true
    end

    return false
end

-- Finds an item within the inventory of the turtle.
-- If the name of the item doesn't have a prefix add 'minecraft:'
-- If the item doesn't exist in the inventory, return nil.
-- @param name The name of the block. Example: 'minecraft:stone' or 'stone'
-- @return Item table if found, else nil
function findItem(name)
    name = blockPrefix(name)

    cacheInventory()
    for key, value in pairs(inventory) do
        if value.name == name then
            return {
                slot=key,
                value=value
            }
        end
    end

    return nil
end

-- Selects an item in inventory by name.
-- Caveat, selects first instance of item stacks.
-- If the name of the item doesn't have a prefix add 'minecraft:'
-- @param name The name of the block. Example: 'minecraft:stone' or 'stone'
-- @return True if selected, else false
function selectItem(name)
    cacheInventory()
    name = blockPrefix(name)

    for key, value in pairs(inventory) do
        turtle.select(key)
        return true
    end

    return false
end
