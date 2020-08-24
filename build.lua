function PrintUsage()
    print("<program> <forward> <width> <block:optional>")
end

local tArgs = { ... }
local tNum = #tArgs

if tNum ~= 2 then
    PrintUsage()
    return
end

if not turtle then
    printError("Requires a Turtle")
    return
end

function run(length, width, block)
    block = block or "minecraft:stonebrick"
    for y=1, width do
        for x=1, length do
            print(x .. ", " .. y)
            inventory.place("minecraft:stonebrick")
            engine.move('forward')
        end
        if y % 2 ~= 0 then
            engine.turn("left")
            engine.move('forward')
            engine.turn("left")
        else
            engine.turn("right")
            engine.move('forward')
            engine.turn("right")
        end
    end
    if width % 2 ~= 0 then
        engine.move("forward", length)
        engine.turn("left", "left")
    end
end

block = nil
if tNum == 3 then
    block = tArgs[3]
end

run(tArgs[1], tArgs[2], block)