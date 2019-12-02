refinput = [[children: 3
cats: 7
samoyeds: 2
pomeranians: 3
akitas: 0
vizslas: 0
goldfish: 5
trees: 3
cars: 2
perfumes: 1]]
ref = {}
i = 1
for w in string.gmatch(refinput, "%w+") do
    if i == 1 then
        local t = {}
        t[w] = 0
        lstr = w
        i = 2
    else
        ref[lstr] = tonumber(w)
        lstr = nil
        i = 1
    end
end
comp = {}
for line in io.lines() do
    local temp2 = {}
    for w in string.gmatch(line, "%w+") do
        table.insert(temp2, w)
    end
    local t = {}
    t.name = temp2[1]
    t.ind = tonumber(temp2[2])
    for i = 3, #temp2, 2 do
        t[temp2[i]] = tonumber(temp2[i + 1])
    end
    table.insert(comp, t)
end
for i, s in pairs(comp) do
    local count = 0
    local mcount = 0
    for n, v in pairs(s) do
        if n ~= "name" and n ~= "ind" then
            count = count + 1
            if ref[n] == v then mcount = mcount + 1 end
        end
    end
    if mcount == count then index = s.ind end
end
print("the sue that sent the gift was " .. index)
for i, s in pairs(comp) do
    local count = 0
    local mcount = 0
    for n, v in pairs(s) do
        if n ~= "name" and n ~= "ind" then
            count = count + 1
            if n == "cats" or n == "trees" then
                if v > ref[n] then mcount = mcount + 1 end
            elseif n == "pomeranians" or n == "goldfish" then
                if v < ref[n] then mcount = mcount + 1 end
            else
                if v == ref[n] then mcount = mcount + 1 end
            end
        end
    end
    if mcount == count then index = s.ind end
end
print("the real sue that sent the gift was " .. index)
