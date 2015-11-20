def middle_divisor(num)
    middle = (Math.sqrt(num)).to_i
    until num%middle == 0
        middle -=1
    end
    middle
end

def divisor_count(num)
    count = 4
    middle = middle_divisor(num)
    count = 3 if middle == Math.sqrt(num)
    if middle>2
        numbers = Array.new(middle-2) {|i| i+2}
        #puts print numbers
        numbers.each { |i| count+=2 if num%i==0}
    end
    count
end

def divisor_check(start, count)
    tri_start = start*(start+1)/2
    adder = 1
    until divisor_count(tri_start)>count
        tri_start+=(start+adder)
        adder+=1
    end
    tri_start
end

puts divisor_check(1, 500)