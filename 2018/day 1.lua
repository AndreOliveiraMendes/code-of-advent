input = "1 1 -2"
f = 0
for n in string.gmatch(input, "-?%d+") do
    f = f + n
end
print("f=" .. f)
