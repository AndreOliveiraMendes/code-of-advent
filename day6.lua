input = {0,5,10,0,11,14,13,4,11,8,8,7,1,4,12,11}
dt = {}
meb = {}
for i=1,#input do
    meb[i] = {}
    meb[i][0] = input[i]
end
check = true
round = 0
function getmax(t,round)
    local maxvalue,index
    for i,s in pairs(t) do
        if not maxvalue or s[round]>maxvalue then
            maxvalue = s[round]
            index = i
        elseif s[round] == maxvalue and i<index then
            index = i
        end
    end
    return maxvalue,index
end
function gettable(ti,round)
    local to = {}
    for i=1,#input do
        to[i] = ti[i][round]
    end
    return to
end
function compt(t1,t2)
    for i=1,#input do
        if t1[i]~=t2[i] then
            return false
        end
    end
    return true
end
while check do
    local mv,mi = getmax(meb,round)
    round = round + 1
    local index = mi
    for i = 1,#input do
        meb[i][round] = meb[i][round-1]
    end
    meb[mi][round] = 0
    for i = 1,mv do
        index = (index + 1 == #input) and 1 or (index + 1)
        meb[index][round] = meb[index][round] + 1
    end
    local chk = false
    local t2 = gettable(meb,round)
    for i = 0,round - 1 do
        local t1 = gettable(meb,i)
        chk = chk or compt(t1,t2)
        if chk then
            break
        end
    end
    check = not chk
end
print("cycles = " .. round)
