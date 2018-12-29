function map_insert(x, y, m)
	map = map and map or {}
	map[x] = map[x] and map[x] or {}
	map[x][y] = m
end
function map_print(map)
	local str = ""
	for y = y1, y2 do
		for x = x1, x2 do
			if not map[x] or not map[x][y] then
				str = str .. "?"
			elseif map[x][y] == 0 then
				str = str .. "."
			elseif map[x][y] == 1 then
				str = str .. "|"
			elseif map[x][y] == 2 then
				str = str .. "#"
			else
				str = str .. "!"
			end
		end
		str = str .. "\n"
	end
	print(str)
end
function get_new(x, y, map)
	local count = {[0] = 0, [1] = 0, [2] = 0}
	for yr = y - 1, y + 1 do
		for xr = x - 1, x + 1 do
			if (xr ~= x or yr ~= y) and map[xr] and map[xr][yr] then
				count[map[xr][yr]] = count[map[xr][yr]] + 1
			end
		end
	end
	if map[x][y] == 0 and count[1] >= 3 then
		return 1
	elseif map[x][y] == 1 and count[2] >= 3 then
		return 2
	elseif map[x][y] == 2 and not (count[1] >= 1 and count[2] >= 1) then
		return 0
	end
	return map[x][y]
end
function advance(map)
	local map_1 = {}
	for y = y1, y2 do
		for x = x1, x2 do
			map_1[x] = map_1[x] and map_1[x] or {}
			map_1[x][y] = get_new(x, y, map)
		end
	end
	return map_1
end
function resource_value(map)
	local count = {[0] = 0, [1] = 0, [2] = 0}
	for y = y1, y2 do
		for x = x1, x2 do
			count[map[x][y]] = count[map[x][y]] + 1
		end
	end
	return count[1]*count[2]
end
map = nil
x1, x2, y1, y2 = nil, nil, nil, nil
if io.open([[\Users\ao_me\Desktop\advent of code\input_18.txt]], "r") then
	local y
	for lines in io.lines([[\Users\ao_me\Desktop\advent of code\input_18.txt]]) do
		y = y and (y + 1) or 0
		if not y1 or y < y1 then y1 = y end
		if not y2 or y > y2 then y2 = y end
		local x
		for i = 1, #lines do
			x = x and (x + 1) or 0
			if not x1 or x < x1 then x1 = x end
			if not x2 or x > x2 then x2 = x end
			local str = lines:sub(i, i)
			if str == "." then
				map_insert(x, y, 0)
			elseif str == "|" then
				map_insert(x, y, 1)
			elseif str == "#" then
				map_insert(x, y, 2)
			end
		end
	end
end
if map then
	f_map = nil
	for t = 1, 10 do
		f_map = f_map and advance(f_map) or advance(map)
	end
	print("answer = " .. resource_value(f_map))
end
