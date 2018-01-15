input = "^..^^.^^^..^^.^...^^^^^....^.^..^^^.^.^.^^...^.^.^.^.^^.....^.^^.^.^.^.^.^.^^..^^^^^...^.....^....^."
function solve(s)
    local map = {}
    local   function f(x, y)
                return x ~= y
            end
    for i = 1, s do
        map[i] = {}
        if i == 1 then
            for j = 1, #input do
                if input:sub(j, j) == "^" then
                    table.insert(map[i], 1)
                else
                    table.insert(map[i], 0)
                end
            end
        else
            local old_map = map[i - 1]
            for j = 1, #old_map do
                local left, right = (j == 1) and 0 or old_map[j - 1], (j == #old_map) and 0 or old_map[j + 1]
                if f(left, right) then
                    map[i][j] = 1
                else
                    map[i][j] = 0
                end
            end
        end
    end
    local safe = 0
    for i = 1, s do
        --print(table.concat(map[i]))
        for j = 1, #map[i] do
            if map[i][j] == 0 then
                safe = safe + 1
            end
        end
    end
    return safe
end
print("there are " .. solve(40) .. " safe tiles on 40 rows")
print("there are " .. solve(400000) .. " safe tiles on 400000 rows")
