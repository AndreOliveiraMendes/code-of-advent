array = {}
array[0] = 0
curpos = 0
step = 394
for i = 1, 2017 do
    curpos = (curpos + step)%(#array+1)
    if curpos < #array then
        for j = #array, curpos + 1,-1 do
            array[j + 1] = array[j]
        end
    end
    array[curpos + 1] = i
    curpos = curpos + 1
end
for i,s in pairs(array) do
    if s == 2017 then
        print(array[i+1])
        break
    end
end
for i = 1, 2017 do
    curpos = (curpos + step)%(#array+1)
    if curpos < #array then
        for j = #array, curpos + 1,-1 do
            array[j + 1] = array[j]
        end
    end
    array[curpos + 1] = i
    curpos = curpos + 1
end
