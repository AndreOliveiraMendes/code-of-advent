ing = {}
for line in io.lines() do
	local temp = {}
	for word in string.gmatch(line, "-?%w+") do
		table.insert(temp, word)
	end
	local t = {}
	t.name = temp[1]
	for j = 1, 5 do
		t[temp[2*j]] = tonumber(temp[2*j + 1])
	end
	table.insert(ing, t)
end
function pairsref(n, l)
	local arg = {}
	return	function ()
				if #arg == 0 then
					for i = 1, n do
						arg[i] = (i == n) and l or 0
					end
				elseif arg[n] > 0 then
					arg[n], arg[n - 1] = arg[n] - 1, arg[n - 1] + 1
				else
					local i = n
					while arg[i] == 0 do
						i = i - 1
					end
					if i == 1 then return nil end
					arg[i - 1], arg[i], arg[n] = arg[i - 1] + 1, 0, arg[n] + arg[i] - 1
				end
				return arg
			end
end
function get_property_sum(arg, ing, property)
	local sum = 0
	for i, q in pairs(arg) do
		sum = sum + q*ing[i][property]
	end
	return sum
end
for arg in pairsref(4, 100) do
	local score
	local capacity = get_property_sum(arg, ing, "capacity")
	local durability = get_property_sum(arg, ing, "durability")
	local flavor = get_property_sum(arg, ing, "flavor")
	local texture = get_property_sum(arg, ing, "texture")
	local calories = get_property_sum(arg, ing, "calories")
	if capacity <= 0 or durability <= 0 or flavor <= 0 or texture <= 0 then
		score = 0
	else
		score = capacity*durability*flavor*texture
	end
	if not max1 or score > max1 then max1 = score end
	if calories == 500 then
		if not max2 or score > max2 then max2 = score end
	end
end
print("max score possible is " .. max1)
print("the max score possible maintening 500 calories is " .. max2)
