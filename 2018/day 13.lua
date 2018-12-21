function map_insert(x, y, m)
	if not map then map = {} end
	if not map[x] then map[x] = {} end
	map[x][y] = m
end
function map_get(x, y)
	if not map or not map[x] then return nil end
	return map[x][y]
end
function map_print()
	local str = ""
	for y = y1, y2 do
		for x = x1, x2 do
			local player_zone, player_direction = false
			for _, p in ipairs(player_list) do
				if p.x == x and p.y == y then
					player_zone, player_direction = true, {x = p.dx, y = p.dy}
					break
				end
			end
			if player_zone then
				if player_direction.x > 0 then
					str = str .. ">"
				elseif player_direction.x < 0 then
					str = str .. "<"
				elseif player_direction.y > 0 then
					str = str .. "v"
				elseif player_direction.y < 0 then
					str = str .. "^"
				else
					print("error 1")
				end
			else
				if not map or not map[x] or not map[x][y] then
					str = str .. "#"
				elseif map[x][y] == 0 then
					str = str .. "-"
				elseif map[x][y] == 1 then
					str = str .. "|"
				elseif map[x][y] == 2 then
					str = str .. [[\]]
				elseif map[x][y] == 3 then
					str = str .. "/"
				elseif map[x][y] == 4 then
					str = str .. "+"
				end
			end
		end
		str = str .. "\n"
	end
	print(str)
end
function player_insert(p)
	if not player_list then player_list = {} end
	table.insert(player_list, p)
end
map, player_list, x1, x2, y1, y2 = nil, nil, nil, nil, nil, nil
if io.open([[\Users\ao_me\Desktop\input.txt]], "r") then
	local y
	for lines in io.lines([[\Users\ao_me\Desktop\input.txt]]) do
		y = y and (y + 1) or 0
		if not y1 or y < y1 then y1 = y end
		if not y2 or y > y2 then y2 = y end
		local x
		for i = 1, #lines do
			x = x and (x + 1) or 0
			if not x1 or x < x1 then x1 = x end
			if not x2 or x > x2 then x2 = x end
			local str = lines:sub(i, i)
			if str == "-" then
				map_insert(x, y, 0)
			elseif str == "|" then
				map_insert(x, y, 1)
			elseif str == [[\]] then
				map_insert(x, y, 2)
			elseif str == "/" then
				map_insert(x, y, 3)
			elseif str == "+" then
				map_insert(x, y, 4)
			elseif str == ">" or str == "<" then
				map_insert(x, y, 0)
				local player = {}
				player.x, player.y = x, y
				player.dx, player.dy = (str == ">") and 1 or -1, 0
				player.switch = "left"
				player_insert(player)
			elseif str == "v" or str == "^" then
				map_insert(x, y, 1)
				local player = {}
				player.x, player.y = x, y
				player.dx, player.dy = 0, (str == "v") and 1 or -1
				player.switch = "left"
				player_insert(player)
			end
		end
	end
end
debug = false
if map then
	function player_sort(p1, p2)
		if p1.y ~= p2.y then
			return p1.y < p2.y
		else
			return p1.x < p2.x
		end
	end
	function update_player(p)
		if not map or not map[p.x] then
			print("error")
			return
		end
		if map[p.x][p.y] == 0 then
			p.x, p.y = p.x + p.dx, p.y
		elseif map[p.x][p.y] == 1 then
			p.x, p.y = p.x, p.y + p.dy
		elseif map[p.x][p.y] == 2 then
			p.dx, p.dy = p.dy, p.dx
			p.x, p.y = p.x + p.dx, p.y + p.dy
		elseif map[p.x][p.y] == 3 then
			p.dx, p.dy = -p.dy, -p.dx
			p.x, p.y = p.x + p.dx, p.y + p.dy
		elseif map[p.x][p.y] == 4 then
			if p.switch == "left" then
				p.switch = "straight"
				if p.dx ~= 0 then
					p.dx, p.dy = -p.dy, -p.dx
				elseif p.dy ~= 0 then
					p.dx, p.dy = p.dy, p.dx
				end
			elseif p.switch == "straight" then
				p.switch = "right"
			elseif p.switch == "right" then
				p.switch = "left"
				if p.dx ~= 0 then
					p.dx, p.dy = p.dy, p.dx
				elseif p.dy ~= 0 then
					p.dx, p.dy = -p.dy, -p.dx
				end
			end
			p.x, p.y = p.x + p.dx, p.y + p.dy
		end
	end
	function check_colision(p)
		local colision = false
		if p.colision then return false end
		for _, q in ipairs(player_list) do
			if p ~= q and not q.colision and p.x == q.x and p.y == q.y then
				colision, p.colision, q.colision = true, true, true
				break
			end
		end
		return colision, p.x, p.y
	end
	function get_alive_player()
		local count = 0
		for _, p in ipairs(player_list) do
			if not p.colision then
				count = count + 1
			end
		end
		return count
	end
	crash_x, crash_y = nil, nil
	while get_alive_player() > 1 do
		if debug then
			print("start of tick from " .. x1 .. "-" .. x2 .. "," .. y1 .. "-" .. y2)
			map_print()
		end
		table.sort(player_list, player_sort)
		for _, p in ipairs(player_list) do
			update_player(p)
			local colision, x, y = check_colision(p)
			if colision and not crash_x then
				crash_x, crash_y = x, y
			end
		end
		if debug then
			print("==============================================")
			map_print()
		end
	end
	if crash_x then
		print("colision at " .. crash_x .. "," .. crash_y)
	end
	if get_alive_player() == 1 then
		local last
		for _, p in ipairs(player_list) do
			if not p.colision then
				last = p
				break
			end
		end
		print("last position at " .. last.x .. "," .. last.y)
	end
end
