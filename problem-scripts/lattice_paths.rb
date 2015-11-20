def factorial(num)
    product=1
    while num!=1 do
        product*=num
        num-=1
    end
    product
end

def paths(size)
    factorial(2*size)/(factorial(size)*factorial(size))
end