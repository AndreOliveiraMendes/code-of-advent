input = 29000000
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
function f(n) return 10*d(n) end
x = 1
while f(x) < input do
    x = x + 1
end
print("the lowest house number to get as that many gift is " .. x)
