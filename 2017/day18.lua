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
--part I
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
--- part II
function rcvn(v, vlist, slist)
    if #slist == 0 then
        return false
    else
        vlist[v] = slist[1]
        table.remove(slist,1)
        return true
    end
end
for i, s in pairs(input) do
    if s[1] == rcv then
        input[i][1] = rcvn
    end
end
rcv = rcvn
i = {[0] = 1, [1] = 1}
varlist = {[0] = {}, [1] = {}}
sound = {[0] = {}, [1] = {}}
lock = {}
id = 0
count = {[0] = 0, [1] = 0}
while (i[0] > 0 and i[0] <= #input) or (i[1] >= 1 and i[1] <= #input) do
    if (i[id] >= 1 and i[id] <= #input) then
        local f, v1, v2 = table.unpack(input[i[id]])
        if v1 then init(varlist[id], v1, id) end
        if v2 then init(varlist[id], v2, id) end
        if isfunc(f,set,add,mul,mod) then
            f(v1, v2, varlist[id])
            i[id] = i[id] + 1
        elseif isfunc(f,snd) then
            f(v1, varlist[id], sound[id])
            i[id] = i[id] + 1
            count[id] = count[id] + 1
            id = 1 - id
        elseif isfunc(f,rcv) then
            local rec = f(v1,varlist[id],sound[1-id])
            if rec then
                i[id] = i[id] + 1
                if lock[id] then lock[id] = false end
            else
                if lock[0] and lock[1] then break end
                lock[id] = true
                id = 1 - id
            end
        else
            i[id] = jgz(v1,v2,varlist[id],i[id])
        end
    else
        dl[id] = true
        id = 1 - id
    end
end
print("part II:")
print(count[0],count[1])
