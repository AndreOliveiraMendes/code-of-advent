input = "11011110011011101"
function xnor1(x1, x2)
    return 1&(~(x1 ~ x2))
end
function f(a, n)
    local joiner = {}
    local m
    for i = 1, n/(#input+1) do
        if not m or i <= m then
            joiner[i] = 0
            if not m then m = 2 end
        else
            joiner[i] = 1-joiner[2*m - i]
            if 2*m <= i + 1 then
                m = 2*m
            end
        end
    end
    local ta, tb = {}, {}
    for i = 1, #a do
        ta[i] = tonumber(a:sub(i, i))
    end
    for i = 1, #a do
        tb[i] = 1 - ta[#a - i + 1]
    end
    local k = 0
    while true do
        if n%(2^(k + 1)) == 0 then
            k = k + 1
        else
            break
        end
    end
    local t = {}
    local JI = 1
    for i = 1, k do
        if i == 1 then
            for j = 1, n, 2 do
                local p = (j - 1)%(#ta + #tb + 2) + 1
                if p < #ta then
                    table.insert(t, xnor1(ta[p], ta[p + 1]))
                elseif p == #ta then
                    table.insert(t, xnor1(ta[p], joiner[JI]))
                    JI = JI + 1
                elseif p == #ta + 1 then
                    table.insert(t, xnor1(joiner[JI], tb[1]))
                    JI = JI + 1
                elseif p < #ta + #tb + 1 then
                    table.insert(t, xnor1(tb[p - #ta - 1], tb[p + 1 - #ta - 1]))
                elseif p == #ta + #tb + 1 then
                    table.insert(t, xnor1(tb[p - #ta - 1], joiner[JI]))
                    JI = JI + 1
                elseif p == #ta + #tb + 2 then
                    table.insert(t, xnor1(joiner[JI], ta[1]))
                    JI = JI + 1
                end
            end
        else
            local a = {}
            for j = 1, #t, 2 do
                table.insert(a, xnor1(t[j], t[j +1]))
            end
            t = a
        end
    end
    return table.concat(t)
end
output = f(input, 272)
print("checksum for a disk of lengt 272:\n" .. output)
output = f(input, 35651584)
print("checksum for a disk of lengt 35651584:\n" .. output)
