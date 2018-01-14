input = "11011110011011101"
inputinv = ""
for i = #input, 1, -1 do
    inputinv = inputinv .. tostring(1 - tonumber(input:sub(i, i)))
end
size = 272
size2 = 35651584
joiner = {}
for i = 1, size2/(#input+1) do
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
function f(a, b, n, s)
    local fstr = ""
    local t = {}
    local st = "a"
    local i = 1
    while #fstr <= n do
        if st == "a" then
            fstr = fstr .. a
            st = "cb"
        elseif st == "b" then
            fstr = fstr .. b
            st = "ca"
        else
            fstr = fstr .. s[i]
            i = i + 1
            st = st:sub(2, 2)
        end
    end
    return fstr:sub(1, n)
end
function g(d1, d2)
    d1, d2 = tonumber(d1), tonumber(d2)
    if d1 == d2 then
        return 1
    else
        return 0
    end
end
output = f(input, inputinv, size, joiner)
print("input is:\n" .. input)
print("output after process:\n" .. output)
repeat
    if not chks then
        chks = output:gsub("(%d)(%d)", g)
    else
        chks = chks:gsub("(%d)(%d)", g)
    end
until (#chks% 2 == 1)
print("produces checksum (272) of " .. chks)
chks = nil
output = f(input, inputinv, size2, joiner)
print("input is:\n" .. input)
print("output after process:\n" .. output)
repeat
    if not chks then
        chks = output:gsub("(%d)(%d)", g)
    else
        chks = chks:gsub("(%d)(%d)", g)
    end
until (#chks% 2 == 1)
print("produces checksum (35651584) of " .. chks)
