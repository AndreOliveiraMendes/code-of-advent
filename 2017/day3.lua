input = 312051
range = 1
dir = "right"
j=1
dis = 0
value = 0
part = 2
function val(t,x,y,i)
    if part==2 then
        local sum
        for xa=x-1,x+1 do
            for ya=y-1,y+1 do
                if t[ya] and t[ya][xa] and (xa~=x or ya~=y) then
                    if not sum then sum=t[ya][xa] else sum=sum+t[ya][xa] end
                end
            end
        end
        if not sum then
            return 1
        else
            return sum
        end
    else
        return i
    end
end
function tablei(t,x,y,i)
    if not t[y] then
        t[y]={}
    end
    t[y][x]=val(t,x,y,i)
end
t={}
ie=nil
if part == 1 then
    ie=input
else
    ie=input+2
end
for i=1,ie do
    if not x or not y then
        x,y=0,0
        tablei(t,x,y,i)
    else
        if dir == "right" then
            x,y=x+1,y
            tablei(t,x,y,i)
            j=j+1
            if j>=range then
                dir="up"
                j=0
            end
        elseif dir == "up" then
            x,y=x,y+1
            tablei(t,x,y,i)
            j=j+1
            if j>=range then
                dir="left"
                j=0
                range=range+1
            end
        elseif dir == "left" then
            x,y=x-1,y
            tablei(t,x,y,i)
            j=j+1
            if j>=range then
                dir="down"
                j=0
            end
        elseif dir == "down" then
            x,y=x,y-1
            tablei(t,x,y,i)
            j=j+1
            if j>=range then
                dir="right"
                j=0
                range=range+1
            end
        end
    end
    local val=val(t,x,y,i)
    dis=math.abs(x)+math.abs(y)
    if val>input and part==2 then
        value=val
        break
    elseif part==1 then
        value=val
    end
end
print("dis=" .. dis)
print("value=" .. value)
