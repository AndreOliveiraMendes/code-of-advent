shop = {
    Weapons = {
        {name = "Dagger", cost = 8, atk = 4, def = 0},
        {name = "Shortsword", cost = 10, atk = 5, def = 0},
        {name = "Warhammer", cost = 25, atk = 6, def = 0},
        {name = "Longsword", cost = 40, atk = 7, def = 0},
        {name = "Greataxe", cost = 74, atk = 8, def = 0}
    },
    Armor = {
        {name = "Leather", cost = 13, atk = 0, def = 1},
        {name = "Chainmail", cost = 31, atk = 0, def = 2},
        {name = "Splintmail", cost = 53, atk = 0, def = 3},
        {name = "Bandedmail", cost = 75, atk = 0, def = 4},
        {name = "Platemail", cost = 102, atk = 0, def = 5}
    },
    Rings = {
        {name = "Damage +1", cost = 25, atk = 1, def = 0},
        {name = "Damage +2", cost = 50, atk = 2, def = 0},
        {name = "Damage +3", cost = 100, atk = 3, def = 0},
        {name = "Defense +1", cost = 20, atk = 0, def = 1},
        {name = "Defense +2", cost = 40, atk = 0, def = 2},
        {name = "Defense +3", cost = 80, atk = 0, def = 3}
    }
}
inventory = {Weapons = {}, Armor = {}, Rings = {}}
boss = {}
for line in io.lines() do
	local n = tonumber(line:sub(line:find("%d+")))
	if line:match("Hit Points") then
		boss.HP = n
	elseif line:match("Damage") then
		boss.atk = n
	elseif line:match("Armor") then
		boss.def = n
	end
end
player = {HP = 100, atk = 0, def = 0}
function damage(atk, def)
	return math.max(atk - def, 1)
end
--estimate the winner
function simulation(p1, p2)
    local dmg1, dmg2 = math.max(p1.atk - p2.def, 1), math.max(p2.atk - p1.def, 1)
    local t1, t2 = math.ceil(p2.HP/dmg1), math.ceil(p1.HP/dmg2)
    if t1 <= t2 then
        return true
    else
        return false
    end
end
--estimate cost
function estimate(p1, p2, cost)
	if simulation(p1, p2) then
		if not min or cost < min then
			min = cost
		end
	else
		if not max or cost > max then
			max = cost
		end
	end
end
--buying items and simulating
for _, w in pairs(shop.Weapons) do
    local cost = 0
    local p1 = {HP = player.HP, atk = player.atk, def = player.def}
    local p2 = {HP = boss.HP, atk = boss.atk, def = boss.def}
	--only sword
	p1.atk, p1.def, cost = p1.atk + w.atk, p1.def + w.def, w.cost
	estimate(p1, p2, cost)
	--buy only shield route
	for _, s in pairs(shop.Armor) do
		p1.atk, p1.def, cost = p1.atk + s.atk, p1.def + s.def, cost + s.cost
		estimate(p1, p2, cost)
		p1.atk, p1.def, cost = p1.atk - s.atk, p1.def - s.def, cost - s.cost
	end
	--buy rings route
	for i, r1 in pairs(shop.Rings) do
		p1.atk, p1.def, cost = p1.atk + r1.atk, p1.def + r1.def, cost + r1.cost
		estimate(p1, p2, cost) -- using only one ring route
		--buy a shield subrout of ring route
		for _, s in pairs(shop.Armor) do
			p1.atk, p1.def, cost = p1.atk + s.atk, p1.def + s.def, cost + s.cost
			estimate(p1, p2, cost)
			p1.atk, p1.def, cost = p1.atk - s.atk, p1.def - s.def, cost - s.cost
		end
		--buy the 2nd ring route
		for j, r2 in pairs(shop.Rings) do
			if i < j then --guarante they diferent rings
				p1.atk, p1.def, cost = p1.atk + r2.atk, p1.def + r2.def, cost + r2.cost
				estimate(p1, p2, cost) -- using only two ring route
				--complet route
				for _, s in pairs(shop.Armor) do
					p1.atk, p1.def, cost = p1.atk + s.atk, p1.def + s.def, cost + s.cost
					estimate(p1, p2, cost)
					p1.atk, p1.def, cost = p1.atk - s.atk, p1.def - s.def, cost - s.cost
				end
				p1.atk, p1.def, cost = p1.atk - r2.atk, p1.def - r2.def, cost - r2.cost
			end
		end
		p1.atk, p1.def, cost = p1.atk - r1.atk, p1.def - r1.def, cost - r1.cost
	end
end
print("the minimal cost and still win is " .. tostring(min))
print("the max cost and still lose is " .. tostring(max))
