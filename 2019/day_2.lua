t = {}
input = {}
for n in string.gmatch(io.read(), "%d+") do
    n = tonumber(n)
    table.insert(t, n)
    table.insert(input, n)
end
function read(t, pos)
    local opcode = t[pos]
    if opcode == 99 then return false end
    local i1, i2 = t[pos + 1] + 1, t[pos + 2] + 1
    local v1, v2 = t[i1], t[i2]
    if opcode == 1 or opcode == 2 then
        local i3 = t[pos + 3] + 1
        local v3 = (opcode == 1) and (v1 + v2) or (v1 * v2)
        t[i3] = v3
    end
    return true
end
function output(non, verb, t)
    local pos = 0
    t[2] = non
    t[3] = verb
    while pos < #t do
        if read(t, pos + 1) then
            pos = pos + 4
        else
            break
        end
    end
    return t[1]
end
function reset(t1, t2)
    for i, v in pairs(t2) do
        t1[i] = v
    end
end
--part I
print(output(12, 2, t))
reset(t, input)
for i = 0, 99 do
    for j = 0, 99 do
        if output(i, j, t) == 19690720 then
            non, verb = i, j
            goto endloop
        end
        reset(t, input)
    end
end
::endloop::
--part II
print(100*non + verb)
