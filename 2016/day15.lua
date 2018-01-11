input = [[Disc #1 has 7 positions; at time=0, it is at position 0.
Disc #2 has 13 positions; at time=0, it is at position 0.
Disc #3 has 3 positions; at time=0, it is at position 2.
Disc #4 has 5 positions; at time=0, it is at position 2.
Disc #5 has 17 positions; at time=0, it is at position 0.
Disc #6 has 19 positions; at time=0, it is at position 7.]]
discs = {}
for line in input:gmatch("%C+") do
    local mpos, cpos = line:match("%d+ positions"):match("%d+"), line:match("position %d+"):match("%d")
    table.insert(discs, {pos_lim = mpos, pos_0 = cpos})
end
t = 0
function f(t)
    local chk = false
    for i, s in pairs(discs) do
        if (s.pos_0 + i + t)%s.pos_lim ~= 0 then
            return false
        end
    end
    return true
end
while true do
    if f(t) then
        t1 = t
        break
    end
    t = t + 1
end
print("the time to pless the button is " .. tostring(t1) .. "s")
