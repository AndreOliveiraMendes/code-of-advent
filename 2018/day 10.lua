list = {}
for word in input:gmatch("%C+") do
    local p = {}
    local x, y, dx, dy
    for n in word:gmatch("-?%d+") do
        if not x then
            x = tonumber(n)
        elseif not y then
            y = tonumber(n)
        elseif not dx then
            dx = tonumber(n)
        else
            dy = tonumber(n)
        end
    end
    p.x = function (t) return x + t*dx end
    p.y = function (t) return y + t*dy end
    table.insert(list, p)
end
for t = 0, 5 do
    local min_x, max_x, min_y, max_y
    local grid = {}
    for _, p in pairs(list) do
        if not min_x or p.x(t) < min_x then min_x = p.x(t) end
        if not min_y or p.y(t) < min_y then min_y = p.y(t) end
        if not max_x or p.x(t) > max_x then max_x = p.x(t) end
        if not max_y or p.y(t) > max_y then max_y = p.y(t) end
        if not grid[p.x(t)] then grid[p.x(t)] = {} end
        grid[p.x(t)][p.y(t)] = "#"
    end
    print("maping at " .. t .. " with the limits on x and y respectively " .. min_x .. " to " .. max_x .. " and " .. min_y .. " to " .. max_y)
    for y = min_y, max_y do
        local str = ""
        for x = min_x, max_x do
            if not grid[x] or not grid[x][y] then
                str = str .. "."
            else
                str = str .. grid[x][y]
            end
        end
        print(str)
    end
end
