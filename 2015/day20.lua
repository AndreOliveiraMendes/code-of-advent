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
input = tonumber(io.read())
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
