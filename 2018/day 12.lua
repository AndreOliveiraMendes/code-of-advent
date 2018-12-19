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
	for x = m.x1 - 2, m.x2 + 2 do
		for y = x - 2, x + 2 do
			if not m[y] then m[y] = 0 end
		end
		fm[x] = conv(m[x - 2], m[x - 1], m[x], m[x + 1], m[x + 2])
		if fm[x] == 1 and not fm.x1 then fm.x1 = x end
		if fm[x] == 1 then fm.x2 = x end
	end
	if not fm.x1 then fm.x1 = m.x1 end
	if not fm.x2 then fm.x2 = m.x2 end
	return fm
end
function gprint(m)
	local str = ""
	for x = m.x1, m.x2 do
		if x == 0 then
			str = str .. "("
		end
		str = str .. (m[x] == 1 and "#" or ".")
		if x == 0 then
			str = str .. ")"
		end
	end
	return str
end
function getsum(sm)
	local sum = 0
	for x = sm.x1, sm.x2 do
		sum = sum + (sm[x] == 1 and x or 0)
	end
	return sum
end
debug = false
if debug then print(0, nil, gprint(sm)) end
for i = 1, 20 do
	if not fm then
		fm = transf(sm)
	else
		fm = transf(fm)
	end
	if debug then print(i, fm.x1, gprint(fm)) end
end
sum = getsum(fm)
print("sum = " .. sum)
