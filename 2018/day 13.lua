function map_insert(x, y, m)
	if not map then map = {} end
	if not map[x] then map[x] = {} end
	map[x][y] = m
end
function map_get(x, y)
	if not map or not map[x] then return nil end
	return map[x][y]
end
function player_insert(p)
	if not player_list then player_list = {} end
	table.insert(player_list, p)
end
map, player_list = nil, nil
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
				else
					p.dx, p.dy = -p.dy, -p.dx
				end
			end
			p.x, p.y = p.x + p.dx, p.y + p.dy
		end
	end
	function check_colision(p)
		local colision = false
		for _, q in ipairs(player_list) do
			if p ~= q and p.x == q.x and p.y == q.y then
				colision = true
				break
			end
		end
		if colision then
			crash_x, crash_y = p.x, p.y
		end
	end
	crash_x, crash_y = nil, nil
	while not crash_x do
		table.sort(player_list, player_sort)
		for _, p in ipairs(player_list) do
			update_player(p)
			check_colision(p)
		end
	end
	if crash_x then
		print("colision at " .. crash_x .. "," .. crash_y)
	end
end
