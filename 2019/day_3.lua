function man_dist(x1, y1, x2, y2)
    if x2 then
        return math.abs(x1 - x2) + math.abs(y1 - y2)
    else
        return math.abs(x1) + math.abs(y1)
    end
end
function deploy_wire(map, input)
    local x, y, step = 0, 0, 0
    map = map or {}
    map[0] = map[0] or {}
    map[0][0] = true
    for w in input:gmatch("%a%d+") do
        local dir, n = w:sub(1, 1), tonumber(w:sub(2))
        local dx, dy = (dir == "R") and 1 or (dir == "L") and -1 or 0, (dir == "U") and 1 or (dir == "D") and -1 or 0
        for i = 1, n do
            x, y, step = x + dx, y + dy, step + 1
            map[x] = map[x] or {}
            map[x][y] = map[x][y] or step
        end
    end
end
function get_connection_min_dist(map1, map2)
    local min_dist
    for x in pairs(map1) do
        for y in pairs(map1[x]) do
            if x~=0 or y~= 0 then
                if map2[x] and map2[x][y] then
                    min_dist = not min_dist and man_dist(x, y) or math.min(man_dist(x, y), min_dist) 
                end
            end
        end
    end
    return min_dist
end
function get_connection_min_step(map1, map2)
    local min_step
    for x in pairs(map1) do
        for y in pairs(map1[x]) do
            if x~=0 or y~= 0 then
                if map2[x] and map2[x][y] then
                    min_step = not min_step and (map1[x][y] + map2[x][y]) or math.min(map1[x][y] + map2[x][y], min_step)
                end
            end
        end
    end
    return min_step
end
map1, map2 = {}, {}
segond = false
for line in io.lines() do
    if not segond then
        segond = true
        deploy_wire(map1, line)
    else
        deploy_wire(map2, line)
    end
end
--part I
min_dist = get_connection_min_dist(map1, map2)
if min_dist then
    print("minimal distance is " .. min_dist)
end
--part II
min_step = get_connection_min_step(map1, map2)
if min_step then
    print("minimal step sum is " .. min_step)
end
