input = io.read()
floor = 0
for i = 1, #input do
   local str = string.sub(input, i, i)
   if str == "(" then
      floor = floor + 1
   else
      floor = floor - 1
   end
   if not basement and floor == -1 then
      basement = i
   end
end
--part I
print("the input lead to floor " .. floor)
print("entered basment first time at " .. basement)
