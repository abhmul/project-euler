def collatz(num)
    steps = 0
    until num==1 do
        if num%2==0
            num = num/2
        else
            num= 3*num+1
        steps+=1
        end
    end
    steps
end

def longest_collatz(max)
    step_count = 0
    longest = 0
    (max-2).times do |testnum|
        count = collatz(testnum+1)
        if count>step_count
            step_count = count
            longest = testnum+1
        end
    end
    return longest, step_count
end

puts print longest_collatz(1000000)