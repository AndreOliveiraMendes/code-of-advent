input = io.read()
str = input
function update(s)
	local	function fsub(...)
			local min, max = string.byte("a"), string.byte("z")
			local arg = {...}
			local n = #arg
			for i = n, 1, -1 do
				local byte = arg[i]:byte()
				if byte + 1 <= max then
					arg[i] = string.char(byte + 1)
					break
				else
					arg[i] = string.char(min)
				end
			end
			return table.concat(arg)
		end
	local str = string.gsub(s, string.rep("(%w)", #str), fsub)
	return str
end
function rule1(str) --check for "increasing" like abc, bcd, cde, ... etc
	for i = 1, #str - 2 do
		local i, j, k = string.sub(str, i, i + 2):byte(1, 3)
		if (j == i + 1) and (k == j + 1) then return true end
	end
	return false
end
function rule2(str) --don't contaim i, o or l
	return not string.find(str, "i") and not string.find(str, "o") and not string.find(str, "l")
end
function rule3(str) --contaim doubles
	local d1
	for i = 1, #str - 1 do
		local s = string.sub(str, i, i + 1)
		if string.sub(s, 1, 1) == string.sub(s, 2, 2) then
			if not d1 then
				d1 = s
			elseif d1 ~= s then
				return true
			end
		end
	end
	return false
end
function valid(str) --check a string
	return rule1(str) and rule2(str) and rule3(str)
end
while not valid(str) do
	str = update(str)
end
print("the new password is:" .. str)
local chk = true
while chk or not valid(str) do
	if chk then chk = false end
	str = update(str)
end
print("the new password is:" .. str)
