--https://www.youtube.com/watch?v=uCsD3ZGzMgE
input = 3005290
function f(x)
    local n = 2^(math.floor(math.log(x, 2)))
    local m = x - n
    return 2*m + 1
end
print("the answer is " .. f(input))
