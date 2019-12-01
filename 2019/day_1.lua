function get_fuel_1(n)
    return n//3 - 2
end
function get_fuel_2(n)
    local res = 0
    while n > 0 do
        n = n//3 - 2
        res = res + math.max(0, n)
    end
    return res
end
fuel1, fuel2 = 0, 0
while true do
    local a = io.read()
    if not a then break end
    local n = tonumber(a)
    local lfuel1, lfuel2 = get_fuel_1(n), get_fuel_2(n)
    fuel1, fuel2 = fuel1 + lfuel1, fuel2 + lfuel2
end
print("total fuel at first is " .. fuel1)
print("total fuel now is " .. fuel2)
