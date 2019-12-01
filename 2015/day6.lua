light = {}
light2 = {}
while true do
    local action = io.read()
    if not action then break end
    local act, xmin, ymin, xmax, ymax
    if string.find(action,"turn on") then
        act = "turn on"
    elseif string.find(action,"turn of") then
        act = "turn off"
    elseif string.find(action,"toggle") then
        act = "toggle"
    else
        print("error: no action found")
    end
    local range = {}
    for dig in string.gmatch(action, "%d+") do
        table.insert(range, tonumber(dig))
    end
    xmin, ymin, xmax, ymax = table.unpack(range)
    for x = xmin, xmax do
        for y = ymin, ymax do
            if not light[x] then light[x] = {} end
            if not light[x][y] then light[x][y] = 0 end
            if not light2[x] then light2[x] = {} end
            if not light2[x][y] then light2[x][y] = 0 end
            if act == "turn on" then
                light[x][y] = 1
                light2[x][y] = light2[x][y] + 1
            elseif act == "turn off" then
                light[x][y] = 0
                light2[x][y] = math.max(light2[x][y] - 1, 0)
            elseif act == "toggle" then
                light[x][y] = 1 - light[x][y]
                light2[x][y] = light2[x][y] + 2
            else
                print("error: no action found")
            end
        end
    end
end
count = 0
bright = 0
for x = 0, 999 do
    for y = 0, 999 do
        if light[x] and light[x][y] then
            count = count + light[x][y]
            bright = bright + light2[x][y]
        end
    end
end
--part I
print("there " .. count .. " light(s) on")
--part II
print("the total bright is " .. bright)
