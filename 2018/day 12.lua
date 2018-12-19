initial = "##.#.#.##..#....######..#..#...#.#..#.#.#..###.#.#.#..#..###.##.#..#.##.##.#.####..##...##..#..##.#."
sm = {}
for i = 1, #initial do
	if initial:sub(i, i) == "." then
		sm[i - 1] = 0
	else
		sm[i - 1] = 1
	end
end
sm.x1 = 0
sm.x2 = #initial - 1
tstring = [[...## => #
#.#.# => #
.###. => #
#.#.. => .
.#..# => #
#..#. => #
..##. => .
....# => .
#.... => .
###.. => #
.#### => #
###.# => .
#..## => #
..... => .
##.## => #
####. => .
##.#. => .
#...# => .
##### => .
..#.. => .
.#.#. => .
#.### => .
.##.# => .
..#.# => .
.#.## => #
...#. => .
##... => #
##..# => #
.##.. => .
.#... => #
#.##. => #
..### => .]]
transform = {}
for word in tstring:gmatch("%C+") do
	local i, j = word:find(" => ")
	local a, b = word:sub(1, i - 1), word:sub(j + 1)
	transform[a] = b
end
function conv(...)
	local arg = {...}
	local str = ""
	for i, n in pairs(arg) do
		if n == 1 then
			str = str .. "#"
		else
			str = str .. "."
		end
	end
	if transform[str] == "#" then
		return 1
	elseif transform[str] == "." then
		return 0
	else
		return 0
	end
end
function transf(m)
	local fm = {}
	for x = m.x1 - 5, m.x2 + 5 do
		for y = x - 2, x + 2 do
			if not m[y] then m[y] = 0 end
		end
		fm[x] = conv(m[x - 2], m[x - 1], m[x], m[x + 1], m[x + 2])
		if x < m.x1 and fm[x] == 1 then fm.x1 = x - 5 end
		if x > m.x2 and fm[x] == 1 then fm.x2 = x + 5 end
	end
	if not fm.x1 then fm.x1 = m.x1 end
	if not fm.x2 then fm.x2 = m.x2 end
	return fm
end
for i = 1, 20 do
	sm = transf(sm)
end
sum = 0
for x = sm.x1, sm.x2 do
	sum = sum + (sm[x] == 1 and x or 0)
end
print("sum = " .. sum)
