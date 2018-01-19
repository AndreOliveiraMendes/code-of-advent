--21
input = [[swap position 4 with position 0
swap letter d with letter b
reverse positions 0 through 4
rotate left 1 step
move position 1 to position 4
move position 3 to position 0
rotate based on position of letter b
rotate based on position of letter d]]
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
            pass = pass:sub(1, p2 - 1) .. s .. pass:sub(p2)
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
for i, s in pairs(perm_t) do
    s = table.concat(s)
    local p = s
    for _, s in pairs(operation) do
        p = scrab(p, s)
    end
    print(i, s, p)
end
--14
local md5 = require 'md5'
input = 'qzyelonm'
i, key1, key2= 0, {}, {}
function f(str)
   for i = 1, #str - 2 do
      if str:sub(i, i) == str:sub(i + 1, i + 1)
         and str:sub(i + 1, i + 1) == str:sub(i + 2, i + 2) then
            return true, str:sub(i, i)
      end
   end
   return false
end
function g(str)
   for i = 1, 2016 do
      str = md5.sumhexa(str)
   end
   return str
end
queu1, queu2 = {}, {}
while #key1 < 64 or #key2 < 64 do
    print(i, #key1, #queu1, #key2, #queu2)
    --get md5
    local s1 = md5.sumhexa(input .. i)
    --manages queu list
    for _, p in pairs(queu1) do
       if not p.ded then
          if i > p.key + 1000 then
             p.ded = true
          else
             if #s1 - #s1:gsub(string.rep(p.char, 5), "") > 0 then
                p.ded = true
                p.valid = true
             end
          end
       end
    end
    --clean queu list also keys
    while queu1[1] and queu1[1].ded do
       if queu1[1].valid then
          table.insert(key1, queu1[1].key)
       end
       table.remove(queu1, 1)
    end
    local pk, ch = f(s1)
    if pk then
       --print(i, s1)
       table.insert(queu1, {char = ch, key = i})
    end
    --get md5
    if #key2 < 64 then
       local s2 = g(s1)
       --manages queu
       for _, p in pairs(queu2) do
          if not p.ded then
             if i > p.key + 1000 then
                p.ded = true
             else
                if #s2 - #s2:gsub(string.rep(p.char, 5), "") > 0 then
                   p.ded = true
                   p.valid = true
                end
             end
          end
       end
       --key process
       while queu2[1] and queu2[1].ded do
          if queu2[1].valid then
             table.insert(key2, queu2[1].key)
          end
          table.remove(queu2, 1)
       end
       pk, ch = f(s2)
       if pk then
          --print(i, s2)
          table.insert(queu2, {char = ch, key = i})
       end
    end
    i = i + 1
end
print("----")
for i, s in ipairs(key1) do
   print("key1 " .. i .. " is " .. s)
end
for i, s in ipairs(key2) do
   print("key2 " .. i .. " is " .. s)
end
--14 alternative version (another md5, but very fast)
md5 = require 'md5'
glue = require 'glue'
input = 'qzyelonm'
i, key1, key2= 0, {}, {}
function f(str)
   for i = 1, #str - 2 do
      if str:sub(i, i) == str:sub(i + 1, i + 1)
         and str:sub(i + 1, i + 1) == str:sub(i + 2, i + 2) then
            return true, str:sub(i, i)
      end
   end
   return false
end
function g(str)
   for i = 1, 2016 do
      str = glue.string.tohex(md5.sum(str))
   end
   return str
end
queu1, queu2 = {}, {}
while #key1 < 64 or #key2 < 64 do
    print(i, #key1, #queu1, #key2, #queu2)
    --get md5
    local s1 = glue.string.tohex(md5.sum(input .. i))
    --manages queu list
    for _, p in pairs(queu1) do
       if not p.ded then
          if i > p.key + 1000 then
             p.ded = true
          else
             if #s1 - #s1:gsub(string.rep(p.char, 5), "") > 0 then
                p.ded = true
                p.valid = true
             end
          end
       end
    end
    --clean queu list also keys
    while queu1[1] and queu1[1].ded do
       if queu1[1].valid then
          table.insert(key1, queu1[1].key)
       end
       table.remove(queu1, 1)
    end
    local pk, ch = f(s1)
    if pk then
       --print(i, s1)
       table.insert(queu1, {char = ch, key = i})
    end
    --get md5
    if #key2 < 64 then
       local s2 = g(s1)
       --manages queu
       for _, p in pairs(queu2) do
          if not p.ded then
             if i > p.key + 1000 then
                p.ded = true
             else
                if #s2 - #s2:gsub(string.rep(p.char, 5), "") > 0 then
                   p.ded = true
                   p.valid = true
                end
             end
          end
       end
       --key process
       while queu2[1] and queu2[1].ded do
          if queu2[1].valid then
             table.insert(key2, queu2[1].key)
          end
          table.remove(queu2, 1)
       end
       pk, ch = f(s2)
       if pk then
          --print(i, s2)
          table.insert(queu2, {char = ch, key = i})
       end
    end
    i = i + 1
end
print("----")
for i, s in ipairs(key1) do
   print("key1 " .. i .. " is " .. s)
end
for i, s in ipairs(key2) do
   print("key2 " .. i .. " is " .. s)
end
