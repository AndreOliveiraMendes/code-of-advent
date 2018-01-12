input = "11011110011011101"
size = 272
output = input
function f(a)
    local b = ""
    for i = 1, #a do
        local d = tonumber(a:sub(i, i))
        b = tostring(1 - d) .. b
    end
    return a .. 0 .. b
end
function g(d1, d2)
    d1, d2 = tonumber(d1), tonumber(d2)
    if d1 == d2 then
        return 1
    else
        return 0
    end
end
while #output < size do
    output = f(output)
end
if #output > size then
    output = output:sub(1, size)
end
print("input is " .. input)
print("output after process " .. output)
repeat
    if not chks then
        chks = output:gsub("(%d)(%d)", g)
    else
        chks = chks:gsub("(%d)(%d)", g)
    end
until (#chks% 2 == 1)
print("produces checksum of " .. chks)
