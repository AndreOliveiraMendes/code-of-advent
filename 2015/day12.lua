input = io.read()
sum = 0
for n in string.gmatch(input, "-?%d+") do
    if tonumber(n) then
        sum = sum + tonumber(n)
    end
end
--part I
print("the sum is " .. sum)
str = input:gsub('"%w+":', function (w) return string.sub(w, 2, #w - 2) .. " = " end)
str = str:gsub("{", '{type = "object", ')
str = str:gsub("%[", "{")
str = str:gsub("]", "}")
function analysy(str)
    if (str:sub(1, 1) == "{") or (str:sub(2, 2) == "{") then
        return nil, getdata(str)
    elseif str:match("=") then
        local i = 1
        while str:sub(i, i) ~= "=" do
            i = i + 1
        end
        local astr, bstr = str:sub(1, i - 1), str:sub(i + 1)
        astr = astr:gsub(" ", "")
        if (bstr:sub(1, 1) == "{") or (bstr:sub(2, 2) == "{") then
            return astr, getdata(str)
        else
            bstr = bstr:gsub(" ", "")
            bstr = bstr:gsub('"', "")
            if tonumber(bstr) then bstr = tonumber(bstr) end
            return astr, bstr
        end
    else
        local bstr = bstr:gsub(" ", "")
        bstr = bstr:gsub('"', "")
        if tonumber(bstr) then bstr = tonumber(bstr) end
        return nil, bstr
    end
end
function getdata(str)
    local t = {}
    local levelr = 0
    local i1, i2
    local virg = false
    for i = 1, #str do
        if virg then
            i1 = i
            virg = false
        end
        local astr = str:sub(i, i)
        if astr == "{" then
            if levelr == 0 then
                i1 = i + 1
            end
            levelr = levelr + 1
        elseif astr == "}" then
            if levelr == 1 then
                i2 = i - 1
            end
            levelr = levelr - 1
        elseif astr == "," and levelr == 1 then
            i2 = i - 1
            virg = true
        end
        if i1 and i2 then
            local index, value = analysy(str:sub(i1, i2))
            if index then
                t[index] = value
            else
                table.insert(t, value)
            end
            i1, i2 = nil, nil
        end
    end
    return t
end
data = getdata(str)
print("finished analysys")
function getscore(data)
    local sum = 0
    if type(data) == "table" then
        local chk = true
        if data.type == "object" then
            for i, s in pairs(data) do
                if s == "red" then chk = false end
            end
        end
        if chk then
            for i, s in pairs(data) do
                sum = sum + getscore(s)
            end
        end
    elseif type(data) == "number" then
        sum = sum + data
    end
    return sum
end
--part II
print("total sum without any object with 'red' is " .. getscore(data))
