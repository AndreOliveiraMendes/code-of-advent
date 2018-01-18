input = [[rotate based on position of letter a
swap letter g with letter d
move position 1 to position 5
reverse positions 6 through 7
move position 5 to position 4
rotate based on position of letter b
reverse positions 6 through 7
swap letter h with letter f
swap letter e with letter c
reverse positions 0 through 7
swap position 6 with position 4
rotate based on position of letter e
move position 2 to position 7
swap position 6 with position 4
rotate based on position of letter e
reverse positions 2 through 3
rotate right 2 steps
swap position 7 with position 1
move position 1 to position 2
move position 4 to position 7
move position 5 to position 0
swap letter e with letter f
move position 4 to position 7
reverse positions 1 through 7
rotate based on position of letter g
move position 7 to position 4
rotate right 6 steps
rotate based on position of letter g
reverse positions 0 through 5
reverse positions 0 through 7
swap letter c with letter f
swap letter h with letter f
rotate right 7 steps
rotate based on position of letter g
rotate based on position of letter c
swap position 1 with position 4
move position 7 to position 3
reverse positions 2 through 6
move position 7 to position 0
move position 7 to position 1
move position 6 to position 7
rotate right 5 steps
reverse positions 0 through 6
move position 1 to position 4
rotate left 3 steps
swap letter d with letter c
move position 4 to position 5
rotate based on position of letter f
rotate right 1 step
move position 7 to position 6
swap position 6 with position 0
move position 6 to position 2
rotate right 1 step
swap position 1 with position 6
move position 2 to position 6
swap position 2 with position 1
reverse positions 1 through 7
move position 4 to position 1
move position 7 to position 0
swap position 6 with position 7
rotate left 1 step
reverse positions 0 through 4
rotate based on position of letter c
rotate based on position of letter b
move position 2 to position 1
rotate right 0 steps
swap letter b with letter d
swap letter f with letter c
swap letter d with letter a
swap position 7 with position 6
rotate right 0 steps
swap position 0 with position 3
swap position 2 with position 5
swap letter h with letter f
reverse positions 2 through 3
rotate based on position of letter c
rotate left 2 steps
move position 0 to position 5
swap position 2 with position 3
rotate right 1 step
rotate left 2 steps
move position 0 to position 4
rotate based on position of letter c
rotate based on position of letter g
swap position 3 with position 0
rotate right 3 steps
reverse positions 0 through 2
move position 1 to position 2
swap letter e with letter c
rotate right 7 steps
move position 0 to position 7
rotate left 2 steps
reverse positions 0 through 4
swap letter e with letter b
reverse positions 2 through 7
rotate right 5 steps
swap position 2 with position 4
swap letter d with letter g
reverse positions 3 through 4
reverse positions 4 through 5]]
operation = {}
for line in input:gmatch("%C+") do
    table.insert(operation, line)
end
function scrab(pass, line)
    if line:match("swap position %d+ with position %d+") then
        local p1, p2 = tonumber(line:match("swap position %d+"):match("%d+")) + 1, tonumber(line:match("with position %d+"):match("%d+")) + 1
        local s1, s2 = pass:sub(p1, p1), pass:sub(p2, p2)
        pass = pass:gsub("%a", {[s1] = s2, [s2] = s1})
    elseif line:match("swap letter %a+ with letter %a+") then
        local s1, s2 = line:match("swap letter %a+"):sub(13), line:match("with letter %a+"):sub(13)
        pass = pass:gsub("%a", {[s1] = s2, [s2] = s1})
    elseif line:match("rotate left %d+ steps?") then
        local n = tonumber(line:match("%d+"))
        for i = 1, n do
            pass = pass:sub(2) .. pass:sub(1, 1)
        end
    elseif line:match("rotate right %d+ steps?") then
        local n = tonumber(line:match("%d+"))
        for i = 1, n do
            pass = pass:sub(#pass) .. pass:sub(1, #pass - 1)
        end
    elseif line:match("rotate based on position of letter %a+") then
        local s = line:match("letter %a+"):sub(8)
        local n = pass:find(s) - 1
        if n >= 4 then n = n + 1 end
        n = n + 1
        for i = 1, n do
            pass = pass:sub(#pass) .. pass:sub(1, #pass - 1)
        end
    elseif line:match("reverse positions %d+ through %d+") then
        local p1, p2 = tonumber(line:match("positions %d+"):match("%d+")) + 1, tonumber(line:match("through %d+"):match("%d+")) + 1
        pass = pass:sub(1, p1 - 1) .. pass:sub(p1, p2):reverse() .. pass:sub(p2 + 1)
    elseif line:match("move position %d+ to position %d+") then
        local p1, p2 = tonumber(line:match("move position %d+"):match("%d+")) + 1, tonumber(line:match("to position %d+"):match("%d+")) + 1
        local s = pass:sub(p1, p1)
        pass = pass:sub(1, p1 - 1) .. pass:sub(p1 + 1)
        if p2 == 1 then
            pass = s .. pass:sub(1)
        else
            pass = pass:sub(1, p2) .. s .. pass:sub(p2 + 1)
        end
    end
    return pass
end
string = "abcdefgh"
scrabed = string
for _, s in pairs(operation) do
    scrabed = scrab(scrabed, s)
end
print("the scrabed pasword is" .. scrabed)
