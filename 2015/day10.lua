input = io.read()
t = {}
for i = 1, #input do
    table.insert(t, tonumber(input:sub(i, i)))
end
for i = 1, 50 do
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
    if i == 40 then --part I
        print(#t)
    end
end
--part II
print(#t)
