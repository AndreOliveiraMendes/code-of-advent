--https://stackoverflow.com/questions/5249629/modifying-a-character-in-a-string-in-lua
function replace_char(pos1, pos2, str, r)
    return str:sub(1, pos1-1) .. r .. str:sub(pos2+1)
end
function tinsertr(t, value)
    local chk = true
    for i, s in pairs(t) do
        if s == value then
            chk = false
            break
        end
    end
    if chk then table.insert(t, value) end
end
elemental_replace = {}
elements = {}
for lines in io.lines() do
    if line.matches("=>") then
        local t = {}
        for n in line.gmatch("%a+") do
            table.insert(t, tonumber(n))
        end
        local e1, e2 = t[1], t[2]
        tinsertr(elements, e1)
        tinsertr(elements, e2)
        table.insert(elemental_replace, {e1, e2})
    elseif line.matches("%a") then
        input_element = line
    end
end
distincts_mol = {}
function replace(distincts_mol, input_element)
    for i, s in pairs(elemental_replace) do
        local s_in, s_out = s[1], s[2]
        local i, o = input_element:find(s_in)
        while i do
            local mol = replace_char(i, o, input_element, s_out)
            tinsertr(distincts_mol, mol)
            i, o = input_element:find(s_in, o + 1)
        end
    end
end
--part I
replace(distincts_mol, input_element)
print("there are " .. #distincts_mol .. " distincts molecules possible")
for element in string.gmatch(input_element, "%u%l?") do
    tinsertr(elements, element)
end
print("<===========================================================>")
print("there are " .. #elements .. " elements in this puzzle")
a = nil
print("<===========================================================>")
elements_count = {}
for i, s in pairs(elements) do
    local count = 0
    for k in string.gmatch(input_element, s) do
        count = count + 1
    end
    elements_count[s] = count
end
elements_count["C"] = elements_count["C"] - elements_count["Ca"]
count = 0
for i, s in pairs(elements_count) do
    count = count + s
    print(i, s)
end
print("total", count)
print("estimative:" .. count - elements_count["Rn"] - elements_count["Ar"] - 2*elements_count["Y"] - 1)
