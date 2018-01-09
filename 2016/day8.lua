screen = {}
xl, yl = 49, 5
for y = 0, yl do
    screen[y] = {}
    for x = 0, xl do
        screen[y][x] = 0
    end
end
function debug(i)
    if i then print(i) end
    for y = 0, yl do
        local s = screen[y]
        print(s[0], table.unpack(s))
    end
end
function rect(dx, dy)
    for y = 0, math.min(dy - 1, yl) do
        for x = 0, math.min(dx - 1, xl) do
            screen[y][x] = 1
        end
    end
end
function rot(str, m, n)
    if str == "column" then
        local t = {}
        local x = m
        for y = 0, yl do
            table.insert(t, screen[y][x])
        end
        local aux = {}
        for i = 1, #t do
            aux[i] = t[(i - n - 1)%(#t) + 1]
        end
        t = aux
        for y = 0, yl do
            screen[y][x] = t[y + 1]
        end
    elseif str == "row" then
        local t = {}
        local y = m
        for x = 0, xl do
            table.insert(t, screen[y][x])
        end
        local aux = {}
        for i = 1, #t do
            aux[i] = t[(i - n - 1)%(#t) + 1]
        end
        t = aux
        for x = 0, xl do
            screen[y][x] = t[x + 1]
        end        
    end
end
input = [[rect 1x1
rotate row y=0 by 10
rect 1x1
rotate row y=0 by 10
rect 1x1
rotate row y=0 by 5
rect 1x1
rotate row y=0 by 3
rect 2x1
rotate row y=0 by 4
rect 1x1
rotate row y=0 by 3
rect 1x1
rotate row y=0 by 2
rect 1x1
rotate row y=0 by 3
rect 2x1
rotate row y=0 by 2
rect 1x1
rotate row y=0 by 3
rect 2x1
rotate row y=0 by 5
rotate column x=0 by 1
rect 4x1
rotate row y=1 by 12
rotate row y=0 by 10
rotate column x=0 by 1
rect 9x1
rotate column x=7 by 1
rotate row y=1 by 3
rotate row y=0 by 2
rect 1x2
rotate row y=1 by 3
rotate row y=0 by 1
rect 1x3
rotate column x=35 by 1
rotate column x=5 by 2
rotate row y=2 by 5
rotate row y=1 by 5
rotate row y=0 by 2
rect 1x3
rotate row y=2 by 8
rotate row y=1 by 10
rotate row y=0 by 5
rotate column x=5 by 1
rotate column x=0 by 1
rect 6x1
rotate row y=2 by 7
rotate row y=0 by 5
rotate column x=0 by 1
rect 4x1
rotate column x=40 by 2
rotate row y=2 by 10
rotate row y=0 by 12
rotate column x=5 by 1
rotate column x=0 by 1
rect 9x1
rotate column x=43 by 1
rotate column x=40 by 2
rotate column x=38 by 1
rotate column x=15 by 1
rotate row y=3 by 35
rotate row y=2 by 35
rotate row y=1 by 32
rotate row y=0 by 40
rotate column x=32 by 1
rotate column x=29 by 1
rotate column x=27 by 1
rotate column x=25 by 1
rotate column x=23 by 2
rotate column x=22 by 1
rotate column x=21 by 3
rotate column x=20 by 1
rotate column x=18 by 3
rotate column x=17 by 1
rotate column x=15 by 1
rotate column x=14 by 1
rotate column x=12 by 1
rotate column x=11 by 3
rotate column x=10 by 1
rotate column x=9 by 1
rotate column x=8 by 2
rotate column x=7 by 1
rotate column x=4 by 1
rotate column x=3 by 1
rotate column x=2 by 1
rotate column x=0 by 1
rect 34x1
rotate column x=44 by 1
rotate column x=24 by 1
rotate column x=19 by 1
rotate row y=1 by 8
rotate row y=0 by 10
rotate column x=8 by 1
rotate column x=7 by 1
rotate column x=6 by 1
rotate column x=5 by 2
rotate column x=3 by 1
rotate column x=2 by 1
rotate column x=1 by 1
rotate column x=0 by 1
rect 9x1
rotate row y=0 by 40
rotate column x=43 by 1
rotate row y=4 by 10
rotate row y=3 by 10
rotate row y=2 by 5
rotate row y=1 by 10
rotate row y=0 by 15
rotate column x=7 by 2
rotate column x=6 by 3
rotate column x=5 by 2
rotate column x=3 by 2
rotate column x=2 by 4
rotate column x=0 by 2
rect 9x2
rotate row y=3 by 47
rotate row y=0 by 10
rotate column x=42 by 3
rotate column x=39 by 4
rotate column x=34 by 3
rotate column x=32 by 3
rotate column x=29 by 3
rotate column x=22 by 3
rotate column x=19 by 3
rotate column x=14 by 4
rotate column x=4 by 3
rotate row y=4 by 3
rotate row y=3 by 8
rotate row y=1 by 5
rotate column x=2 by 3
rotate column x=1 by 3
rotate column x=0 by 2
rect 3x2
rotate row y=4 by 8
rotate column x=45 by 1
rotate column x=40 by 5
rotate column x=26 by 3
rotate column x=25 by 5
rotate column x=15 by 5
rotate column x=10 by 5
rotate column x=7 by 5
rotate row y=5 by 35
rotate row y=4 by 42
rotate row y=2 by 5
rotate row y=1 by 20
rotate row y=0 by 45
rotate column x=48 by 5
rotate column x=47 by 5
rotate column x=46 by 5
rotate column x=43 by 5
rotate column x=41 by 5
rotate column x=38 by 5
rotate column x=37 by 5
rotate column x=36 by 5
rotate column x=33 by 1
rotate column x=32 by 5
rotate column x=31 by 5
rotate column x=30 by 1
rotate column x=28 by 5
rotate column x=27 by 5
rotate column x=26 by 5
rotate column x=23 by 1
rotate column x=22 by 5
rotate column x=21 by 5
rotate column x=20 by 1
rotate column x=17 by 5
rotate column x=16 by 5
rotate column x=13 by 1
rotate column x=12 by 3
rotate column x=7 by 5
rotate column x=6 by 5
rotate column x=3 by 1
rotate column x=2 by 3]]
for line in string.gmatch(input, "%C+") do
    local n1, n2
    for d in string.gmatch(line, "%d+") do
        if not n1 then
            n1 = tonumber(d)
        else
            n2 = tonumber(d)
        end
    end
    if line:find("rect") then
        rect(n1, n2)
    elseif line:find("rotate") then
        if line:find("column") then
            rot("column", n1, n2)
        elseif line:find("row") then
            rot("row", n1, n2)
        end
    end
end
sc = 0
for x = 0, xl do
    for y = 0, yl do
        sc = sc + screen[y][x]
    end
end
print("the total of pixels on is " .. sc)
