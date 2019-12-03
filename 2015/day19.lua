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
inv_elemental_replace = {}
elements = {}
for line in io.lines() do
    if line:match("=>") then
        local t = {}
        for n in line:gmatch("%a+") do
            table.insert(t, n)
        end
        local e1, e2 = t[1], t[2]
        tinsertr(elements, e1)
        tinsertr(elements, e2)
        table.insert(elemental_replace, {e1, e2})
        table.insert(inv_elemental_replace, {e2, e1})
    elseif line:match("%a") then
        input_element = line
    end
end
distincts_mol = {}
function replace(distincts_mol, input_element, elemental_replace)
    for i, s in pairs(elemental_replace) do
        local s_in, s_out = s[1], s[2]
        local i, o = input_element:find(s_in)
        while i do
            local mol = replace_char(i, o, input_element, s_out)
            tinsertr(distincts_mol, mol)
            i, o = input_element:find(s_in, i + 1)
        end
    end
end
--part I
replace(distincts_mol, input_element, elemental_replace)
print("there are " .. #distincts_mol .. " distincts molecules possible")
memory = {}
function find(input_element, output_element, elemental_replace, memory)
    local step
    for i, s in pairs(elemental_replace) do
        local s_in, s_out = s[1], s[2]
        local i, o = input_element:find(s_in)
        while i do
            local mol = replace_char(i, o, input_element, s_out)
            if mol == output_element then
                return 1
            end
            local out
            if memory and memory[mol] then
                out = memory[mol]
            else
                out = find(mol, output_element, elemental_replace, memory)
                memory[mol] = out
            end
            out = (out > 0) and (out + 1) or 0
            --print(mol, out)
            if (out > 0) and (not step or out < step) then
                step = out
            end
            i, o = input_element:find(s_in, i + 1)
        end
    end
    if step then
        return step
    else
        if memory then memory[input_element] = 0 end
        return 0
    end
end
print("min number of steps is " .. find(input_element, "e", inv_elemental_replace, memory))
