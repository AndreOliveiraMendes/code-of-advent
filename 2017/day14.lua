function knoth(input2,outmode)
    local list = {}
    local size = 256
    for i=0,size-1 do
        list[i] = i
    end
    local function round(input,curpos,skip)
        for i,lenght in pairs(input) do
            local endpos = curpos + lenght - 1
            for i = curpos, (curpos+endpos)/2 do
                local pos1,pos2 = i%size,(curpos+endpos-i)%size
                list[pos1],list[pos2]=list[pos2],list[pos1]
            end
            curpos = (curpos + lenght + skip)%size
            skip = skip + 1
        end
        return curpos,skip
    end
    local curpos = 0
    local skip = 0
    local input = {}
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
        curpos,skip = round(input,curpos,skip)
    end
    local output = {}
    local j = 0
    local function comp(t,i,j)
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
    local function tohex(number)
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
    local function tobin(number)
        local result = ""
        local list = "01"
        local res = number%2
        local quo = number//2
        if quo>0 then
            return tobin(quo) .. string.sub(list,res+1,res+1)
        else
            return string.sub(list,res+1,res+1)
        end
    end
    local function fil(n)
        return (n == 0) and "" or ("0" .. fil(n-1))
    end
    for i=1,16 do
        local n = output[i]
        if outmode == "hex" then
            n = tohex(n)
            output[i] = (#n == 1) and ("0" .. n) or n
        elseif outmode == "bin" then
            n = tobin(n)
            local size = #n
            output[i] = fil(8-size) .. n
        end
    end
    return table.concat(output)
end
input = "ffayrhll"
list = {}
for i=0,127 do
    list[i] = input .. "-" .. i
    list[i] = knoth(list[i],"bin")
end
output = {}
for i=0,127 do
    output[i] = {}
    local str1 = list[i]
    for j = 0,127 do
        local str2 = string.sub(str1,j+1,j+1)
        output[i][j] = (str2 == "0") and "." or "#"
    end
end
count = 0
for i=0,127 do
    for j=0,127 do
        if output[i][j] == "#" then
            count = count + 1
        end
    end
end
print("part I")
print(count .. " squares are used")
out = {}
region = 1
function toto(ti,to,x,y,reg)
	if x<0 or y<0 or x>127 or y>127 then return false end
	if not to[x] then
		to[x] = {}
	end
	if to[x][y] then return false end
	if ti[x][y] == "#" then
		to[x][y] = reg
		toto(ti,to,x-1,y,reg)
		toto(ti,to,x+1,y,reg)
		toto(ti,to,x,y-1,reg)
		toto(ti,to,x,y+1,reg)
		return true
	else
		to[x][y] = 0
	end
	return false
end
for i=0,127 do
	for j=0,127 do
		local chk = toto(output,out,i,j,region)
		if chk then
			nreg = region
			region = region + 1
		end
	end
end
print("part II")
print("there was " .. nreg .. " regions")
