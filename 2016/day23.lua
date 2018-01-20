function cpy(v, r, list)
    if type(r) == "number" then return end
    if type(v) == "number" then
        list[r] = v
    else
        list[r] = list[v]
    end
end
function inc(r, list)
    if type(r) == "number" then return end
    list[r] = list[r] + 1
end
function dec(r, list)
    if type(r) == "number" then return end
    list[r] = list[r] - 1
end
function jnz(v, r, list, i)
    local com, jmp
    if type(v) == "number" then
        com = v
    else
        com = list[v]
    end
    if type(r) == "number" then
        jmp = r
    else
        jmp = list[r]
    end
    if com ~= 0 then
        return i + jmp
    else
        return i + 1
    end
end
function isf(f, ...)
    for _, g in pairs({...}) do
        if f == g then
            return true
        end
    end
    return false
end
function tgl(v, list, i, op_list)
    local jump
    if type(v) == "number" then
        jump = v
    else
        jump = list[v]
    end
    if op_list[i + jump] then
        if op_list[i + jump][1] == inc then
            op_list[i + jump][1] = dec
        elseif op_list[i + jump][1] == dec or op_list[i + jump][1] == tgl then
            op_list[i + jump][1] = inc
        elseif op_list[i + jump][1] == cpy then
            op_list[i + jump][1] = jnz
        elseif op_list[i + jump][1] == jnz then
            op_list[i + jump][1] = cpy
        end
    end
end
input = {{cpy, "a", "b"},
{dec, "b"},
{cpy, "a", "d"},
{cpy, 0, "a"},
{cpy, "b", "c"},
{inc, "a"},
{dec, "c"},
{jnz, "c", -2},
{dec, "d"},
{jnz, "d", -5},
{dec, "b"},
{cpy, "b", "c"},
{cpy, "c", "d"},
{dec, "d"},
{inc, "c"},
{jnz, "d", -2},
{tgl, "c"},
{cpy, -16, "c"},
{jnz, 1, "c"},
{cpy, 81, "c"},
{jnz, 92, "d"},
{inc, "a"},
{inc, "d"},
{jnz, "d", -2},
{inc, "c"},
{jnz, "c", -5}}
varlist = {a = 7, b = 0, c = 0, d = 0}
i = 1
while (i > 0 and i <= #input) do
    local f, p1, p2 = table.unpack(input[i])
    if isf(f, inc, dec) then
        f(p1, varlist)
        i = i + 1
    elseif isf(f, cpy) then
        f(p1, p2, varlist)
        i = i + 1
    elseif isf(f, jnz) then
        i = f(p1, p2, varlist, i)
    elseif isf(f, tgl) then
        f(p1, varlist, i, input)
        i = i + 1
    end
end
print("done")
print(varlist.a, varlist.b, varlist.c, varlist.d)
input = {{cpy, "a", "b"},
{dec, "b"},
{cpy, "a", "d"},
{cpy, 0, "a"},
{cpy, "b", "c"},
{inc, "a"},
{dec, "c"},
{jnz, "c", -2},
{dec, "d"},
{jnz, "d", -5},
{dec, "b"},
{cpy, "b", "c"},
{cpy, "c", "d"},
{dec, "d"},
{inc, "c"},
{jnz, "d", -2},
{tgl, "c"},
{cpy, -16, "c"},
{jnz, 1, "c"},
{cpy, 81, "c"},
{jnz, 92, "d"},
{inc, "a"},
{inc, "d"},
{jnz, "d", -2},
{inc, "c"},
{jnz, "c", -5}}
varlist = {a = 12, b = 0, c = 0, d = 0}
i = 1
while (i > 0 and i <= #input) do
    local f, p1, p2 = table.unpack(input[i])
    if isf(f, inc, dec) then
        f(p1, varlist)
        i = i + 1
    elseif isf(f, cpy) then
        f(p1, p2, varlist)
        i = i + 1
    elseif isf(f, jnz) then
        i = f(p1, p2, varlist, i)
    elseif isf(f, tgl) then
        f(p1, varlist, i, input)
        i = i + 1
    end
end
print("done")
print(varlist.a, varlist.b, varlist.c, varlist.d)
