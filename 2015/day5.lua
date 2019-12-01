words = {}
while true do
    word = io.read()
    if not word then break end
    table.insert(words, word)
end
function checkvogals(str)
    local vogs = {}
    for vog in string.gmatch(str, "[aeiou]") do
        table.insert(vogs, vog)
        if #vogs >= 3 then
            return true
        end
    end
    return false
end
function checkdoubles(str)
    for i = 1, #str - 1 do
        local s1, s2 = string.sub(str, i, i), string.sub(str, i + 1, i + 1)
        if s1 == s2 then return true end
    end
    return false
end
function checkpoibiden(str)
    local poibidden = {"ab", "cd", "pq", "xy"}
    for i, s in ipairs(poibidden) do
        if string.find(str, s) then return false end
    end
    return true
end
function valid1(str)
    return checkvogals(str) and checkdoubles(str) and checkpoibiden(str)
end
count = 0
for i, s in ipairs(words) do
    if valid1(s) then
        count = count + 1
    end
end
--part I
print("there are " .. count .. " nice word(s)")
function checkpl(str)
    for i = 1, #str - 3 do
        local astr = string.sub(str, i, i + 1)
        local i1, i2 = string.find(str, astr, i + 2)
        if i1 then return true end
    end
    return false
end
function checkrepeated(str)
    for i = 1, #str - 2 do
        local s1, s2 = string.sub(str, i, i), string.sub(str, i + 2, i + 2)
        if s1 == s2 then return true end
    end
    return false
end
function valid2(str)
    return checkpl(str) and checkrepeated(str)
end  
count = 0
for i, s in ipairs(words) do
    if valid2(s) then
        count = count + 1
    end
end
--part II
print("now there are " .. count .. " nice word(s)")
