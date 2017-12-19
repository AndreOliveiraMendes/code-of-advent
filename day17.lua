array = {}
array[0] = 0
curpos = 0
step = 394
for i = 1, 50000000 do
    curpos = (curpos + step)%(#array+1)
    if curpos < #array then
        for j = #array, curpos + 1,-1 do
            array[j + 1] = array[j]
        end
    end
    array[curpos + 1] = i
    curpos = curpos + 1
    if i == 2017 then
        for i,s in pairs(array) do
            if s == 2017 then
                print("part I")
                print(array[i+1])
                break
            end
        end
    elseif i == 50000000 then
        for i,s in pairs(array) do
            if s == 0 then
                print("part II")
                print(array[i+1])
                break
            end
        end
    end
end
