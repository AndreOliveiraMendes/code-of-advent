input = {43,3,4,10,21,44,4,6,47,41,34,17,17,44,36,31,46,9,27,38}
--input = {20, 15, 10, 5, 5}
function getsum(t)
   local sum = 0
   for i, s in pairs(t) do
      sum = sum + s
   end
   return sum
end
tia = os.clock()
function gpc(disp, ref, used, list)
   local sum = getsum(used)
   if sum > ref then
      return
   elseif sum == ref then
      local comb = {table.unpack(used)}
      table.insert(list, comb)
   else
      if #disp == 0 then
         return
      else
         for i, s in pairs(disp) do
            if sum + s <= ref then
               local aux = {}
               for j, q in ipairs(disp) do
                  if j > i then table.insert(aux, q) end
               end
               table.insert(used, s)
               gpc(aux, ref, used, list)
               table.remove(used, #used)
            end
         end
      end
   end
end
ti = os.clock()
possible = {}
table.sort(input)
gpc(input, 150, {}, possible)
to = os.clock()
print("done is " .. to - ti .. "s")
print("the number of combination is " .. #possible)
