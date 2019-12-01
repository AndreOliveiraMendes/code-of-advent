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
function move(str, x, y)
    if str == "^" then
        return x, y + 1
    elseif str == ">" then
        return x + 1, y
    elseif str == "<" then
        return x - 1, y
    else
        return x, y - 1
    end
end
input = io.read()
x, y, count = 0, 0, 1
mcity = {[0] = {[0] = 1}}
for i = 1, #input do
    local str = string.sub(input, i, i)
    x, y = move(str, x, y)
    count = count + update_count(mcity, x, y)
end
--part I
print("there was " .. count .. " child that win any present")
x, y, xr, yr, count = 0, 0, 0, 0, 1
mcity = {[0] = {[0] = 1}}
for i = 1, #input do
    local str = string.sub(input, i, i)
    if i%2 == 1 then
        x, y = move(str, x, y)
        count = count + update_count(mcity, x, y)
    else
        xr, yr = move(str, xr, yr)
        count = count + update_count(mcity, xr, yr)
    end
end
--part II
print("now there was " .. count .. " child that win any present")
