input = 681901
scores, elf_1, elf_2 = {3, 7}, 1, 2
function move(i, scores)
	local r = (scores[i] + 1)%#scores
	i = i + r
	while (i > #scores) or (i < 1) do
		i = (i > #scores) and (i - #scores) or (i + #scores)
	end
	return i
end
while #scores < input + 10 do
	local s = scores[elf_1] + scores[elf_2]
	if s >= 10 then
		table.insert(scores, s//10)
	end
	table.insert(scores, s%10)
	elf_1, elf_2 = move(elf_1, scores), move(elf_2, scores)
end
print("answer 1:" .. table.concat(scores, "", input + 1, input + 10)) --part i
scores, elf_1, elf_2 = {3, 7}, 1, 2
v, ach, ref = "", false, tostring(input)
while true do
	if v == "" then
		v = (#v < #ref and v or v:sub(2)) .. "3"
		ach = (v == ref) or ach
		v = (#v < #ref and v or v:sub(2)) .. "7"
		ach = (v == ref) or ach
	end
	local s = scores[elf_1] + scores[elf_2]
	if s >= 10 then
		table.insert(scores, s//10)
		v = (#v < #ref and v or v:sub(2)) .. tostring(s//10)
		ach = (v == ref) or ach
	end
	table.insert(scores, s%10)
	v = (#v < #ref and v or v:sub(2)) .. tostring(s%10)
	ach = (v == ref) or ach
	elf_1, elf_2 = move(elf_1, scores), move(elf_2, scores)
	if ach then break end
end
s = table.concat(scores, "")
local i = s:find(ref)
print("answer 2:" .. (i and #s:sub(1, i - 1) or "")) --part ii
