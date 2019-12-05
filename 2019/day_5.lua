t = {}
input = {}
for n in string.gmatch(io.read(), "-?%d+") do
    n = tonumber(n)
    table.insert(t, n)
    table.insert(input, n)
end
function read(t, pos, inp, out)
    local op = t[pos]
    local opcode = op%100
    if opcode == 99 then return false end
    if opcode == 1 or opcode == 2 then
        local v1, v2, v3
        if math.floor(op/(10^2))%10 == 0 then
            local i1 = t[pos + 1] + 1
            v1 = t[i1]
        else
            v1 = t[pos + 1]
        end
        if math.floor(op/(10^3))%10 == 0 then
            local i2 = t[pos + 2] + 1
            v2 = t[i2]
        else
            v2 = t[pos + 2]
        end
        v3 = (opcode == 1) and (v1 + v2) or (v1 * v2)
        local i3 = t[pos + 3] + 1
        t[i3] = v3
        return true, 4
    elseif opcode == 3 then
        local i1 = t[pos + 1] + 1
        t[i1] = inp
        return true, 2
    elseif opcode == 4 then
        local i1 = t[pos + 1] + 1
        table.insert(out, t[i1])
        return true, 2
    end
end
function output(t)
    local pos = 0
    local out = {}
    while pos < #t do
        local succed, dpos = read(t, pos + 1, 1, out)
        if succed then
            pos = pos + dpos
        else
            break
        end
    end
    return out
end
--part I
out = output(t)
print("there " .. #out .. " messages ")
for _, msg in pairs(out) do
    print(msg)
end
