function power(x, y, s)
	local r_id = x + 10
	local n = (r_id*y + s)*r_id
	local d = (n%1000 - n%100)/100
	return d - 5
end
serial = 7315
sum = {}
for i = 1, 300 do
	for x = 1, 301 - i do
		if not sum[x] then sum[x] = {} end
		for y = 1, 301 - i do
			if not sum[x][y] then sum[x][y] = 0 end
			for j = 0, i - 1 do
				sum[x][y] = sum[x][y] + power(x + i - 1, y + j, serial)
			end
			for j = 0, i - 2 do
				sum[x][y] = sum[x][y] + power(x + j, y + i - 1, serial)
			end
			if i == 3 and (not mp3 or sum[x][y] > mp3) then
				mp3, mp3x, mp3y = sum[x][y], x, y
			elseif i == 3 and sum[x][y] == mp3 then
				mp3x, mp3y = nil, nil
			end
			if not mp or sum[x][y] > mp then
				mp, mpx, mpy, mpd = sum[x][y], x, y, i
			elseif sum[x][y] == mp then
				mpx, mpy = nil, nil
			end
		end
	end
end
--part I
if mp3x and mp3y then
	print("top left of 3x3 grid with max power is at " .. mp3x .. "," .. mp3y)
else
	print("unexpected behavior")
end
--part II
if mpx and mpy then
	print("top left of " .. mpd .. "x" .. mpd .. " with max power is at " .. mpx .. "," .. mpy)
else
	print("unexpected behavior")
end
