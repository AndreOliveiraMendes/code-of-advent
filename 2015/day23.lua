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
input = {}
for line in io.lines() do
	local t = {}
	if line:match("hlf") then
		local r = line:sub(line:find(" ") + 1)
		table.insert(t, hlf)
		table.insert(t, r)
	elseif line:match("tpl") then
		local r = line:sub(line:find(" ") + 1)
		table.insert(t, tpl)
		table.insert(t, r)
	elseif line:match("inc") then
		local r = line:sub(line:find(" ") + 1)
		table.insert(t, inc)
		table.insert(t, r)
	elseif line:match("jmp") then
		local r = line:sub(line:find(" ") + 1)
		r = tonumber(r) or r
		table.insert(t, jmp)
		table.insert(t, r)
	elseif line:match("jie") then
		local p1 = line:sub(line:find(" ") + 1, line:find(",") - 1)
		local p2 = line:sub(line:find(",") + 1)
		p1 = tonumber(p1) or p1
		p2 = tonumber(p2) or p2
		table.insert(t, jie)
		table.insert(t, p1)
		table.insert(t, p2)
	elseif line:match("jio") then
		local p1 = line:sub(line:find(" ") + 1, line:find(",") - 1)
		local p2 = line:sub(line:find(",") + 1)
		p1 = tonumber(p1) or p1
		p2 = tonumber(p2) or p2
		table.insert(t, jio)
		table.insert(t, p1)
		table.insert(t, p2)
	else
		print("error")
	end
	table.insert(input, t)
end
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
