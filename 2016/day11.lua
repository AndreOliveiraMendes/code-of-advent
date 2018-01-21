--[[
    The first floor contains a strontium generator, a strontium-compatible microchip, a plutonium generator, and a plutonium-compatible microchip.
    The second floor contains a thulium generator, a ruthenium generator, a ruthenium-compatible microchip, a curium generator, and a curium-compatible microchip.
    The third floor contains a thulium-compatible microchip.
    The fourth floor contains nothing relevant.
    4
    3   TC                  1   17
    2   TG, RG, RM, CG, CM  5   15
    1   SG, SM, PG, PM      4   5
--]]
floor = {{"SG", "SM", "PG", "PM"}, {"TG", "RG", "RM", "CG", "CM"}, {"TC"}, {}}
function debug(floor)
    for i, s in pairs(floor) do
        print(i, table.unpack(s))
    end
end
M = {}
for i = 1, 4 do
    M[i] = #floor[i]
end
s = 0
for i = 1, 3 do
    s = s + 2*M[i] - 3
    M[i + 1], M[i] = M[i + 1] + M[i], 0
end
print("estimatited steps:" .. s)
table.insert(floor[1], "EG")
table.insert(floor[1], "EM")
table.insert(floor[1], "DG")
table.insert(floor[1], "DM")
M = {}
for i = 1, 4 do
    M[i] = #floor[i]
end
s = 0
for i = 1, 3 do
    s = s + 2*M[i] - 3
    M[i + 1], M[i] = M[i + 1] + M[i], 0
end
print("estimatited steps:" .. s)
