players = 10
ml = {}
fm = 1618
score = {}
for p = 1, players do score[p] = 0 end
function tc(t, i)
    local str = ""
    for j = 1, #t do
        if j > 1 then str = str .. "-" end
        if j == i then
            str = str .. "(" .. t[j] .. ")"
        else
            str = str .. t[j]
        end
    end
    return str
end
function inc(i, rot, n)
    rot = rot%n
    i = i - rot
    if i < 1 then i = i + n end
    if i > n then i = i - n end
    return i
end
for m = 0, fm do
    if m == 0 then
        table.insert(ml, m)
        i = 1
        p = 1
    else
        if m%23 == 0 then
            score[p] = score[p] + m
            i = inc(i, 7, #ml)
            score[p] = score[p] + ml[i]
            table.remove(ml, i)
        else
            i = inc(i, m - 1, #ml)
            table.insert(ml, i + 1, m)
            i = i + 1
        end
        p = inc(p, -1, players)
    end
    --print(tc(ml, i))
end
for _, s in pairs(score) do
    if not max or s > max then
        max = s
    end
end
--print("max score is " .. max)
