map = {}
for line in io.lines() do
    local p1, p2 = line:sub(1, line:find(")") - 1), line:sub(line:find(")") + 1)
    map[p1] = map[p1] or {}
    map[p2] = map[p2] or {}
    map[p2].orbit = map[p1]
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
