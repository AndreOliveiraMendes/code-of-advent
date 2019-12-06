player = {HP = 50, MP = 500, atk = 0, def = 0}
boss = {MP = 0, def = 0}
for line in io.lines() do
	local n = tonumber(line:sub(line:find("%d+")))
	if line:match("Hit Points") then
		boss.HP = n
	elseif line:match("Damage") then
		boss.atk = n
	end
end
spells = {
    Magic_Missile = {cost = 53, dmg = 4},
    Drain = {cost = 73, dmg = 2, rcv = 2},
    Shield = {cost = 113, timer = 6},
    Poison = {cost = 173, timer = 6},
    Recharge = {cost = 229, timer = 5}
}
effects = {
    Shield = {def = 7},
    Poison = {dmg = 3},
    Recharge = {MP = 101}
}
function damage(atk, def)
    return math.max(atk - def, 1)
end
function simulate(hp1, hp2, mp, shield, shield_timer, poison, poison_timer, recharge, recharge_timer, options, mpcost, hardmode)
    --hardmode
    if hardmode then
        hp1 = hp1 - 1
        if hp1 <= 0 then
            return
        end
    end
    --effects on player turn
    if shield then
        shield_timer = shield_timer - 1
        if shield_timer == 0 then
            shield = false
            shield_timer = nil
        end
    end
    if poison then
        hp2 = hp2 - 3
        poison_timer = poison_timer - 1
        if poison_timer == 0 then
            poison = false
            poison_timer = nil
        end
    end
    if recharge then
        mp = mp + 101
        recharge_timer = recharge_timer - 1
        if recharge_timer == 0 then
            recharge = false
            recharge_timer = nil
        end
    end
    --check if boss died with that
    if hp2 <= 0 then
        if not min_mana or mpcost < min_mana then
            min_mana = mpcost
        end
        return
    end
    --get valid choices
    local choice = {}
    for i, s in pairs(options) do
        if spells[s].cost <= mp then
            if s == "Shield" or s == "Poison" or s == "Recharge" then
                if (s == "Shield" and not shield) or (s == "Poison" and not poison) or (s == "Recharge" and not recharge) then
                    table.insert(choice, s)
                end
            else
                table.insert(choice, s)
            end
        end
    end
    for i, s in pairs(choice) do
        local mpcost = mpcost
        --effects stats
        local shield, shield_timer = shield, shield_timer
        local poison, poison_timer = poison, poison_timer
        local recharge, recharge_timer = recharge, recharge_timer
        local hp1, hp2, mp = hp1, hp2, mp --stats
        mp, mpcost = mp - spells[s].cost, mpcost + spells[s].cost
        if s == "Magic_Missile" then
            hp2 = hp2 - spells[s].dmg
        elseif s == "Drain" then
            hp1, hp2 = hp1 + spells[s].rcv, hp2 - spells[s].dmg
        elseif s == "Shield" then
            shield, shield_timer = true, spells[s].timer
        elseif s == "Poison" then
            poison, poison_timer = true, spells[s].timer
        elseif s == "Recharge" then
            recharge, recharge_timer = true, spells[s].timer
        end
        --check if it will still continue
        if hp2 <= 0 then
            if not min_mana or mpcost < min_mana then
                min_mana = mpcost
            end
            goto skip
        end
        -- continue with boss turn, applying effect first
        local def = 0 --extra defense
        if shield then
            def = effects["Shield"].def
            shield_timer = shield_timer - 1
            if shield_timer == 0 then
                shield = false
                shield_timer = nil
            end
        end
        if poison then
            hp2 = hp2 - 3
            poison_timer = poison_timer - 1
            if poison_timer == 0 then
                poison = false
                poison_timer = nil
            end
        end
        if recharge then
            mp = mp + 101
            recharge_timer = recharge_timer - 1
            if recharge_timer == 0 then
                recharge = false
                recharge_timer = nil
            end
        end
        if hp2 <= 0 then
            if not min_mana or mpcost < min_mana then
                min_mana = mpcost
            end
            goto skip
        end
        hp1 = hp1 - damage(boss.atk, player.def + def)
        if hp1 > 0 then
            simulate(hp1, hp2, mp, shield, shield_timer, poison, poison_timer, recharge, recharge_timer, options, mpcost, hardmode)
        end
        ::skip::
    end
end
analys = {}
simulate(player.HP, boss.HP, player.MP, false, nil, false, nil, false, nil, {"Magic_Missile", "Drain", "Shield", "Poison", "Recharge"}, 0)
print("the minimal cost to win is " .. tostring(min_mana))
min_mana = nil
simulate(player.HP, boss.HP, player.MP, false, nil, false, nil, false, nil, {"Magic_Missile", "Drain", "Shield", "Poison", "Recharge"}, 0, true)
print("in hardmode, the minimal cost to win is " .. tostring(min_mana))
