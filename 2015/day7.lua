inst = {}
inst2 = {}
function instruction_insert(inst, input)
    local t = {}
    for word in string.gmatch(input, "[0-z]+") do
        if word ~= ">" then
            if tonumber(word) then word = tonumber(word) end
            table.insert(t, word)
        end
    end
    table.insert(inst, t)
end
while true do
    local input = io.read()
    if not input then break end
    instruction_insert(inst, input)
    instruction_insert(inst2, input)
end
function b16lshift(x, n)
    return (x << n) & 0xffff
end
function b16not(x)
    return ~x & 0xffff
end
varlist = {}
function exe(list, n, v1, v2, v3, v4)
    if n == 2 then
        if type(v1) == "number" then
            list[v2] = v1
        else
            if not list[v1] then return false end
            if not list[v2] then
                list[v2] = list[v1]
            end
        end
        return true
    elseif n == 3 then
        if type(v2) == "number" then
            list[v3] = b16not(v2)
        else
            if not list[v2] then return false end
            list[v3] = b16not(list[v2])
        end
        return true
    else
        local i1, i2
        if type(v1) == "number" then
            i1 = v1
        else
            if not list[v1] then return false end
            i1 = list[v1]
        end
        if type(v3) == "number" then
            i2 = v3
        else
            if not list[v3] then return false end
            i2 = list[v3]
        end
        if v2 == "AND" then
            list[v4] = i1 & i2
        elseif v2 == "OR" then
            list[v4] = i1 | i2
        elseif v2 == "LSHIFT" then
            list[v4] = b16lshift(i1, i2)
        elseif v2 == "RSHIFT" then
            list[v4] = i1 >> i2
        else
            print("error: unexpected operator")
        end
        return true
    end
end
i = 1
repeat
    local s, suc = inst[i]
    if #s == 2 then
        suc = exe(varlist,2,table.unpack(s))
    elseif #s == 3 then
        suc = exe(varlist,3,table.unpack(s))
    elseif #s == 4 then
        suc = exe(varlist,4,table.unpack(s))
    else
        print("error: unexpected data")
    end
    if suc then
        table.remove(inst, i)
        i = 1
    else
        i = i + 1
    end
until (#inst == 0)
--part I
print("after interaction, the signal on wire a is " .. (varlist.a and varlist.a or 0))
varlist.b = varlist.a
for i, s in pairs(varlist) do
    if i ~= "b" then varlist[i] = nil end
end
print("overwriting line b")
i = 1
repeat
    local s, suc = inst2[i]
    if #s == 2 then
        suc = exe(varlist,2,table.unpack(s))
    elseif #s == 3 then
        suc = exe(varlist,3,table.unpack(s))
    elseif #s == 4 then
        suc = exe(varlist,4,table.unpack(s))
    else
        print("error: unexpected data")
    end
    if suc then
        table.remove(inst2, i)
        i = 1
    else
        i = i + 1
    end
until (#inst2 == 0)
--part II
print("after interaction, the signal on wire a is " .. (varlist.a and varlist.a or 0))
