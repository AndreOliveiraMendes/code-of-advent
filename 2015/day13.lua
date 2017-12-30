input = "Alice would gain 54 happiness units by sitting next to Bob. Alice would lose 81 happiness units by sitting next to Carol. Alice would lose 42 happiness units by sitting next to David. Alice would gain 89 happiness units by sitting next to Eric. Alice would lose 89 happiness units by sitting next to Frank. Alice would gain 97 happiness units by sitting next to George. Alice would lose 94 happiness units by sitting next to Mallory. Bob would gain 3 happiness units by sitting next to Alice. Bob would lose 70 happiness units by sitting next to Carol. Bob would lose 31 happiness units by sitting next to David. Bob would gain 72 happiness units by sitting next to Eric. Bob would lose 25 happiness units by sitting next to Frank. Bob would lose 95 happiness units by sitting next to George. Bob would gain 11 happiness units by sitting next to Mallory. Carol would lose 83 happiness units by sitting next to Alice. Carol would gain 8 happiness units by sitting next to Bob. Carol would gain 35 happiness units by sitting next to David. Carol would gain 10 happiness units by sitting next to Eric. Carol would gain 61 happiness units by sitting next to Frank. Carol would gain 10 happiness units by sitting next to George. Carol would gain 29 happiness units by sitting next to Mallory. David would gain 67 happiness units by sitting next to Alice. David would gain 25 happiness units by sitting next to Bob. David would gain 48 happiness units by sitting next to Carol. David would lose 65 happiness units by sitting next to Eric. David would gain 8 happiness units by sitting next to Frank. David would gain 84 happiness units by sitting next to George. David would gain 9 happiness units by sitting next to Mallory. Eric would lose 51 happiness units by sitting next to Alice. Eric would lose 39 happiness units by sitting next to Bob. Eric would gain 84 happiness units by sitting next to Carol. Eric would lose 98 happiness units by sitting next to David. Eric would lose 20 happiness units by sitting next to Frank. Eric would lose 6 happiness units by sitting next to George. Eric would gain 60 happiness units by sitting next to Mallory. Frank would gain 51 happiness units by sitting next to Alice. Frank would gain 79 happiness units by sitting next to Bob. Frank would gain 88 happiness units by sitting next to Carol. Frank would gain 33 happiness units by sitting next to David. Frank would gain 43 happiness units by sitting next to Eric. Frank would gain 77 happiness units by sitting next to George. Frank would lose 3 happiness units by sitting next to Mallory. George would lose 14 happiness units by sitting next to Alice. George would lose 12 happiness units by sitting next to Bob. George would lose 52 happiness units by sitting next to Carol. George would gain 14 happiness units by sitting next to David. George would lose 62 happiness units by sitting next to Eric. George would lose 18 happiness units by sitting next to Frank. George would lose 17 happiness units by sitting next to Mallory. Mallory would lose 36 happiness units by sitting next to Alice. Mallory would gain 76 happiness units by sitting next to Bob. Mallory would lose 34 happiness units by sitting next to Carol. Mallory would gain 37 happiness units by sitting next to David. Mallory would gain 40 happiness units by sitting next to Eric. Mallory would gain 18 happiness units by sitting next to Frank. Mallory would gain 7 happiness units by sitting next to George."
str = string.gsub(input, "would gain ", "+")
str = string.gsub(str, "happiness units by sitting next to ", "")
str = string.gsub(str, "would lose ", "-")
names = {}
temp = {}
i = 1
for word in string.gmatch(str, "-?%w+") do
   if (i == 2) then
      word = tonumber(word)
   end
   table.insert(temp, word)
   local chk = (i == 1) or (i == 3)
   if chk then
      for i, s in pairs(names) do
         if s == word then chk = false end
      end
      if chk then
         table.insert(names, word)
      end
   end
   i = i % 3 + 1
end
hc = {}
for i = 1, #temp, 3 do
   local name1, name2 = temp[i], temp[i + 2]
   local amount = temp[i + 1]
   if not hc[name1] then hc[name1] = {} end
   hc[name1][name2] = amount
end
temp = nil
function getmaxhc(names, hc, used)
   local max
   if #names ~= 0 then
      for i, s in pairs(names) do
         table.insert(used, s)
         table.remove(names, i)
         local hc = getmaxhc(names, hc, used)
         if not max or hc > max then max = hc end
         table.remove(used, #used)
         table.insert(names, i, s)
      end
   else
      local thc = 0
      for i = 1, #used do
         local j, k = i - 1, i + 1
         if j < 1 then j = #used end
         if k > #used then k = 1 end
         thc = thc + hc[used[i]][used[j]] + hc[used[i]][used[k]]
      end
      return thc
   end
   return max
end
max = getmaxhc(names, hc, {})
print("max happynes change is " .. max)
