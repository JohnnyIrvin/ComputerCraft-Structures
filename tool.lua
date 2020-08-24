local sideEnum = {
    left=1,
    right=2
}

-- Attempts an equip of the specified item, on the specified side.
-- If the name of the item doesn't have a prefix add 'minecraft:'
-- Side is one of the sideEnum options.
-- @param name The name of the block. Example: 'minecraft:stone' or 'stone'
-- @return True if equip succesful, false otherwise.
function equip(name, side)
    name = blockPrefix(name)

    if not name then
        if side == sideEnum.left then
            return turtle.equipLeft()
        elseif side == sideEnum.right then
            return turtle.equipRight()
        end
    end
    
    item = findItem(name)

    if not item then
        return false
    end

    turtle.select(item.slot)
    if side == sideEnum.left then
        return turtle.equipLeft()
    elseif side == sideEnum.right then
        return turtle.equipRight()
    end

    return false
end

-- Attempts an equip of the specified item on the left.
-- If the name of the item doesn't have a prefix add 'minecraft:'
-- @param name The name of the block. Example: 'minecraft:stone' or 'stone'
-- @return True if equip succesful, false otherwise.
function equipLeft(name)
    return equip(name, sideEnum.left)
end

-- Attempts an equip of the specified item on the right.
-- If the name of the item doesn't have a prefix add 'minecraft:'
-- @param name The name of the block. Example: 'minecraft:stone' or 'stone'
-- @return True if equip succesful, false otherwise.
function equipRight(name)
    return equip(name, sideEnum.right)
end
