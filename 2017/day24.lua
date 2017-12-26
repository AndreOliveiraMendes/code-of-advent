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
            local str = "|"
            for i, s in ipairs(obj) do
                str = str .. "-" .. print2(s, true)
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
function makebridge(a, b) --if neither a or b is give, if make a 0 bridge
    local t = {}
    t.type = "bridge"
    if a and (type(a) == "table") and (a.type == "piece") then
        table.insert(t, a)
    end
    if b and (type(b) == "table") and (b.type == "piece") then
        table.insert(t, b)
    end
    return t
end
function getbridgesize(a)
    if not a or (type(a) ~= "table") or (a.type ~= "bridge") then
        print("error: expecteda a bridge")
        return
    end
    local count = 0
    for i, s in ipairs(a) do
        count = count + 1
    end
    return count
end
function bridgeinsert(a, b)
    if not a or (type(a) ~= "table") or (a.type ~= "bridge") then
        print("error: expecteda a bridge")
        return
    end
    if not b or (type(b) ~= "table") or (b.type ~= "piece") then
        print("error: expected a piece")
        return
    end
    for i, s in ipairs(a) do
        if s == b then
            --print("it alredy there")
            return
        end
    end
    table.insert(a, b)
end
function bridgeremove(a, b)
    if not a or (type(a) ~= "table") or (a.type ~= "bridge") then
        print("error: expecteda a bridge")
        return
    end
    if not b or (type(b) ~= "table") or (b.type ~= "piece") then
        print("error: expected a piece")
        return
    end
    for i, s in ipairs(a) do
        if s == b then
            a[i] = nil
        end
    end
end
function getbridgecomponent(a, n) --if n is nil, get last component
    if not a or (type(a) ~= "table") or (a.type ~= "bridge") then
        print("error: expecteda a bridge")
        return
    end
    if not n then n = getbridgesize(a) end
    local count = 0
    for i, s in ipairs(a) do
        count = count + 1
        if count == n then
            return s
        end
    end
    return
end
function getbridgestrengh(a)
    if not a or (type(a) ~= "table") or (a.type ~= "bridge") then
        print("error: expecteda a bridge")
        return
    end
    local sum = 0
    for i, s in ipairs(a) do
        sum = sum + s.p1 + s.p2
    end
    return sum
end
function pieceinvert(a)
    if not a or (type(a) ~= "table") or (a.type ~= "piece") then
        print("error: expected a piece")
        return
    end
    a.p1, a.p2 = a.p2, a.p1
end
availabre = {}
for i, s in ipairs(pieces) do
    table.insert(availabre, s)
end
function getstrongestbridge(availabre, bridge)
    local max
    if getbridgesize(bridge) == 0 then
        for i, s in ipairs(availabre) do
            if (s.p1 == 0) or (s.p2 == 0) then
                if not (s.p1 == 0) then pieceinvert(s) end
                local availabre2 = {}
                for i, s2 in ipairs(availabre) do
                    if s2 ~= s then
                        table.insert(availabre2, s2)
                    end
                end
                bridgeinsert(bridge, s)
                local str = getbridgestrengh(bridge)
                if not max or getbridgestrengh(bridge) > max then max = str end
                str = getstrongestbridge(availabre2, bridge)
                if not max or (str and (str > max)) then max = str end
                bridgeremove(bridge, s)
            end
        end
    else
        local lpiece = getbridgecomponent(bridge)
        for i, s in ipairs(availabre) do
            if (s.p1 == lpiece.p2) or (s.p2 == lpiece.p2) then
                if not (s.p1 == lpiece.p2) then pieceinvert(s) end
                local availabre2 = {}
                for i, s2 in ipairs(availabre) do
                    if s2 ~= s then
                        table.insert(availabre2, s2)
                    end
                end
                bridgeinsert(bridge, s)
                local str = getbridgestrengh(bridge)
                if not max or getbridgestrengh(bridge) > max then max = str end
                str = getstrongestbridge(availabre2, bridge)
                if not max or (str and (str > max)) then max = str end
                bridgeremove(bridge, s)
            end
        end        
    end
    return max
end
--part I
print("part I")
ti = os.time()
max = getstrongestbridge(availabre, makebridge())
print("done in " .. os.time() - ti)
print("the strongestbridge possible is " .. max)
