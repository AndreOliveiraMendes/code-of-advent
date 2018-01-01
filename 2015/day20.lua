--[[
    function d(n)
        local sum = 0
        for i = 1, n do
            if n % i == 0 then
                sum = sum + i
            end
        end
        return sum
    end
    function dm(n)
        local sum = 0
        for i = 1, n do
            if n <= 50*i and n%i == 0 then
                sum = sum + i
            end
        end
        return sum
    end
    function d(n)
        local sum = 0
        for i = 1, math.sqrt(n) do
            if n % i == 0 then
                if i == math.sqrt(n) then
                    sum = sum + i
                else
                    sum = sum + i + n/i
                end
            end
        end
        return sum
    end
    function dm(n)
        local sum = 0
        for i = n, math.sqrt(n), -1 do
            if n <= 50*i and n%i == 0 then
                if i == math.sqrt(n) then
                    sum = sum + i
                else
                    sum = sum + i
                    local j = n/i
                    if n <= 5*j then
                        sum = sum + j
                    end
                end
            end
        end
        return math.floor(sum)
    end
--]]
function d(n)
    local sum1, sum2 = 0, 0
    for i = 1, math.sqrt(n) do
        if n % i == 0 then
            if i == math.sqrt(n) then
                sum1 = sum1 + i
                if n <= 50*i then
                    sum2 = sum2 + i
                end
            else
                local j = n/i
                sum1 = sum1 + i + j
                if n <= 50*i then
                    sum2 = sum2 + i
                end
                if n <= 50*j then
                    sum2 = sum2 + j
                end
            end
        end
    end
    return sum1, sum2
end
input = 29000000
dm = {}
function f1(n)
    if not dm[n] then
        local d1, d2 = d(n)
        table.insert(dm, {d1, d2})
        return 10*d1
    else
        return 10*dm[n][1]
    end
end
function f2(n)
    if not dm[n] then
        local d1, d2 = d(n)
        table.insert(dm, {d1, d2})
        return 11*d2
    else
        return 11*dm[n][2]
    end
end
x = 1
while not x1 or not x2 do
    if not x1 and f1(x) >= input then x1 = x end
    if not x2 and f2(x) >= input then x2 = x end
    x = x + 1
end
--part I
print("the lowest house number to get as that many gift is " .. x1)
--part II
print("the lowest house number to get as that many gift after new elves plan is " .. x2)
