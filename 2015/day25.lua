while true do
    if not n then
        n, m = 1, 1
    else
        if n - 1 < 1 then
            n, m = n + m , 1
        else
            n, m = n - 1, m + 1
        end
    end
    if not current then
        current = 20151125
    else
        current = (252533*current)%33554393
    end
    if n == 3010 and m == 3019 then
        print("the code is " .. current)
        break
    end
end
