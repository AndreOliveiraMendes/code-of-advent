input = "L4, L1, R4, R1, R1, L3, R5, L5, L2, L3, R2, R1, L4, R5, R4, L2, R1, R3, L5, R1, L3, L2, R5, L4, L5, R1, R2, L1, R5, L3, R2, R2, L1, R5, R2, L1, L1, R2, L1, R1, L2, L2, R4, R3, R2, L3, L188, L3, R2, R54, R1, R1, L2, L4, L3, L2, R3, L1, L1, R3, R5, L1, R5, L1, L1, R2, R4, R4, L5, L4, L1, R2, R4, R5, L2, L3, R5, L5, R1, R5, L2, R4, L2, L1, R4, R3, R4, L4, R3, L4, R78, R2, L3, R188, R2, R3, L2, R2, R3, R1, R5, R1, L1, L1, R4, R2, R1, R5, L1, R4, L4, R2, R5, L2, L5, R4, L3, L2, R1, R1, L5, L4, R1, L5, L1, L5, L1, L4, L3, L5, R4, R5, R2, L5, R5, R5, R4, R2, L1, L2, R3, R5, R5, R5, L2, L1, R4, R3, R1, L4, L2, L3, R2, L3, L5, L2, L2, L1, L2, R5, L2, L2, L3, L1, R1, L4, R2, L4, R3, R5, R3, R4, R1, R5, L3, L5, L5, L3, L2, L1, R3, L4, R3, R2, L1, R3, R1, L2, R4, L3, L3, L3, L1, L2"
moves = {}
for word in string.gmatch(input, "%w+") do
    table.insert(moves, {word:sub(1, 1), tonumber(word:sub(2))})
end
dir = "up"
x, y = 0, 0
function rotate(dir, rot)
    local adir = {"left", "up", "right", "down"}
    local ind
    for i = 1, #adir do
        if adir[i] == dir then
            ind = i
            break
        end
    end
    if rot == "L" then
        ind = ind - 1
        if ind < 1 then ind = 4 end
    elseif rot == "R" then
        ind = ind + 1
        if ind > 4 then ind = 1 end
    end
    return adir[ind]
end
function move(x, y, dir, dl)
    if dir == "up" then
        x, y = x, y + dl
    elseif dir == "right" then
        x, y = x + dl, y
    elseif dir == "down" then
        x, y = x, y - dl
    elseif dir == "left" then
        x, y = x - dl, y
    end
    return x, y
end
for i, s in pairs(moves) do
    local rot, amount = s[1], s[2]
    dir = rotate(dir, rot)
    x, y = move(x, y, dir, amount)
end
function d2(x, y)
    return math.abs(x) + math.abs(y)
end
print("stoped " .. d2(x, y) .. " blocks away")
