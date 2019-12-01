function update_count(mcity, x, y)
    if not mcity[x] then mcity[x] = {} end
    if not mcity[x][y] then
        mcity[x][y] = 1
        return 1
    else
        mcity[x][y] = mcity[x][y] + 1
        return 0
    end
end
input = io.read()
x, y, count = 0, 0, 1
mcity = {[0] = {[0] = 1}}
for i = 1, #input do
    local str = string.sub(input, i, i)
    if str == "^" then
        y = y + 1
    elseif str == ">" then
        x = x + 1
    elseif str == "<" then
        x = x - 1
    else
        y = y - 1
    end
    count = count + update_count(mcity, x, y)
end
--part I
print("there was " .. count .. " child that win any present")
x, y, xr, yr, count = 0, 0, 0, 0, 1
mcity = {[0] = {[0] = 1}}
for i = 1, #input do
    local str = string.sub(input, i, i)
    if str == "^" then
        if i%2 == 1 then
            y = y + 1
        else
            yr = yr + 1
        end
    elseif str == ">" then
        if i%2 == 1 then
            x = x + 1
        else
            xr = xr + 1
        end
    elseif str == "<" then
        if i%2 == 1 then
            x = x - 1
        else
            xr = xr - 1
        end
    else
        if i%2 == 1 then
            y = y - 1
        else
            yr = yr - 1
        end
    end
    if i%2 == 1 then
        count = count + update_count(mcity, x, y)
    else
        count = count + update_count(mcity, xr, yr)
    end
end
--part II
print("now there was " .. count .. " child that win any present")
