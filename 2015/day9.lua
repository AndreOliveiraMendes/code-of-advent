input = [[Tristram to AlphaCentauri = 34
Tristram to Snowdin = 100
Tristram to Tambi = 63
Tristram to Faerun = 108
Tristram to Norrath = 111
Tristram to Straylight = 89
Tristram to Arbre = 132
AlphaCentauri to Snowdin = 4
AlphaCentauri to Tambi = 79
AlphaCentauri to Faerun = 44
AlphaCentauri to Norrath = 147
AlphaCentauri to Straylight = 133
AlphaCentauri to Arbre = 74
Snowdin to Tambi = 105
Snowdin to Faerun = 95
Snowdin to Norrath = 48
Snowdin to Straylight = 88
Snowdin to Arbre = 7
Tambi to Faerun = 68
Tambi to Norrath = 134
Tambi to Straylight = 107
Tambi to Arbre = 40
Faerun to Norrath = 11
Faerun to Straylight = 66
Faerun to Arbre = 144
Norrath to Straylight = 115
Norrath to Arbre = 135
Straylight to Arbre = 127]]
loc = {}
for word in string.gmatch(input, "%a+") do
    if word ~= "to" then
        local continue = false
        for i, s in pairs(loc) do
            if s == word then continue = true end
        end
        if not continue then
            table.insert(loc, word)
        end
    end
end
dist = {}
for line in string.gmatch(input, "%C+") do
    local t = {}
    for word in string.gmatch(line, "%a+") do
        if word ~= "to" then
            table.insert(t, word)
        end
    end
    local loc1, loc2 = t[1], t[2]
    if not dist[loc1] then dist[loc1] = {} end
    if not dist[loc2] then dist[loc2] = {} end
    dist[loc1][loc2], dist[loc2][loc1] = tonumber(string.match(line, "%d+")), tonumber(string.match(line, "%d+"))
end
function getmind(loc, distl, used)
    local min, max
    if #loc ~= 0 then
        for i, s in ipairs(loc) do
            local aux = {}
            for j, q in pairs(loc) do
                if q ~= s then table.insert(aux, q) end
            end
            table.insert(used, s)
            local dist, distaux = getmind(aux, dist, used)
            if not min or dist < min then min = dist end
            if not distaux then
                if not max or dist > max then max = dist end
            else
                if not max or distaux > max then max = distaux end
            end
            table.remove(used, #used)
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
print("the minimal distance is " .. min)
--part II
print("the maxime distance is " .. max)
--251, 314, 867, 898
