local input = {70,66,255,2,48,0,54,48,80,141,244,254,160,108,1,41}
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
for i,lenght in pairs(input) do
    local endpos = curpos + lenght - 1
    for i = curpos, (curpos+endpos)/2 do
        local pos1,pos2 = i%size,(curpos+endpos-i)%size
        list[pos1],list[pos2]=list[pos2],list[pos1]
    end
    curpos = (curpos + lenght + skip)%size
    skip = skip + 1
end
local a,b = list[0],list[1]
print("multiplication = " .. a*b)
