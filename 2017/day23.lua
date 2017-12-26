--[[
    function table.unpack(t,i)
        if not i then
            return t[1], table.unpack(t, 2)
        elseif i < #t then
            return t[i], table.unpack(t, i + 1)
        else
            return t[i]
        end
    end
--]]
function set(v1, v2, list)
    if type(v2) == "number" then
        list[v1] = v2
    else
        list[v1] = list[v2]
    end
end
function sub(v1, v2, list)
    if type(v2) == "number" then
        list[v1] = list[v1] - v2
    else
        list[v1] = list[v1] - list[v2]
    end
end
function mul(v1, v2, list)
    if type(v2) == "number" then
        list[v1] = list[v1] * v2
    else
        list[v1] = list[v1] * list[v2]
    end
end
function jnz(v1, v2, list, i)
    local com, val
    if type(v1) == "number" then
        com = v1
    else
        com = list[v1]
    end
    if type(v2) == "number" then
        val = v2
    else
        val = list[v2]
    end
    if com ~= 0 then
        return i + val
    else
        return i + 1
    end
end
input = {{set, "b", 65},
{set, "c", "b"},
{jnz, "a", 2},
{jnz, 1, 5},
{mul, "b", 100},
{sub, "b", -100000},
{set, "c", "b"},
{sub, "c", -17000},
{set, "f", 1},
{set, "d", 2},
{set, "e", 2},
{set, "g", "d"},
{mul, "g", "e"},
{sub, "g", "b"},
{jnz, "g", 2},
{set, "f", 0},
{sub, "e", -1},
{set, "g", "e"},
{sub, "g", "b"},
{jnz, "g", -8},
{sub, "d", -1},
{set, "g", "d"},
{sub, "g", "b"},
{jnz, "g", -13},
{jnz, "f", 2},
{sub, "h", -1},
{set, "g", "b"},
{sub, "g", "c"},
{jnz, "g", 2},
{jnz, 1, 3},
{sub, "b", -17},
{jnz, 1, -23}}
function isfunc(f, ...)
    local arg = {...}
    for i, fs in pairs(arg) do
        if f == fs then return true end
    end
    return false
end
--part I
i = 1
varlist = {a = 0, b = 0, c = 0, d = 0, e = 0, f = 0, g = 0, h = 0}
countmul = 0
while i >= 1 and i <= #input do
    local f, v1, v2 = table.unpack(input[i])
    if isfunc(f,set,sub,mul) then
        if isfunc(f,mul) then
            countmul = countmul + 1
        end
        f(v1, v2, varlist)
    end
    if isfunc(f, jnz) then
        i = f(v1,v2,varlist,i)
    else
        i = i + 1
    end
end
print("part I")
print("mul was invoked " .. countmul .. " times")
