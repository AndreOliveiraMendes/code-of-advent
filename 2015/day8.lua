strings = {}
for line in io.lines() do
    table.insert(strings, line)
end
tcode = 0
tdata = 0
for i, s in pairs(strings) do
    tcode = tcode + #s
    s = string.sub(s, 2, #s - 1)
    s = string.gsub(s, [[\\]], "//")
    s = string.gsub(s, [[\"]], '/"')
    for str in string.gmatch(s, [[%\x]] .. "%x%x") do
        local n = tonumber(string.sub(str, 3, 4), 16)
        local char = string.char(n)
        if char == "%" then char = "%%" end
        s = string.gsub(s, str, char)
    end
    s = string.gsub(s, "//", "\\")
    s = string.gsub(s, '/"', "\\")
    tdata = tdata + #s
end
print("the infos get are")
print(string.format("total code = %d, total data = %d, dif = %d", tcode, tdata, tcode - tdata))
tcode2 = 0
for i, s in pairs(strings) do
    s = string.gsub(s, [[\]], "//")
    s = string.gsub(s, '"', '/"')
    s = '"' .. s .. '"'
    s = string.gsub(s, "/", [[\]])
    tcode2 = tcode2 + #s
end
print(string.format("total code from original = %d, total code now = %d, dif = %d", tcode, tcode2, tcode2 - tcode))
