presents = {}
while true do
    local input = io.read()
    if not input then break end
    local aux = {}
    for digit in string.gmatch(input, "%d+") do
        digit = tonumber(digit)
        table.insert(aux, digit)
    end
    table.insert(presents, aux)
end
area = 0
com = 0
for i, s in pairs(presents) do
    local l, w, h = s[1], s[2], s[3]
    area = area + 2*l*w + 2*l*h + 2*w*h + math.min(l*w,l*h,w*h)
    com = com + math.min(2*(l+w),2*(l+h),2*(w+h)) + l*h*w
end
--part I
print("the total square feet of wrapping paper they should buy is " .. area)
--part II
print("the total feet of ribbon they should buy is " .. com)
