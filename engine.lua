local fuel = 0
local initial = false

local moveHandlers = {
    ["fd"] = turtle.forward,
    ["forward"] = turtle.forward,
    ["forwards"] = turtle.forward,
    ["bk"] = turtle.back,
    ["back"] = turtle.back,
    ["up"] = turtle.up,
    ["dn"] = turtle.down,
    ["down"] = turtle.down,
    ["lt"] = turtle.turnLeft,
    ["left"] = turtle.turnLeft,
    ["rt"] = turtle.turnRight,
    ["right"] = turtle.turnRight,
}

local turnHandlers = {
    ["lt"] = turtle.turnLeft,
    ["left"] = turtle.turnLeft,
    ["rt"] = turtle.turnRight,
    ["right"] = turtle.turnRight,
}

function getFuel()
    if not initial then
        fuel = turtle.getFuelLevel()
    end
    
    return fuel
end

function needsFuel()
    if fuel < 1000 then
        return true
    end

    return false
end

function refuel()
    coal = inventory.findItem('minecraft:coal')

    if coal then
        turtle.select(coal.slot)
        turtle.refuel(1)
        fuel = turtle.getFuelLevel()
        return true
    end

    return false
end

function move(...)
    local tArgs = { ... }
    local nArg = 1
    while nArg <= #tArgs do
        local sDirection = tArgs[nArg]
        local nDistance = 1
        if nArg < #tArgs then
            local num = tonumber( tArgs[nArg + 1] )
            if num then
                nDistance = num
                nArg = nArg + 1
            end
        end
        nArg = nArg + 1

        local fnHandler = moveHandlers[string.lower(sDirection)]
        if fnHandler then
            while nDistance > 0 do
                if needsFuel() then
                    refuel()
                end
                if fnHandler() then
                    nDistance = nDistance - 1
                elseif turtle.getFuelLevel() == 0 then
                    print( "Out of fuel" )
                    return
                end
            end
        else
            print( "No such direction: "..sDirection )
            print( "Try: forward, back, up, down" )
            return
        end

    end
end

function turn(...)
    local tArgs = { ... }
    local nArg = 1
    while nArg <= #tArgs do
        local sDirection = tArgs[nArg]
        local nDistance = 1
        if nArg < #tArgs then
            local num = tonumber( tArgs[nArg + 1] )
            if num then
                nDistance = num
                nArg = nArg + 1
            end
        end
        nArg = nArg + 1
    
        local fnHandler = turnHandlers[string.lower(sDirection)]
        if fnHandler then
            for n=1,nDistance do
                fnHandler( nArg )
            end
        else
            print( "No such direction: "..sDirection )
            print( "Try: left, right" )
            return
        end
        
    end
end
