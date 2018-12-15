players = 430
fm = 71588
score = {}
for p = 1, players do
    score[p] = 0
end
debug = false
function lprint(root)
    local str = ""
    if root then
        str = str .. root.value
        next = root.next
        while next do
            str = str .. " " .. next.value
            next = next.next
        end
    else
        str = str .. "no linked list"
    end
    print(current.value, str)
end
for m = 0, 100*fm do
    if m == 0 then
        previous, current, next = nil, {}, nil
        current.value = m
        root = current
        player = 1
    else
        if m%23 == 0 then
            for i = 1, 7 do
                if not current.previous then
                    while current.next do
                        previous, current, next = current, current.next, current.next.next
                    end
                else
                    previous, current, next = current.previous.previous , current.previous, current
                end
            end
            score[player] = score[player] + current.value + m
            if previous then
                previous.next = next
            else
                root = next
            end
            current = next
            if next then
                next.previous = previous
            end
        else
            for i = 1, 1 do
                if not current.next then
                    previous, current, next = nil, root, root.next
                else
                    previous, current, next = current, current.next, current.next.next
                end
            end
            local p = {}
            p.value = m
            previous, current = current, p
            previous.next = p
            p.previous = previous
            if next then
                p.next = next
                next.previous = p
            end
        end
        player = (player + 1 > players) and 1 or (player + 1)
    end
    if debug then lprint(root) end
    if m == fm then
        max = 0
        for i, s in pairs(score) do
            max = math.max(max, s)
        end
        print("max value for " .. fm .. " marbles is " .. max)
    end
end
max = 0
for i, s in pairs(score) do
    max = math.max(max, s)
end
print("max value for " .. 100*fm .. " is " .. max)
