function cpy(v, r, list)
    if type(v) == "number" then
        list[r] = v
    else
        list[r] = list[v]
    end
end
function inc(r, list)
    list[r] = list[r] + 1
end
function dec(r, list)
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
input = {{cpy, 1, "a"},
{cpy, 1, "b"},
{cpy, 26, "d"},
{jnz, "c", 2},
{jnz, 1, 5},
{cpy, 7, "c"},
{inc, "d"},
{dec, "c"},
{jnz, "c", -2},
{cpy, "a", "c"},
{inc, "a"},
{dec, "b"},
{jnz, "b", -2},
{cpy, "c", "b"},
{dec, "d"},
{jnz, "d", -6},
{cpy, 19, "c"},
{cpy, 14, "d"},
{inc, "a"},
{dec, "d"},
{jnz, "d", -2},
{dec, "c"},
{jnz, "c", -5}}
varlist = {a = 0, b = 0, c = 0, d = 0}
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
    end
end
print("register a contaim:" .. varlist.a)
print(varlist.a, varlist.b, varlist.c, varlist.d)
varlist = {a = 0, b = 0, c = 1, d = 0}
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
    end
end
print("register a contaim:" .. varlist.a)
print(varlist.a, varlist.b, varlist.c, varlist.d)
--[[
    function equivalent
--]]
function main(a, b, c, d)
	a = 1
	b = 1
	d = 26
	if c ~= 0 then
		c = 7
		repeat
			d = d + 1
			c = c - 1
		until (c == 0)
	end
	repeat
		c = a
		repeat
			a = a + 1
			b = b - 1
		until (b == 0)
		b = c
		d = d - 1
	until (d == 0)
	c = 19
	repeat
		d = 14
		repeat
			a = a + 1
			d = d - 1
		until (d == 0)
		c = c - 1
	until (c == 0)
	return a, b, c, d
end
print(main(0, 0, 0, 0))
print(main(0, 0, 1, 0))
