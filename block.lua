os.loadAPI('inventory.lua')

local directionEnum = {
    left=placeLeft,
    right=placeForward,
    back=placeBack,
    forward=placeForward,
    up=placeUp,
    down=placeDown
}

-- Places a specified block in the specified direction.
-- Text is optional and intended for the wording on signs.
-- @param name The name of the block. Example: 'minecraft:stone' or 'stone'
-- @param direction The direction, from directionEnum, to place the block.
-- @param text Optional parameter for use with signs.
-- @returns True if successful, false if not.
function place(name, direction, text)
    local action = directionEnum[direction]

    if not action then
        return false
    end

    return action(name, text)
end

local function placeWrapper(fnc, name, text)
    local result = selectItem(name)
    if not result then
        return false
    end
    result = fnc(name, text)
    inventory.updateSlot(turtle.getSelectedSlot())
    return result
end

-- Places a specified block beneath the turtle.
-- Text is optional and intended for the wording on signs.
-- @param name The name of the block. Example: 'minecraft:stone' or 'stone'
-- @param text Optional parameter for use with signs.
-- @returns True if successful, false if not.
function placeDown(name, text)
    local function action()
        result = turtle.placeDown(text)
        return result
    end
    return placeWrapper(action, name, text)
end

-- Places a specified block above the turtle.
-- Text is optional and intended for the wording on signs.
-- @param name The name of the block. Example: 'minecraft:stone' or 'stone'
-- @param text Optional parameter for use with signs.
-- @returns True if successful, false if not.
function placeUp(name, text)
    local function action()
        result = turtle.placeUp(text)
        return result
    end
    return placeWrapper(action, name, text)
end

-- Places a specified block left of the turtle.
-- Text is optional and intended for the wording on signs.
-- @param name The name of the block. Example: 'minecraft:stone' or 'stone'
-- @param text Optional parameter for use with signs.
-- @returns True if successful, false if not.
function placeLeft(name, text)
    local function action()
        turtle.turnLeft()
        result = turtle.place(text)
        turtle.turnRight()
        return result
    end
    return placeWrapper(action, name, text)
end

-- Places a specified block right of the turtle.
-- Text is optional and intended for the wording on signs.
-- @param name The name of the block. Example: 'minecraft:stone' or 'stone'
-- @param text Optional parameter for use with signs.
-- @returns True if successful, false if not.
function placeRight(name, text)
    local function action()
        turtle.turnRight()
        result = turtle.place(text)
        turtle.turnLeft()
        return result
    end
    return placeWrapper(action, name, text)
end

-- Places a specified block in front of the turtle.
-- Text is optional and intended for the wording on signs.
-- @param name The name of the block. Example: 'minecraft:stone' or 'stone'
-- @param text Optional parameter for use with signs.
-- @returns True if successful, false if not.
function placeForward(name, text)
    local function action()
        result = turtle.place(text)
        return result
    end
    return placeWrapper(action, name, text)
end

-- Places a specified block behind the turtle.
-- Text is optional and intended for the wording on signs.
-- @param name The name of the block. Example: 'minecraft:stone' or 'stone'
-- @param text Optional parameter for use with signs.
-- @returns True if successful, false if not.
function placeBack(name, text)
    local function action()
        turtle.turnLeft()
        turtle.turnLeft()
        result = turtle.place(text)
        turtle.turnRight()
        turtle.turnRight()
        return result
    end
    return placeWrapper(action, name, text)
end
