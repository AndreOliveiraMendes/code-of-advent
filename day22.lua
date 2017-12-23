input = {".########.....#...##.####",
"....#..#.#.##.###..#.##..",
"##.#.#..#.###.####.##.#..",
"####...#...####...#.##.##",
"..#...###.#####.....##.##",
"..#.##.######.#...###...#",
".#....###..##....##...##.",
"##.##..####.#.######...##",
"#...#..##.....#..#...#..#",
"........#.##..###.#.....#",
"#.#..######.#.###..#...#.",
".#.##.##..##.####.....##.",
".....##..#....#####.#.#..",
"...#.#.#..####.#..###..#.",
"##.#..##..##....#####.#..",
".#.#..##...#.#####....##.",
".####.#.###.####...#####.",
"...#...######..#.##...#.#",
"#..######...#.####.#..#.#",
"...##..##.#.##.#.#.#....#",
"###..###.#..#.....#.##.##",
"..#....##...#..#..##..#..",
".#.###.##.....#.###.#.###",
"####.##...#.#....#..##...",
"#.....#.#..#.##.#..###..#"}
it, jt = #input, #input[1]
t = {}
for i = 1, it do
    local y = i - (it+1)/2
    if not max or y>max then max = y end
    for j = 1, jt do
        local x = j - (jt+1)/2
        if not max or x>max then max = x end
        if not t[x] then t[x] = {} end
        local str = string.sub(input[i],j,j)
        if str == "#" then
            t[x][y] = true
        elseif str == "." then
            t[x][y] = false
        end
    end
end
x, y, dir = 0, 0, "up"
ref = {"left","up","right","down"}
count = 0
function turn(stat, list, dir)
    local ind
    for i=1,4 do
        if list[i] == dir then
            ind = i
            break
        end
    end
    if stat then
        ind = ind + 1
        if ind > 4 then ind = 1 end
        return list[ind]
    else
        ind = ind - 1
        if ind < 1 then ind = 4 end
        return list[ind]
    end
end
function infect(t,stat,x,y)
    if not t[x] then t[x] = {} end
    t[x][y] = not stat
    return not stat
end
function move(dir,x,y)
    if dir == "up" then
        return x,y-1
    elseif dir == "right" then
        return x+1,y
    elseif dir == "down" then
        return x,y+1
    elseif dir == "left" then
        return x-1,y
    end
end
for i = 1, 10000 do
    if not max or x>max then max = x end
    if not max or y>max then max = y end
    local state = t[x] and t[x][y]
    dir = turn(state,ref,dir)
    if infect(t,state,x,y) then
        count = count + 1
    end
    x,y=move(dir,x,y)
end
print("part I:")
print("there was " .. count .. " infected cells")
--[[
    function pc(t,max)
        for x=-max,max do
            local str = ""
            for y=-max,max do
                if t[x] and t[x][y] then
                    str = str .. "o"
                else
                    str = str .. "."
                end
            end
            print(str)
        end
    end
    part I:
    nil/false = clean
    true = infected
    clean (nil/false) -> infected (true) -> clean (false)
    part II:
    nil/0 == clean
    1 == weakned
    2 == infected
    3 == flaged
    clean (nil/0) -> weakned (1) -> infected (2) -> flaged (3) -> clean (0)
--]]
max = nil
t = {}
for i = 1, it do
    local y = i - (it+1)/2
    if not max or y>max then max = y end
    for j = 1, jt do
        local x = j - (jt+1)/2
        if not max or x>max then max = x end
        if not t[x] then t[x] = {} end
        local str = string.sub(input[i],j,j)
        if str == "#" then
            t[x][y] = 2
        elseif str == "." then
            t[x][y] = 0
        end
    end
end
x, y, dir = 0, 0, "up"
count = 0
function turn2(stat, list, dir)
    local ind
    for i=1,4 do
        if list[i] == dir then
            ind = i
            break
        end
    end
    if stat == 0 then
        ind = ind - 1
        if ind < 1 then ind = 4 end
        return list[ind]
    elseif stat == 1 then
        return list[ind]
    elseif stat == 2 then
        ind = ind + 1
        if ind > 4 then ind = 1 end
        return list[ind]
    elseif stat == 3 then
        if ind <= 2 then ind = ind + 2 else ind = ind - 2 end
        return list[ind]
    end
end
function infect2(t,stat,x,y)
    if not t[x] then t[x] = {} end
    if stat == 0 then
        t[x][y] = 1
    elseif stat == 1 then
        t[x][y] = 2
    elseif stat == 2 then
        t[x][y] = 3
    elseif stat == 3 then
        t[x][y] = 0
    end
    return stat == 1
end
for i = 1, 10000000 do
    if not max or x>max then max = x end
    if not max or y>max then max = y end
    local state
    if t[x] and t[x][y] then
        state = t[x][y]
    else
        state = 0
    end
    dir = turn2(state,ref,dir)
    if infect2(t,state,x,y) then
        count = count + 1
    end
    x,y=move(dir,x,y)
end
print("part II")
print("there was " .. count .. " infected cells")
