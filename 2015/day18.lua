x, y, ml2, ml2d = 1, 1, {}, {}
for line in io.lines() do
    ml2[y] = {}
    for i = 1, #line do
        if string.sub(line, i, i) == "#" then
            ml2[y][x] = 1
        else
            ml2[y][x] = 0
        end
        x = x + 1
    end
    y, x = y + 1, 1
end
for y = 1, #ml2 do
    ml2d[y] = {}
    for x = 1, #ml2[y] do
        if (x == 1 or x == #ml2[#ml2]) and (y == 1 or y == #ml2) then
            ml2d[y][x] = 1
        else
            ml2d[y][x] = ml2[y][x]
        end
    end
end
function gloml(ml) --get light on matrix light
    local count = 0
    for y = 1, #ml do
        for x = 1, #ml[y] do
            count = count + ml[y][x]
        end
    end
    return count
end
function f(x, y, ml) --get the light level of a cell
    if ml[y] and ml[y][x] then
        return ml[y][x]
    else
        return 0
    end
end
function g(x, y, ml) --check if a cell exist
    if ml[y] and ml[y][x] then
        return 1
    else
        return 0
    end
end
function us(x, y, ml, def)
    local state, count, ncount = ml[y][x], 0, 0
    for xr = x - 1, x + 1 do
        for yr = y - 1, y + 1 do
            if xr ~= x or yr ~= y then
                count = count + f(xr, yr, ml)
                ncount = ncount + g(xr, yr, ml)
            end
        end
    end
    if def then
        if ncount == 3 then return 1 end
    end
    if state == 1 then
        if count == 2 or count == 3 then
            return 1
        else
            return 0
        end
    else
        if count == 3 then
            return 1
        else
            return 0
        end
    end
end
for t = 1, 100 do
    local temp = {}
    for y = 1, #ml2 do
        temp[y] = {}
        for x = 1, #ml2[y] do
            temp[y][x] = us(x, y, ml2)
        end
    end
    ml2 = temp
    if t == 100 then
        print("after " .. t .. " steps, there are " .. gloml(ml2) .. " light on")
    end
end
--part II
for t = 1, 100 do
    local temp = {}
    for y = 1, #ml2d do
        temp[y] = {}
        for x = 1, #ml2d[y] do
            temp[y][x] = us(x, y, ml2d, true)
        end
    end
    ml2d = temp
    if t == 100 then
        print("after " .. t .. " steps, there are " .. gloml(ml2d) .. " light on")
    end
end
