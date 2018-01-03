function hlf(v, varlist)
    varlist[v] = varlist[v]/2
end
function tpl(v, varlist)
    varlist[v] = varlist[v]*3
end
function inc(v, varlist)
    varlist[v] = varlist[v] + 1
end
function jmp(v, i, varlist)
    if type(v) == "number" then
        return i + v
    else
        return i + varlist[v]
    end
end
function jie(v1, v2, i, varlist)
    if varlist[v1] % 2 == 0 then
        return i + v2
    else
        return i + 1
    end
end
function jio(v1, v2, i, varlist)
    if varlist[v1] == 1 then
        return i + v2
    else
        return i + 1
    end
end
input = {{jio,"a", 18},
{inc, "a"},
{tpl, "a"},
{inc, "a"},
{tpl, "a"},
{tpl, "a"},
{tpl, "a"},
{inc, "a"},
{tpl, "a"},
{inc, "a"},
{tpl, "a"},
{inc, "a"},
{inc, "a"},
{tpl, "a"},
{tpl, "a"},
{tpl, "a"},
{inc, "a"},
{jmp, 22},
{tpl, "a"},
{inc, "a"},
{tpl, "a"},
{inc, "a"},
{inc, "a"},
{tpl, "a"},
{inc, "a"},
{tpl, "a"},
{inc, "a"},
{inc, "a"},
{tpl, "a"},
{tpl, "a"},
{inc, "a"},
{inc, "a"},
{tpl, "a"},
{inc, "a"},
{inc, "a"},
{tpl, "a"},
{inc, "a"},
{inc, "a"},
{tpl, "a"},
{jio, "a", 8},
{inc, "b"},
{jie, "a", 4},
{tpl, "a"},
{inc, "a"},
{jmp, 2},
{hlf, "a"},
{jmp, -7}}
function isfunc(f,...)
    local arg = {...}
    for i, s in pairs(arg) do
        if s == f then
            return true
        end
    end
    return false
end
varlist = {a = 0, b = 0}
i = 1
while i >= 1 and i <= #input do
    local f, v1, v2 = table.unpack(input[i])
    if isfunc(f, hlf, tpl, inc) then
        f(v1, varlist)
        i = i + 1
    elseif isfunc(f, jmp) then
        i = f(v1, i, varlist)
    elseif isfunc(f, jio, jie) then
        i = f(v1, v2, i, varlist)
    end
end
print("done")
print("the value on register b is " .. varlist.b)
print("a starting to 1 instead")
varlist = {a = 1, b = 0}
i = 1
while i >= 1 and i <= #input do
    local f, v1, v2 = table.unpack(input[i])
    if isfunc(f, hlf, tpl, inc) then
        f(v1, varlist)
        i = i + 1
    elseif isfunc(f, jmp) then
        i = f(v1, i, varlist)
    elseif isfunc(f, jio, jie) then
        i = f(v1, v2, i, varlist)
    end
end
print("done")
print("the value on register b is " .. varlist.b)
