function table.nrinsert(t, v)
	for _, rv in pairs(t) do
		if rv == v then return false end
	end
	table.insert(t, v)
	return true
end
names = {}
hc = {}
for line in io.lines() do
	line = string.gsub(line, "would gain ", "+")
	line = string.gsub(line, "happiness units by sitting next to ", "")
	line = string.gsub(line, "would lose ", "-")
	local t = {}
	for name in line:gmatch("%a+") do
		table.nrinsert(names, name)
		table.insert(t, name)
	end
	local n1, n2, v = t[1], t[2], tonumber(line:match("-?%d+"))
	hc[n1] = hc[n1] or {}
	hc[n1][n2] = v
end
function getmaxhc(names, hc, used)
	local max
	if #names ~= 0 then
		for i, s in pairs(names) do
			table.insert(used, s)
			table.remove(names, i)
			local hc = getmaxhc(names, hc, used)
			if not max or hc > max then max = hc end
			table.remove(used, #used)
			table.insert(names, i, s)
		end
	else
		local thc = 0
		for i = 1, #used do
			local j, k = i - 1, i + 1
			if j < 1 then j = #used end
			if k > #used then k = 1 end
			thc = thc + hc[used[i]][used[j]] + hc[used[i]][used[k]]
		end
		return thc
	end
	return max
end
max = getmaxhc(names, hc, {})
print("max happynes change is " .. max)
table.insert(names,"me")
for i, s in pairs(names) do
	if s ~= "me" then
		hc.me = hc.me or {}
		hc.me[s] = 0
		hc[s].me = 0
	end
end
max = getmaxhc(names, hc, {})
print("max happynes change is " .. max)
