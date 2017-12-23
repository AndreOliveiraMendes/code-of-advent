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
    local x = i - (it+1)/2
    if not max or x>max then max = x end
    for j = 1, jt do
        local y = j - (jt+1)/2
        if not max or y>max then max = y end
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
--]]  
