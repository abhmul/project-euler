def factorial(num)
    product=1
    while num!=1 do
        product*=num
        num-=1
    end
    product
end

def sum(num)
    str = num.to_s
    array = str.split("")
    array1 = array.map(&:to_i)
    sum = array1.inject(:+)
    sum
end
#puts factorial(100)
puts sum(factorial(100))
