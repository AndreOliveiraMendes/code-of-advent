function power(x, y, s)
    local r_id = x + 10
    local n = (r_id*y + s)*r_id
    local d = (n%1000 - n%100)/100
    return d - 5
end
grid = {}

serial = 7315
for x = 1, 300 do
    if not grid[x] then grid[x] = {} end
    for y = 1, 300 do
        grid[x][y] = power(x, y, serial)
    end
end
for x = 2, 299 do
    for y = 2, 299 do
        local sum = 0
        for dx = -1, 1 do
            for dy = -1, 1 do
                sum = sum + grid[x + dx][y + dy]
            end
        end
        if not mp3 or sum > mp3 then
            mp3 = sum
            mp3x = x
            mp3y = y
        elseif sum == mp3 then
            mp3x = nil
            mp3y = nil
        end
    end
end
--part I
if mp3x and mp3y then
    print("top left of 3x3 grid with max power is at " .. mp3x - 1 .. "," .. mp3y - 1)
else
    print("unexpected behavior")
end
