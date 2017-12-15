genA = 722
genB = 354
count = 0
fA = 16807
fB = 48271
function match(a,b)
    local la = a&0xffff
    local lb = b&0xffff
    return la == lb
end
for i = 1, 40000000 do
    genA = (genA*fA)%2147483647
    genB = (genB*fB)%2147483647
    if match(genA,genB) then
        count = count + 1
    end
end
print("part I")
print("count:" .. count)
genA = 722
genB = 354
count = 0
for i= 1, 5000000 do
    local start = true
    while start or genA%4 ~= 0 do
        if start then start = false end
        genA = (genA*fA)%2147483647
    end
    start = true
    while start or genB%8 ~= 0 do
        if start then start = false end
        genB = (genB*fB)%2147483647
    end
    if match(genA,genB) then
        count = count + 1
    end
end
print("part II")
print("count:" .. count)
