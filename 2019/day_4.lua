input = io.read()
min, max = tonumber(input:sub(1, input:find("-") - 1)), tonumber(input:sub(input:find("-") + 1))
function valid(n)
    local str = tostring(n)
    local prev
    local double, tdouble = false, false
    for i = 1, #str do
        local c = tonumber(str:sub(i, i))
        if prev and c < prev then
            return false
        end
        double = double or (prev and prev == c)
        prev = c
    end
    return double
end
function valid2(n)
    local str = tostring(n)
    local prev
    local group = {}
    local double = false
    for i = 1, #str do
        local c = tonumber(str:sub(i, i))
        if prev then
            if c < prev then return false end
            if double then
                if c == prev then
                    table.insert(group[#group], c)
                else
                    double = false
                end
            elseif c == prev then
                double = true
                table.insert(group, {})
                table.insert(group[#group], prev)
                table.insert(group[#group], c)
            end
        end
        prev = c
    end
    for _, g in pairs(group) do
        if #g == 2 then
            return true
        end
    end
    return false
end
function valid(n)
    local str = tostring(n)
    local prev
    local double = false
    for i = 1, #str do
        local c = tonumber(str:sub(i, i))
        if prev and c < prev then
            return false
        end
        double = double or (prev and prev == c)
        prev = c
    end
    return double
end
n, m = 0, 0
for i = min, max do
    if valid(i) then
        n = n + 1
    end
    if valid2(i) then
        m = m + 1
    end
end
--part I
print("number of valid " .. n)
--part II
print("number of valid now is " .. m)
