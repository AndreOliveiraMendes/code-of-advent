input = [[Dancer can fly 27 km/s for 5 seconds, but then must rest for 132 seconds.
Cupid can fly 22 km/s for 2 seconds, but then must rest for 41 seconds.
Rudolph can fly 11 km/s for 5 seconds, but then must rest for 48 seconds.
Donner can fly 28 km/s for 5 seconds, but then must rest for 134 seconds.
Dasher can fly 4 km/s for 16 seconds, but then must rest for 55 seconds.
Blitzen can fly 14 km/s for 3 seconds, but then must rest for 38 seconds.
Prancer can fly 3 km/s for 21 seconds, but then must rest for 40 seconds.
Comet can fly 18 km/s for 6 seconds, but then must rest for 103 seconds.
Vixen can fly 18 km/s for 5 seconds, but then must rest for 84 seconds.]]
com = {}
for line in string.gmatch(input, "%C+") do
    local name = string.match(line, "%w+")
    local v, ft, rt
    for d in string.gmatch(line, "%d+") do
        if not v then v = d elseif not ft then ft = d else rt = d end
    end
    table.insert(com, {name, v, ft, rt})
end
function race(total_time)
    local winner, winnerdist = {}
    local race = {}
    for i, s in pairs(com) do
        local t = {}
        t.name = s[1]
        t.distance = 0
        t.vel = s[2]
        t.ft = s[3]
        t.rt = s[4]
        t.cr = i
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
    end
    for i, s in pairs(race) do
        if not winnerdist or s.distance > winnerdist then
            winnerdist = s.distance
            table.insert(winner, s.name)
        end
    end
    return winnerdist, table.unpack(winner)
end
dt, winner = race(2503)
print(string.format("the winner of race is " .. winner .. " wich traveled a distance of %d", dt))
