--21
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
        if pass:find(s) > 4 then n = n + 1 end
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
t = {"a", "b", "c", "d", "e"}
function perm(t1, t2, list)
    if #t1 == 0 then
        table.insert(list, {table.unpack(t2)})
    else
        for i, s in pairs(t1) do
            table.remove(t1, i)
            table.insert(t2, s)
            perm(t1, t2, list)
            table.remove(t2, #t2)
            table.insert(t1, i, s)
        end
    end
end
perm_t = {}
perm(t, {}, perm_t)
print(#perm_t)
