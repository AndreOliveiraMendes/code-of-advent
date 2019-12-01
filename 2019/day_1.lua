fuel = 0
while true do
    local a = io.read()
    if not a then break end
    local n = tonumber(a)
    local lfuel = n//3 - 2
    fuel = fuel + lfuel
end
print("total fuel is " .. fuel)
