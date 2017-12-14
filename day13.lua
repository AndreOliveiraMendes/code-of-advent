local input ={[0]= 3;
[1]= 2;
[2]= 4;
[4]= 4;
[6]= 5;
[8]= 6;
[10]= 6;
[12]= 8;
[14]= 6;
[16]= 6;
[18]= 9;
[20]= 8;
[22]= 8;
[24]= 8;
[26]= 12;
[28]= 8;
[30]= 12;
[32]= 12;
[34]= 12;
[36]= 10;
[38]= 14;
[40]= 12;
[42]= 10;
[44]= 8;
[46]= 12;
[48]= 14;
[50]= 12;
[52]= 14;
[54]= 14;
[56]= 14;
[58]= 12;
[62]= 14;
[64]= 12;
[66]= 12;
[68]= 14;
[70]= 14;
[72]= 14;
[74]= 17;
[76]= 14;
[78]= 18;
[84]= 14;
[90]= 20;
[92]= 14}
local S = {}
for i,s in pairs(input) do
    local t = {}
    t.x = i
    t.y = 1
    t.my = s
    t.dy = 1
    table.insert(S,t)
end
local p = {}
p.y = 1
start = true
clist = {}
while start or p.x<=92 do
    start = false --no more start
    if not t then t = 0 else t = t + 1 end -- increase timer
    --player move
    if not p.x then p.x = 0 else p.x = p.x + 1 end
    --check colision
    for i,s in pairs(S) do
        if s.x == p.x and s.y == p.y then
            table.insert(clist,{s.x,s.my})
            break
        end
    end
    --S moves
    for i,s in pairs(S) do
        local py = s.y
        local cy = s.y + s.dy
        if cy>s.my then
            s.dy = -1
            cy = s.y + s.dy
        elseif cy<1 then
            s.dy = 1
            cy = s.y + s.dy
        end
        s.y = cy
    end
end
print("part I")
severity = 0
for i,s in pairs(clist) do
    severity = severity + s[1]*s[2]
end
print("severity value is " .. severity)
