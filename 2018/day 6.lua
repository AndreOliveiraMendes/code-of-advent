input = [[183, 157
331, 86
347, 286
291, 273
285, 152
63, 100
47, 80
70, 88
333, 86
72, 238
158, 80
256, 140
93, 325
343, 44
89, 248
93, 261
292, 250
240, 243
342, 214
192, 51
71, 92
219, 63
240, 183
293, 55
316, 268
264, 151
68, 98
190, 288
85, 120
261, 59
84, 222
268, 171
205, 134
80, 161
337, 326
125, 176
228, 122
278, 151
129, 287
293, 271
57, 278
104, 171
330, 69
141, 141
112, 127
201, 151
331, 268
95, 68
289, 282
221, 359]]
list = {}
for word in input:gmatch("%C+") do
    local p = {}
    local x, y
    for n in word:gmatch("-?%d+") do
        if not x then
            x = tonumber(n)
        else
            y = tonumber(n)
        end
    end
    p.x, p.y = x, y
    table.insert(list, p)
end
for _, p in pairs(list) do
    if not xmin or p.x < xmin then
        xmin = p.x
    end
    if not xmax or p.x > xmax then
        xmax = p.x
    end
    if not ymin or p.y < ymin then
        ymin = p.y
    end
    if not ymax or p.y > ymax then
        ymax = p.y
    end
end
area = {}
function dist(p, x, y)
    return math.abs(p.x - x) + math.abs(p.y - y)
end
for x = xmin, xmax do
    for y = ymin, ymax do
        local cdist
        local closer
        for _, p in pairs(list) do
            if not cdist or dist(p, x, y) < cdist then
                cdist = dist(p, x, y)
                closer = p
            elseif dist(p, x, y) == cdist then
                closer = nil
            end
        end
        if closer then
            area[closer] = area[closer] and (area[closer] + 1) or 1
        end
    end
end
for p, a in pairs(area) do
    if p.x ~= xmin and p.x ~= xmax and p.y ~= ymin and p.y ~= ymax then
        if not md or a > md then
            md = a
        end
    end
end
--part 1
print("maxime finite area is " .. md)
