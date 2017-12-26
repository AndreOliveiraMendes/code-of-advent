local input = {70,66,255,2,48,0,54,48,80,141,244,254,160,108,1,41}
local input2 = "70,66,255,2,48,0,54,48,80,141,244,254,160,108,1,41"
local list = {}
local size = 256
function pt(t)
    local str
    for i=0,size-1 do
        str = (str) and (str .. "," .. t[i]) or t[i]
    end
    print(str)
end
for i=0,size-1 do
    list[i] = i
end
local curpos = 0
local skip = 0
function round(input)
    for i,lenght in pairs(input) do
        local endpos = curpos + lenght - 1
        for i = curpos, (curpos+endpos)/2 do
            local pos1,pos2 = i%size,(curpos+endpos-i)%size
            list[pos1],list[pos2]=list[pos2],list[pos1]
        end
        curpos = (curpos + lenght + skip)%size
        skip = skip + 1
    end
end
round(input)
local a,b = list[0],list[1]
print("part 1")
print("multiplication = " .. a*b)
for i=0,size-1 do
    list[i] = i
end
curpos = 0
skip = 0
input = {}
for i=1,#input2 do
    local str = string.sub(input2,i,i)
    local b = string.byte(str)
    table.insert(input,b)
end
local ins = {17, 31, 73, 47, 23}
for i,s in pairs(ins) do
    table.insert(input,s)
end
for i=1,64 do
    round(input)
end
local output = {}
local j = 0
function comp(t,i,j)
    if i<16 then
        return t[j] ~ comp(t,i+1,j+1)
    else
        return t[j]
    end
end
for i=1,16 do
    local b = comp(list,1,j)
    table.insert(output,b)
    j = j + 16
end
function tohex(number)
    local result = ""
    local list = "0123456789abcdef"
    local res = number%16
    local quo = number//16
    if quo>0 then
        return tohex(quo) .. string.sub(list,res+1,res+1)
    else
        return string.sub(list,res+1,res+1)
    end
end
for i=1,16 do
    local n = output[i]
    n = tohex(n)
    output[i] = (#n == 1) and ("0" .. n) or n
end
print("part 2")
print("harsh code is " .. table.concat(output))
