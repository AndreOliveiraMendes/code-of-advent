local turing_machine = {}
state = "A"
x = 0
function action(stat, x, list)
    if stat == "A" then
        if list[x] == 0 then
            list[x] = 1
            return "B", x + 1
        else
            list[x] = 0
            return "C", x - 1
        end
    elseif state == "B" then
        if list[x] == 0 then
            list[x] = 1
            return "A", x - 1
        else
            list[x] = 1
            return "D", x + 1
        end
    elseif state == "C" then
        if list[x] == 0 then
            list[x] = 1
            return "A", x + 1
        else
            list[x] = 0
            return "E", x - 1
        end
    elseif state == "D" then
        if list[x] == 0 then
            list[x] = 1
            return "A", x + 1
        else
            list[x] = 0
            return "B", x + 1
        end
    elseif state == "E" then
        if list[x] == 0 then
            list[x] = 1
            return "F", x - 1
        else
            list[x] = 1
            return "C", x - 1
        end
    elseif state == "F" then
        if list[x] == 0 then
            list[x] = 1
            return "D", x + 1
        else
            list[x] = 1
            return "A", x + 1
        end
    end
end
for i = 1, 12173597 do
    if not turing_machine[x] then turing_machine[x] = 0 end
    state, x = action(state, x, turing_machine)
    if not max or x > max then max = x end
    if not min or x < min then min = x end
end
sum = 0
for x = min, max do
    sum = sum + (turing_machine[x] and turing_machine[x] or 0)
end
print("checksum:" .. sum)
