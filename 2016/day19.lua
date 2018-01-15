--https://www.youtube.com/watch?v=uCsD3ZGzMgE
--https://en.wikipedia.org/wiki/Josephus_problem
input = 3005290
function f(x)
    local n = 2^(math.floor(math.log(x, 2)))
    local m = x - n
    return 2*m + 1
end
print("the answer is " .. f(input))
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
        print(i, sim1(i), f(i))
    end
--]]
