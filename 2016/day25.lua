function main(a, b, c, d, n)
    local outlist = {}
	d = a + 362*7
	while true do
		a = d
		repeat
			b = a
			a, b= (b - b%2)/2, (b%2)|0
			table.insert(outlist, b)
			if #outlist >= n then return outlist end
		until a == 0
	end
end
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
function out(v, varlist, outlist)
    if type(v) == "number" then
        table.insert(outlist, v)
    else
        table.insert(outlist, varlist[v])
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
input = {{cpy, "a", "d"},
    {cpy, 7, "c"},
    {cpy, 362, "b"},
    {inc, "d"},
    {dec, "b"},
    {jnz, "b", -2},
    {dec, "c"},
    {jnz, "c", -5},
    {cpy, "d", "a"},
    {jnz, 0, 0},
    {cpy, "a", "b"},
    {cpy, 0, "a"},
    {cpy, 2, "c"},
    {jnz, "b", 2},
    {jnz, 1, 6},
    {dec, "b"},
    {dec, "c"},
    {jnz, "c", -4},
    {inc, "a"},
    {jnz, 1, -7},
    {cpy, 2, "b"},
    {jnz, "c", 2},
    {jnz, 1, 4},
    {dec, "b"},
    {dec, "c"},
    {jnz, 1, -4},
    {jnz, 0, 0},
    {out, "b"},
    {jnz, "a", -19},
    {jnz, 1, -21}
}
function system(a, n)
    local varlist = {a = a, b = 0, c = 0, d = 0}
    local outlist = {}
    local i = 1
    while (i > 0 and i <= #input) do
        local f, p1, p2 = table.unpack(input[i])
        if isf(f, inc, dec) then
            f(p1, varlist)
            i = i + 1
        elseif isf(f, add) then
            f(p1, p2, varlist)
            i = i + 1
        elseif isf(f, cpy) then
            f(p1, p2, varlist)
            i = i + 1
        elseif isf(f, jnz) then
            i = f(p1, p2, varlist, i)
        elseif isf(f, out) then
            f(p1, varlist, outlist)
            i = i + 1
        end
        if #outlist >= n then break end
    end
    return outlist
end
function system2(a, n)
    return main(a, 0, 0, 0, n)
end
function f(n, last)
    local a, b= (n - n%2)/2, (n%2)|0
    if not last then
        return f(a, 1 - b)
    else
        if b ~= last then return false end
        return (a == 0) or f(a, 1 - last)
    end
end
a = 0
while true do
    if f(a + 362*7) then
        break
    end
    a = a + 1
end
print("the min value for a is " .. a)
print(table.unpack(system2(a, 10)))
