--https://www.youtube.com/watch?v=uCsD3ZGzMgE
--https://en.wikipedia.org/wiki/Josephus_problem
input = 3005290
function f1(x)
    local n = 2^(math.floor(math.log(x, 2)))
    local m = x - n
    return 2*m + 1
end
function f2(x)
    return x + math.max(-3^(math.floor(math.log(x, 3))), x - 3^(math.ceil(math.log(x, 3))))
end
print("the answer for part 1 is " .. f1(input))
print("the answer for part 2 is " .. f2(input))
--[[
    function sim1(n)
        local t = {}
        for i = 1, n do
            table.insert(t, i)
        end
        local i = 1
        while #t > 1 do
            if i == #t then
                table.remove(t, 1)
                i = 1
            else
                table.remove(t, i%(#t) + 1)
                i = i%(#t) + 1
            end
        end
        return t[1]
    end
    for i = 1, 10 do
        print(i, sim1(i), f1(i))
    end
    function sim2(n)
        local t = {}
        for i = 1, n do
            table.insert(t, i)
        end
        local i = 1
        while #t > 1 do
            if i > #t - math.floor(#t/2) then
                table.remove(t, (i + math.floor(#t/2) - 1)%(#t) + 1)
                i = i - 1
            else
                table.remove(t, (i + math.floor(#t/2) - 1)%(#t) + 1)
            end
            i = i%(#t) + 1
        end
        return t[1]
    end
    for i = 1, 100 do
        print(i, sim2(i), f2(i))
    end
--]]
