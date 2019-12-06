t = {}
input = {}
for n in string.gmatch(io.read(), "-?%d+") do
    n = tonumber(n)
    table.insert(t, n)
    table.insert(input, n)
end
function get_mode(op, bit)
    return math.floor(op/(10^bit))%10
end
function get_param(t, pos, param)
    return t[pos + param]
end
function get_value(t, op, pos, param)
    local mode, p = get_mode(op, param + 1), get_param(t, pos, param)
    if mode == 0 then
        return t[p + 1]
    elseif mode == 1 then
        return p
    else
        print("error, invalide mode:" .. mode)
        return 0
    end
end
function read(t, pos, inp, out)
    local op = t[pos]
    local opcode = op%100
    if opcode == 99 then
        return false
    elseif opcode == 1 or opcode == 2 then
        local v1, v2, v3, p3
        v1 = get_value(t, op, pos, 1)
        v2 = get_value(t, op, pos, 2)
        v3 = (opcode == 1) and (v1 + v2) or (v1 * v2)
        p3 = get_param(t, pos, 3)
        t[p3 + 1] = v3
        return true, 4
    elseif opcode == 3 then
        local p1
        p1 = get_param(t, pos, 1)
        t[p1 + 1] = inp
        return true, 2
    elseif opcode == 4 then
        local p1
        p1 = get_param(t, pos, 1)
        table.insert(out, t[p1 + 1])
        return true, 2
    elseif opcode == 5 or opcode == 6 then
        local v1
        v1 = get_value(t, op, pos, 1)
        if (opcode == 5 and v1 ~= 0) or (opcode == 6 and v1 == 0) then
            local v2 = get_value(t, op, pos, 2)
            return true, 1 + v2 - pos
        else
            return true, 3
        end
    elseif opcode == 7 or opcode == 8 then
        local v1, v2, v3
        v1 = get_value(t, op, pos, 1)
        v2 = get_value(t, op, pos, 2)
        p3 = get_param(t, pos, 3)
        if (opcode == 7 and v1 < v2) or (opcode == 8 and v1 == v2) then
            t[p3 + 1] = 1
        else
            t[p3 + 1] = 0
        end
        return true, 4
    else
        print("invalid opcode:" .. op)
        return false
    end
end
function output(t, input)
    local pos = 0
    local out = {}
    while pos >= 0 and pos < #t do
        local succed, dpos = read(t, pos + 1, input, out)
        if succed then
            pos = pos + dpos
        else
            break
        end
    end
    return out
end
function reset(t1, t2)
    for i, v in pairs(t2) do
        t1[i] = v
    end
end
--part I
out = output(t, 1)
print("part I answer:" .. out[#out])
--part II
reset(t, input)
out = output(t, 5)
print("part II answer:" .. out[#out])
print(out[#out])
