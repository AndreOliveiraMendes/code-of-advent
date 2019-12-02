pos = 0
t = {}
for n in string.gmatch(io.read(), "%d+") do
    table.insert(t, tonumber(n))
end
function read(t, pos)
    local opcode = t[pos]
    if opcode == 99 then return false end
    local i1, i2, i3 = t[pos + 1] + 1, t[pos + 2] + 1
    local v1, v2 = t[i1], t[i2]
    if opcode == 1 or opcode == 2 then
        local i3 = t[pos + 3] + 1
        local v3 = (opcode == 1) and (v1 + v2) or (v1 * v2)
        t[i3] = v3
    end
    return true
end
t[2] = 12
t[3] = 2
while pos < #t do
    if read(t, pos + 1) then
        pos = pos + 4
    else
        break
    end
end
--part I
print(t[1])
