if io.open([[\Users\ao_me\Desktop\advent of code\input_23.txt]], "r") then
	local nanobots = {}
	local max_r, max_nb = nil, nil
	local function distance_bot(nb1, nb2)
		return math.abs(nb2.x - nb1.x) + math.abs(nb2.y - nb1.y) + math.abs(nb2.z - nb1.z)
	end
	for lines in io.lines([[\Users\ao_me\Desktop\advent of code\input_23.txt]]) do
		local x, y, z, r
		for n in lines:gmatch("-?%d+") do
			if not x then
				x = tonumber(n)
			elseif not y then
				y = tonumber(n)
			elseif not z then
				z = tonumber(n)
			else
				r = tonumber(n)
			end
		end
		local nanobot = {}
		nanobot.x, nanobot.y, nanobot.z, nanobot.r = x, y, z, r
		table.insert(nanobots, nanobot)
		if not max_r or r > max_r then
			max_r, max_nb = r, nanobot
		elseif r == max_r then
			max_nb = nil
		end
	end
	local count = 0
	for _, nb in pairs(nanobots) do
		if distance_bot(nb, max_nb) <= max_nb.r then
			count = count + 1
		end
	end
	print("there are " .. count .. " nanobots in range of largest radius one")
end
