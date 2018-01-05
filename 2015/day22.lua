player = {HP = 50, MP = 500, atk = 0, def = 0}
boss = {HP = 71, MP = 0, atk = 10, def = 0}
spells = {
    Magic_Missile = {cost = 53, dmg = 4},
    Drain = {cost = 73, dmg = 2, rcv = 2},
    Shield = {cost = 113, timer = 6},
    Poison = {cost = 173, timer = 6},
    Recharge = {cost = 229, timer = 5}
}
effects = {
    Shield = {def = 6},
    Poison = {dmg = 3},
    Recharge = {MP = 101}
}
function damage(atk, def)
    return math.max(atk - def, 1)
end
function reset()
    player = {HP = 50, MP = 500, atk = 0, def = 0}
    boss = {HP = 71, MP = 0, atk = 10, def = 0}
end
function choose(options, active_effect, mp)
    for i, s in pairs(options) do
        if active_effect[s] or spells[s].cost > mp then options[i] = nil end
    end
    if #options ~= 0 then
        print("choose options")
        print(table.unpack(options))
        return io.read()
    else
        return
    end
end
function game()
    local turn = 1
    local active_effect = {}
    while player.HP > 0 and player.MP > 0 and boss.HP > 0 do
        if turn % 2 == 1 then --player turn
            print("player turn:")
            print("player HP:" .. player.HP .. ", player MP:" .. player.MP)
            print("boss HP:" .. boss.HP)
            --effects
            for i, s in pairs(active_effect) do
                if i == "Poison" then
                    boss.HP = boss.HP - effects[i].dmg
                elseif i == "Recharge" then
                    player.MP = player.MP + effects[i].MP
                end
                if s - 1 > 0 then
                    active_effect[i] = s - 1
                else
                    active_effect[i] = nil
                end
            end
            if boss.HP <= 0 then
                break
            end
            local options = {"Magic_Missile", "Drain", "Shield", "Poison", "Recharge"}
            local spell = choose(options, active_effect, player.MP)
            if spell then
                player.MP = player.MP - spells[spell].cost
            end
            if spell == "Magic_Missile" then
                boss.HP = boss.HP - spells[spell].dmg
            elseif spell == "Drain" then
                player.HP, boss.HP = player.HP + 2, boss.HP - 2
            elseif spell == "Shield" then
                active_effect[spell] = spells[spell].timer
            elseif spell == "Poison" then
                active_effect[spell] = spells[spell].timer
            elseif spell == "Recharge" then
                active_effect[spell] = spells[spell].timer
            else
                break
            end
            if boss.HP <= 0 then
                break
            end
        else --boss turn
            print("boss turn:")
            print("player HP:" .. player.HP .. ", player MP:" .. player.MP)
            print("boss HP:" .. boss.HP)
            local adef = 0
            --effects
            for i, s in pairs(active_effect) do
                if i == "Shield" then
                    adef = effects[i].def
                elseif i == "Poison" then
                    boss.HP = boss.HP - effects[i].dmg
                elseif i == "Recharge" then
                    player.MP = player.MP + effects[i].MP
                end
                if s - 1 > 0 then
                    active_effect[i] = s - 1
                else
                    active_effect[i] = nil
                end
            end
            if boss.HP <= 0 then
                break
            end
            player.HP = player.HP - damage(boss.atk, player.def + adef)
            if player.HP <= 0 then break end
        end
        turn = turn + 1
    end
    if boss.HP <= 0 then
        print("player win")
    elseif player.HP <= 0 then
        print("player lose by HP")
    else
        print("player lose by MP")
    end
end
--game()
