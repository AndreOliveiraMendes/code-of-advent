input = io.read()
sum = 0
for n in string.gmatch(input, "-?%d+") do
    if tonumber(n) then
        sum = sum + tonumber(n)
    end
end
--part I
print("the sum is " .. sum)
str = string.gsub(input, '"%w":', function (w) return string.sub(w, 2, 2) .. " = " end)
str = string.gsub(str, "{", '{type = "object", ')
str = string.gsub(str, "%[", "{")
str = string.gsub(str, "]", "}")
--print(str) <-- this is a valid lua string for the input, use that and you skip all that process
function analysy(str)
    if (string.sub(str, 1, 1) == "{") or (string.sub(str, 2, 2) == "{") then
        return nil, getdata(str)
    elseif string.match(str, "=") then
        local i = 1
        while string.sub(str, i, i) ~= "=" do
            i = i + 1
        end
        local astr, bstr = string.sub(str, 1, i - 1), string.sub(str, i + 1, #str)
        astr = string.gsub(astr, " ", "")
        if (string.sub(bstr, 1, 1) == "{") or (string.sub(bstr, 2, 2) == "{") then
            return astr, getdata(str)
        else
            bstr = string.gsub(bstr, " ", "")
            bstr = string.gsub(bstr, '"', "")
            if tonumber(bstr) then bstr = tonumber(bstr) end
            return astr, bstr
        end
    else
        local bstr = string.gsub(str, " ", "")
        bstr = string.gsub(bstr, '"', "")
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
        local astr = string.sub(str, i, i)
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
            local index, value = analysy(string.sub(str, i1, i2))
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
