#1 Jan 1900 was a Monday.
#Thirty days has September,
#April, June and November.
#All the rest have thirty-one,
#Saving February alone,
#Which has twenty-eight, rain or shine.
#And on leap years, twenty-nine.
#A leap year occurs on any year evenly divisible by 4, but not on a century unless it is divisible by 400

#How many Sundays fell on the first of the month during the twentieth century (1 Jan 1901 to 31 Dec 2000)?


class Date
    def initialize(day, month, date, year)
        @date = date
        @month = month
        @year = year
        @day = day
        @dayn_to_day = [0, :Sunday, :Monday, :Tuesday, :Wednesday, :Thursday, :Friday, :Saturday]
        @_30days = [4,6,9,11]
        @leapyear = ((@year%4==0 && @year%100!=0) || @year%400==0)
    end
    
    def mod_top(num, mod)
        num!=mod ? modnum = num%mod : modnum = num
        modnum
    end
    
    def get_day
        day = @day*1
        day
    end
    
    def get_month
        month = @month*1
        month
    end
    
    def get_year
        year = @year*1
        year
    end
    
    def get_date
        date = @date*1
        date
    end
    
    def display_date
        full_date = "#{@month}/#{@date}/#{@year}"
        word_day = @dayn_to_day[@day]
        puts "#{word_day}   #{full_date}"
    end
    
    def tomorrow
        if @month==2
            if @leapyear 
                @month+=1 if @date+1>29
                @date = mod_top(@date+1, 29)
            else
                @month+=1 if @date+1>28
                @date = mod_top(@date+1, 28)
            end
        elsif @_30days.include? @month
            @month+=1 if @date+1>30
            @date = mod_top(@date+1, 30)
        else
            @month+=1 if @date+1>31
            @date = mod_top(@date+1, 31)
        end
        @day = mod_top(@day+1, 7)
        if @month>12
            @year+=1
            @month = mod_top(@month, 12)
        end
    end
end



def sunday?(date)
    return date.get_day==1
end
    

def count_sun_20
    date = Date.new(3, 1, 1, 1901)
    count = 0
    until date.get_year==2001
        count+=1 if date.get_day==1 && date.get_date==1
        date.tomorrow
    end
    count
end

puts count_sun_20
puts 1200/7
    