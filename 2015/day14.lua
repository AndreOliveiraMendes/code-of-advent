com = {}
for line in io.lines() do
    local name = string.match(line, "%w+")
    local t = {}
    for d in string.gmatch(line, "%d+") do
        table.insert(t, tonumber(d))
    end
    local v, ft, rt = table.unpack(t)
    table.insert(com, {name, v, ft, rt})
end
function race(total_time, mode)
    local winner, winnerdist
    local race = {}
    for i, s in pairs(com) do
        local t = {}
        t.name = s[1]
        t.distance = 0
        t.vel = s[2]
        t.ft = s[3]
        t.rt = s[4]
        t.cr = i
        t.score = 0
        t.state = true --true = rested/can fly, false = may rest
        table.insert(race, t)
    end
    for race_time = 1, total_time do
        for i, s in pairs(race) do
            if s.state then
                s.distance = s.distance + s.vel
                s.ft = s.ft - 1
                if s.ft == 0 then
                    s.rt = com[s.cr][4]
                    s.state = false
                end
            else
                s.rt = s.rt - 1
                if s.rt == 0 then
                    s.ft = com[s.cr][3]
                    s.state = true
                end
            end
        end
        if mode then
            local maxd
            for i, s in pairs(race) do
                if not maxd or s.distance > maxd then maxd = s.distance end
            end
            for i, s in pairs(race) do
                if s.distance == maxd then
                    s.score = s.score + 1
                end
            end
        end
    end
    if not mode then
        for i, s in pairs(race) do
            if not winnerdist or s.distance > winnerdist then
                winnerdist = s.distance
                winner = {}
                table.insert(winner, s.name)
            elseif s.distance == winnerdist then
                table.insert(winner, s.name)
            end
        end
        return winnerdist, winner
    else
        for i, s in pairs(race) do
            if not winnerdist or s.score > winnerdist then
                winnerdist = s.score
                winner = {}
                table.insert(winner, s.name)
            elseif s.score == winnerdist then
                table.insert(winner, s.name)
            end
        end
        return winnerdist, winner
    end
end
dt, winner = race(2503)
print(string.format("the winner(s) of race is " .. table.concat(winner,", ") .. " wich traveled a distance of %d", dt))
dt, winner = race(2503, true)
print("aplyng new rule")
print(string.format("the winner(s) of race is " .. table.concat(winner,", ") .. " wich total point of %d", dt))
