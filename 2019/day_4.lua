min, max = 307237, 769058
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
n = 0
for i = min, max do
    if valid(i) then
        n = n + 1
    end
end
print("number of valid " .. n)
