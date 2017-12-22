function snd(v, vlist, slist)
   local value
   if type(v) == "number" then
      value = v
   else
      value = vlist[v]
   end
   table.insert(slist, value)
end
function rcv(v, vlist, slist)
   local value
   if type(v) == "number" then
      value = v
   else
      value = vlist[v]
   end
   if v ~= 0 then
      return slist[#slist]
   else
      return false
   end
end
function set(v1, v2, list)
   if type(v2) == "number" then
      list[v1] = v2
   else
      list[v1] = list[v2]
   end
end
function add(v1, v2, list)
   if type(v2) == "number" then
      list[v1] = list[v1] + v2
   else
      list[v1] = list[v1] + list[v2]
   end
end
function mul(v1, v2, list)
   if type(v2) == "number" then
      list[v1] = list[v1] * v2
   else
      list[v1] = list[v1] * list[v2]
   end
end
function mod(v1, v2, list)
   if type(v2) == "number" then
      list[v1] = list[v1] % v2
   else
      list[v1] = list[v1] % list[v2]
   end
end
function jgz(v1, v2, list, i)
   local com, val
   if type(v1) == "number" then
      com = v1
   else
      com = list[v1]
   end
   if type(v2) == "number" then
      val = v2
   else
      val = list[v2]
   end
   if com > 0 then
      return i + val
   else
      return i + 1
   end
end
input = {{set,"i",31},
{set,"a",1},
{mul,"p",17},
{jgz,"p","p"},
{mul,"a",2},
{add,"i",-1},
{jgz,"i",-2},
{add,"a",-1},
{set,"i",127},
{set,"p",735},
{mul,"p",8505},
{mod,"p","a"},
{mul,"p",129749},
{add,"p",12345},
{mod,"p","a"},
{set,"b","p"},
{mod,"b",10000},
{snd,"b"},
{add,"i",-1},
{jgz,"i",-9},
{jgz,"a",3},
{rcv,"b"},
{jgz,"b",-1},
{set,"f",0},
{set,"i",126},
{rcv,"a"},
{rcv,"b"},
{set,"p","a"},
{mul,"p",-1},
{add,"p","b"},
{jgz,"p",4},
{snd,"a"},
{set,"a","b"},
{jgz,1,3},
{snd,"b"},
{set,"f",1},
{add,"i",-1},
{jgz,"i",-11},
{snd,"a"},
{jgz,"f",-16},
{jgz,"a",-19}}
function init(t, v, id)
   if type(v) == "number" then return end
   if not t[v] then t[v] = id end
end
function isfunc(f, ...)
   local arg = {...}
   for i, fs in pairs(arg) do
      if f == fs then return true end
   end
   return false
end
i = 1
varlist = {}
sound = {}
while i >= 1 and i <= #input do
   local f, v1, v2 = table.unpack(input[i])
   if v1 then init(varlist, v1, 0) end
   if v2 then init(varlist, v2, 0) end
   if isfunc(f,set,add,mul,mod) then
      f(v1, v2, varlist)
   elseif isfunc(f,snd,rcv) then
      local rec = f(v1,varlist,sound)
      if rec then
         print("part I, recoverd:", rec)
         break
      end
   end
   if isfunc(f, jgz) then
      i = jgz(v1,v2,varlist,i)
   else
      i = i + 1
   end
end
print("variables x content")
for i, s in pairs(varlist) do
   print(i,s)
end
print("sounds played")
for i,s in pairs(sound) do
   print(i,s)
end
