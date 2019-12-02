function table_nrinsert(t, v)
    for i, s in pairs(t) do
        if s == v then return false end
    end
    table.insert(t, v)
    return true
end
loc = {}
dist = {}
for line in io.lines() do
    local t = {}
    for word in string.gmatch(line, "%a+") do
        if word ~= "to" then
            table_nrinsert(loc, word)
            table.insert(t, word)
        end
    end
    local loc1, loc2 = t[1], t[2]
    dist[loc1] = dist[loc1] or {}
    dist[loc2] = dist[loc2] or {}
    dist[loc1][loc2], dist[loc2][loc1] = tonumber(string.match(line, "%d+")), tonumber(string.match(line, "%d+"))
end
function getmind(loc, distl, used)
    local min, max
    if #loc ~= 0 then
        for i, s in ipairs(loc) do
            table.remove(loc, i)
            table.insert(used, s)
            local dist, distaux = getmind(loc, dist, used)
            if not min or dist < min then min = dist end
            if not distaux then
                if not max or dist > max then max = dist end
            else
                if not max or distaux > max then max = distaux end
            end
            table.remove(used)
            table.insert(loc, i, s)
        end
    else
        local dist = 0
        for i = 1, #used - 1 do
            dist = dist + distl[used[i]][used[i + 1]]
        end
        return dist
    end
    return min, max
end
--part I
min, max = getmind(loc, dist, {})
print("the minimal distance is " .. tostring(min))
--part II
print("the maxime distance is " .. tostring(max))
