input = {1, 3, 2, 1, 1, 3, 1, 1, 1, 2}
t = input
print("(" .. 0 .. ")", #t)
for i = 1, 50 do
    ti = os.time()
    local ta = {}
    local x = 1
    for j = 1, #t do
        if not ta[x + 1] then
            ta[x], ta[x + 1] = 1, t[j]
        elseif ta[x + 1] == t[j] then
            ta[x] = ta[x] + 1
        else
            x = x + 2
            ta[x], ta[x + 1] = 1, t[j]
        end
    end
    t = ta
    to = os.time()
    print("(" .. i .. ")", #t, to - ti .. "s")
end
--[[
    part I
    492982
    1s on step 40
    5s on total
    part II
    6989950
    14s on step 50
    63s on total
--]]
