input = [[31/13
34/4
49/49
23/37
47/45
32/4
12/35
37/30
41/48
0/47
32/30
12/5
37/31
7/41
10/28
35/4
28/35
20/29
32/20
31/43
48/14
10/11
27/6
9/24
8/28
45/48
8/1
16/19
45/45
0/4
29/33
2/5
33/9
11/7
32/10
44/1
40/32
2/45
16/16
1/18
38/36
34/24
39/44
32/37
26/46
25/33
9/10
0/29
38/8
33/33
49/19
18/20
49/39
18/39
26/13
19/32]]
--debug libraly
function print2(obj, aux)
    if type(obj) == "table" then
        if obj.type == "piece" then
            local str = "(" .. obj.p1 .. "|" .. obj.p2 .. ")"
            if aux then
                return str
            end
            print(str)
        elseif obj.type == "bridge" then
            local str
            for i, s in pairs(obj) do
                if s ~= "bridge" then
                    if not str then
                        str = print2(s, true)
                    else
                        str = str .. "-" .. print2(s, true)
                    end
                end
            end
            print(str)
        else
            print(obj)
        end
    else
        print(obj)
    end
end
function getinfo(input)
	local t = {}
	local jump = string.find(input, string.char(10))
	local i = 1
	while jump do
		local str = string.sub(input, i, jump - 1)
		table.insert(t, str)
		i = jump + 1
		jump = string.find(input, string.char(10), i)
	end
	if i <= #input then
		local str = string.sub(input, i, #input)
		table.insert(t, str)
	end
	return t
end
input = getinfo(input)
pieces = {}
for i, s in pairs(input) do
    local bar = string.find(s, "/")
    local n1 = tonumber(string.sub(s, 1, bar - 1))
    local n2 = tonumber(string.sub(s, bar + 1, #s))
    local t = {}
    t.p1 = n1
    t.p2 = n2
    t.type = "piece"
    table.insert(pieces, t)
end
function makebridge(a, b)
    local t = {}
    t.type = "bridge"
    if not a or (type(a) ~= "table") or (a.type ~= "piece") then
        print("error: expected a piece")
    end
    table.insert(t, a)
    if b and (type(b) == "table") and (b.type == "piece") then
        table.insert(t, b)
    end
    return t
end
