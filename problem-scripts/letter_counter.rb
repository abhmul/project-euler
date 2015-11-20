#The switch method works but you should've used a Hash or Array instead

def convert_dig_s(num)
    case num
    when 1
        return "one"
    when 2
        return 'two'
    when 3
        return 'three'
    when 4
        return 'four'
    when 5
        return 'five'
    when 6
        return 'six'
    when 7
        return 'seven'
    when 8
        return 'eight'
    when 9
        return 'nine'
    when 10
        return 'ten'
    when 11
        return 'eleven'
    when 12
        return 'twelve'
    when 13
        return 'thirteen'
    when 15
        return 'fifteen'
    when 18
        return 'eighteen'
    when 20
        return 'twenty'
    when 30
        return 'thirty'
    when 40
        return 'forty'
    when 50
        return 'fifty'
    when 60
        return 'sixty'
    when 70
        return 'seventy'
    when 80
        return 'eighty'
    when 90
        return 'ninety'
    else
        return ''
    end
end

def convert_teen_s(num)
    return convert_dig_s(num-10)+"teen"
end

def convert_ten_s(num)
    tens = num/10*10
    convert_dig_s(tens)+convert_dig_s(num-tens)
end

def convert_hund_s(num)
    hund= num/100
    ten = num-hund*100
    num_s = convert_dig_s(hund) + "hundred"
    num_s+= "and" + convert_num_s(ten) if ten!=0
    num_s
end

def convert_num_s(num)
    if num<=13 || num==15 || num==18
        return convert_dig_s(num)
    elsif num>13 && num<20
        return convert_teen_s(num)
    elsif num>19 && num<100
        return convert_ten_s(num)
    elsif num>=100
        return convert_hund_s(num)
    end
end

def let_num_counter(max)
    sum= 0
    (max-1).times do |num|
        sum+=(convert_num_s(num+1)).length
        puts convert_num_s(num+1)
    end
    sum
end

puts let_num_counter(1000) + "onethousand".length