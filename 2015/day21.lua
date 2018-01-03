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
boss = {HP = 104, atk = 8, def = 1}
player = {HP = 100, atk = 0, def = 0}
function damage(atk, def)
	return math.max(atk - def, 1)
end
function restart_stats()
    boss = {HP = 104, atk = 8, def = 1}
    player = {HP = 100, atk = 0, def = 0}
end
function game()
    --stat from items
    for i, s in pairs(inventory.Weapons) do
        player.atk, player.def = player.atk + s.atk, player.def + s.def
    end
    for i, s in pairs(inventory.Armor) do
        player.atk, player.def = player.atk + s.atk, player.def + s.def
    end
    for i, s in pairs(inventory.Rings) do
        player.atk, player.def = player.atk + s.atk, player.def + s.def
    end
    local turn = 0
	while player.HP > 0 and boss.HP > 0 do
		--player turn
		turn = turn + 1
		boss.HP = boss.HP - damage(player.atk, boss.def)
		if boss.HP <= 0 then break end
		--boss turn
		turn = turn + 1
		player.HP = player.HP - damage(boss.atk, player.def)
		if player.HP <= 0 then break end
	end
	if boss.HP <= 0 then
		print("the player win")
	elseif player.HP <= 0 then
		print("the player lose")
	end
	print("the game taked " .. turn .. " to end")
end
--estimate
function simulation(p1, p2)
    local dmg1, dmg2 = math.max(p1.atk - p2.def, 1), math.max(p2.atk - p1.def, 1)
    local t1, t2 = math.ceil(p2.HP/dmg1), math.ceil(p1.HP/dmg2)
    if t1 <= t2 then
        return true
    else
        return false
    end
end
--buying items
for i, s in pairs(shop.Weapons) do
    local cost = 0
    local p1 = {HP = player.HP, atk = player.atk, def = player.def}
    local p2 = {HP = boss.HP, atk = boss.atk, def = boss.def}
    p1.atk, p1.def, cost = s.atk, s.def, cost + s.cost
    if simulation(p1, p2) then
        if not min or cost < min then
            min = cost
        end
    end
    --0 rings
    for i, s in pairs(shop.Armor) do
        p1.atk, p1.def, cost = p1.atk + s.atk, p1.def + s.def, cost + s.cost
        if simulation(p1, p2) then
            if not min or cost < min then
                min = cost
            end
        end
        p1.atk, p1.def, cost = p1.atk - s.atk, p1.def - s.def, cost - s.cost
    end
    --1/2 rings
    for i, s in pairs(shop.Rings) do
        --1 ring
        p1.atk, p1.def, cost = p1.atk + s.atk, p1.def + s.def, cost + s.cost
        if simulation(p1, p2) then
            if not min or cost < min then
                min = cost
            end
        end
        --shield
        for i, s in pairs(shop.Armor) do
            p1.atk, p1.def, cost = p1.atk + s.atk, p1.def + s.def, cost + s.cost
            if simulation(p1, p2) then
                if not min or cost < min then
                    min = cost
                end
            end
            p1.atk, p1.def, cost = p1.atk - s.atk, p1.def - s.def, cost - s.cost
        end
        --2 ring
        for j, s in pairs(shop.Rings) do
            if i < j then
                p1.atk, p1.def, cost = p1.atk + s.atk, p1.def + s.def, cost + s.cost
                if simulation(p1, p2) then
                    if not min or cost < min then
                        min = cost
                    end
                end
                for i, s in pairs(shop.Armor) do
                    p1.atk, p1.def, cost = p1.atk + s.atk, p1.def + s.def, cost + s.cost
                    if simulation(p1, p2) then
                        if not min or cost < min then
                            min = cost
                        end
                    end
                    p1.atk, p1.def, cost = p1.atk - s.atk, p1.def - s.def, cost - s.cost
                end
                p1.atk, p1.def, cost = p1.atk - s.atk, p1.def - s.def, cost - s.cost
            end
        end
        p1.atk, p1.def, cost = p1.atk - s.atk, p1.def - s.def, cost - s.cost
    end
end
print("the minimal cost is " .. tostring(min))
