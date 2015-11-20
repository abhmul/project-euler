def create_add3_set(sum)
    addarr = []
    a = 3
    b= 1
    c=Math.sqrt(a**2+b**2)
    until a+b+c==sum
        b+=1
        if a+b+c>sum
            a+=1
            b=1
        end
        c=Math.sqrt(a**2+b**2)
    end
    puts print "a=",a
    puts print "b=",b
    puts print "c=",c
    puts print "Product is: ", a*b*c
end

puts create_add3_set(1000)