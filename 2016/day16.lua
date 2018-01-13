input = "11011110011011101"
size = 272
output = input
function f(a, n)
    local k = #a
    local max = math.ceil(math.log(n + 1, 2) - math.log(k + 1, 2))
    for i = 1, max do
        local j = #a
        k = j + 1
        a = a .. "0"
        while j > 0 do
            k = k + 1
            if k > n then goto skip end
            a = a .. tostring(1 - tonumber(a:sub(j, j)))
            j = j - 1
        end
    end
    ::skip::
    return a
end
function g(d1, d2)
    d1, d2 = tonumber(d1), tonumber(d2)
    if d1 == d2 then
        return 1
    else
        return 0
    end
end
output = f(input, size)
print("input is " .. input)
print("output after process " .. output)
repeat
    if not chks then
        chks = output:gsub("(%d)(%d)", g)
    else
        chks = chks:gsub("(%d)(%d)", g)
    end
until (#chks% 2 == 1)
print("produces checksum (272) of " .. chks)
chks = nil
size = 35651584
output = f(input, size)
print("input is " .. input)
print("output after process " .. output)
repeat
    if not chks then
        chks = output:gsub("(%d)(%d)", g)
    else
        chks = chks:gsub("(%d)(%d)", g)
    end
until (#chks% 2 == 1)
print("produces checksum (35651584) of " .. chks)
