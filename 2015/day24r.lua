input = "1 2 3 5 7 13 17 19 23 29 31 37 41 43 53 59 61 67 71 73 79 83 89 97 101 103 107 109 113"
packages = {}
for d in string.gmatch(input, "%d+") do
    table.insert(packages, tonumber(d))
end
function combos(set, count)
    local pos = {}

    return function()
        if #pos == 0 then
            for i=1, count do pos[i] = i end
        elseif pos[1] == #set - count + 1 then
            return nil
        else
            local movable = nil
            local max = #set
            for i=#pos, 1, -1 do
                if pos[i] < max then movable = i; break end
                max = max - 1
            end

            pos[movable] = pos[movable] + 1
            local curr = pos[movable]
            for i=movable+1, #pos do
                pos[i] = curr + 1
                curr = curr + 1
            end
        end

        local t = {}
        for _,i in ipairs(pos) do t[#t+1]=set[i] end
        return t
    end
end

function stats(combo)
    local p,s = 1,0
    for _, w in ipairs(combo) do
        p = p * w
        s = s + w
    end

    return s,p
end

function find_best(packages, goal)
    best = math.huge

    for len = 1, #packages do
        for c in combos(packages, len) do
            local s,p = stats(c)
            if s == goal then
                best = math.min(best, p)
            end
        end

        if best < math.huge then return best end
    end
end

part1 = find_best(packages, stats(packages) / 3)
print("Part 1:", part1)
--10723906903

part2 = find_best(packages, stats(packages) / 4)
print("Part 2:", part2)
--74850409
