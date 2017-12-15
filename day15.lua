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
for i = 1,40000000 do
    genA = (genA*fA)%2147483647
    genB = (genB*fB)%2147483647
    if match(genA,genB) then
        count = count + 1
    end
end
print("count:" .. count)
