map = {}
for line in io.lines() do
    local p1, p2 = line:sub(1, line:find(")") - 1), line:sub(line:find(")") + 1)
    map[p1] = map[p1] or {}
    map[p2] = map[p2] or {}
    map[p2].orbit = map[p1]
    map[p1].orbited = map[p1].orbited or {}
    table.insert(map[p1].orbited, map[p2])
end
function get_checksum(p)
    local pb = p.orbit
    if pb then
        return 1 + get_checksum(pb)
    else
        return 0
    end
end
sum = 0
for _, p in pairs(map) do
    sum = sum + get_checksum(p)
end
--part i
print("part i answer: " .. sum)
--part ii
function get_min_path(map, origin, destine)
    if origin == destine then
        return true, 0
    else
        if origin.visited then
            return false
        else
            local min
            origin.visited = true
            if origin.orbit then
                local found, dist = get_min_path(map, origin.orbit, destine)
                if found then
                    min = dist + 1
                end
            end
            if origin.orbited then
                for _, p in pairs(origin.orbited) do
                    local found, dist = get_min_path(map, p, destine)
                    if found and (not min or (dist + 1) < min) then
                        min = dist + 1
                    end
                end
            end
            origin.visited = nil
            if min then
                return true, min
            else
                return false
            end
        end
    end
end
--part II
found, dist = get_min_path(map, map.YOU.orbit, map.SAN.orbit)
if found then
    print("part ii answer: " .. dist)
else
    print("unknow error")
end
