input = 681901
scores, elf_1, elf_2 = {3, 7}, 1, 2
function move(i, scores)
	local r = scores[i] + 1
	r = r%#scores
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
		s = s%10
	end
	table.insert(scores, s)
	elf_1, elf_2 = move(elf_1, scores), move(elf_2, scores)
end
--part i
print("answer:" .. table.concat(scores, "", input + 1, input + 10))
