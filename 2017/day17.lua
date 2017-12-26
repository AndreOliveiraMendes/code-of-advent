array = {}
array[0] = 0
curpos = 0
step = 394
for i = 1, 2017 do
    curpos = (curpos + step)%(#array+1)
    table.insert(array,curpos + 1,i)
    curpos = curpos + 1
end
for i,s in pairs(array) do
    if s == 2017 then
        print("part I(" .. i .. ")")
        print(array[i+1])
        break
    end
end
array = {}
array[0] = 0
curpos = 0
zeropos = 0
for i = 1, 50000000 do
    curpos = (curpos + step)%i
    if curpos == zeropos then
        table.insert(array,zeropos + 1,i)
    elseif curpos < zeropos then
        table.insert(array,zeropos - 1,i)
    end
    curpos = curpos + 1
end
for i,s in pairs(array) do
    if s == 0 then
        print("part II(" .. i .. ")")
        print(array[i+1])
        break
    end
end
