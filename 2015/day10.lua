input = {1, 3, 2, 1, 1, 3, 1, 1, 1, 2}
t = {1, 3, 2, 1, 1, 3, 1, 1, 1, 2}
for i = 1, 40 do
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
end
--part I
print("the lenght of output is " .. #table.concat(t))
