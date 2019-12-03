moves = {}
for word in string.gmatch(io.read(), "%w+") do
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
visit = {}
visit[0] = {[0] = 1}
for i, s in pairs(moves) do
    local rot, amount = s[1], s[2]
    dir = rotate(dir, rot)
    for j = 1, amount do
        x, y = move(x, y, dir, 1)
        if not visit[x] then visit[x] = {} end
        if not visit[x][y] then visit[x][y] = 1 else visit[x][y] = visit[x][y] + 1 end
        if not xl and not yl and visit[x][y] > 1 then
            xl, yl = x, y
        end
    end
end
function d2(x, y)
    return math.abs(x) + math.abs(y)
end
print("stoped " .. d2(x, y) .. " blocks away")
print("the first location you visited twice is " .. d2(xl, yl) .. " blocks away")
