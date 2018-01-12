fav = 1352
function f(x, y)
    local k = x*x + 3*x + 2*x*y + y + y*y
    k = k + fav
    local b = 0
    for i = 0, math.log(k, 2) do
        b = b + ((k&(1<<i))>>i)
    end
    if b%2 == 0 then
        return 0
    else
        return 1
    end
end
maze = {}
unexplored = {}
table.insert(unexplored, {x = 1, y = 1})
step = 0
dist = 0
function goalchk(x, y)
    return x == 31 and y == 39
end
function newup(step, x, y)
    if step <= 51 then
        if not maze[y] or not maze[y][x] then
            dist = dist + 1
        end
    end
end
repeat
    local t = {}
    step = step + 1
    for i, s in pairs(unexplored) do
        local x, y, s = s.x, s.y, nil
        newup(step, x, y)
        if goalchk(x, y) then
            goal = true
            break
        end
        --insert info about the current pos of maze and insert possible nom explored places if possible
        if not maze[y] then maze[y] = {} end
        maze[y][x] = f(x, y)
        if x - 1 >= 0 and (not maze[y] or not maze[y][x - 1]) then
            if f(x - 1, y) == 1 then
                maze[y][x - 1] = 1
            else
                table.insert(t, {x = x - 1, y = y})
            end
        end
        if not maze[y] or not maze[y][x + 1] then
            if f(x + 1, y) == 1 then
                maze[y][x + 1] = 1
            else
                table.insert(t, {x = x + 1, y = y})
            end
        end
        if y - 1 >= 0 and (not maze[y - 1] or not maze[y - 1][x]) then
            if f(x, y - 1) == 1 then
                if not maze[y - 1] then maze[y - 1] = {} end
                maze[y - 1][x] = 1
            else
                table.insert(t, {x = x, y = y - 1})
            end
        end
        if not maze[y + 1] or not maze[y + 1][x] then
            if f(x, y + 1) == 1 then
                if not maze[y + 1] then maze[y + 1] = {} end
                maze[y + 1][x] = 1
            else
                table.insert(t, {x = x, y = y + 1})
            end
        end
    end
    unexplored = t
until goal
print("total of " .. step .. " squares explored in minimal path")
print(step - 1 .. " number of steps necessary")
print("in 50 steps, there was " .. dist .. " diferent squares exploreds")
