ing = {}
for line in io.lines() do
	local temp = {}
	for word in string.gmatch(s, "-?%w+") do
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
	for i = 1, n do
		arg[i] = 0
	end
	local	function getsum(t)
				local sum = 0
				for _, s in pairs(t) do
					sum = sum + s
				end
				return sum
			end
	return	function ()
				repeat
					for j = #arg, 1, -1 do
						if arg[j] + 1 <= l then
							arg[j] = arg[j] + 1
							break
						elseif j > 1 then
							arg[j] = 0
						else
							return nil
						end
					end
				until (getsum(arg) == l)
				return table.unpack(arg)
			end
end
for i1, i2, i3, i4 in pairsref(4, 100) do
	local score
	local capacity = i1*ing[1].capacity + i2*ing[2].capacity + i3*ing[3].capacity + i4*ing[4].capacity
	local durability = i1*ing[1].durability + i2*ing[2].durability + i3*ing[3].durability + i4*ing[4].durability
	local flavor = i1*ing[1].flavor + i2*ing[2].flavor + i3*ing[3].flavor + i4*ing[4].flavor
	local texture = i1*ing[1].texture + i2*ing[2].texture + i3*ing[3].texture + i4*ing[4].texture
	local calories = i1*ing[1].calories + i2*ing[2].calories + i3*ing[3].calories + i4*ing[4].calories
	if capacity <= 0 or durability <= 0 or flavor <= 0 or texture <= 0 then
		score = 0
	else
		score = capacity*durability*flavor*texture
	end
	if not max1 or score > max1 then max1 = score end
	if calories == 500 and not max2 or score > max2 then max2 = score end
end
print("max score possible is " .. max1)
print("the max score possible maintening 500 calories is " .. max2)
