input = io.read()
layers = {}
w, t = 25, 6
for i = 1, #input, w*t do
    local aux = {}
    local l = {}
    for j = 0, t - 1 do
        local sl = {}
        for k = 0, w - 1 do
            local num = tonumber(input:sub(i + k + w*j, i + k + w*j))
            table.insert(sl, num)
            aux[num] = aux[num] and (aux[num] + 1) or 1
        end
        table.insert(l, sl)
    end
    table.insert(layers, l)
    aux[0] = aux[0] or 0
    aux[1] = aux[1] or 0
    aux[2] = aux[2] or 0
    if not min_n0 or aux[0] < min_n0 then
        min_n0 = aux[0]
        res = aux[1]*aux[2]
    end
end
--part I
if res then
    print("answer = " .. res)
end
