#Start at top
#Look at two next to it
#Take one to left and follow the path down picking the largest options
#repeat for one to right and pick the one that is largest
#repeat for the num you are currently on until you reach the end
def arr_sum(arr)
    sum_arr = 0
    arr.each { |i| sum_arr+=i}
    sum_arr
end


triangle = [[75], [95, 64], [17, 47, 82], [18, 35, 87, 10], [20, 4, 82, 47, 65], [19, 1, 23, 75, 3, 34], [88, 2, 77, 73, 7, 63, 67], [99, 65, 4, 28, 6, 16, 70, 92], [41, 41, 26, 56, 83, 40, 80, 70, 33], [41, 48, 72, 33, 47, 32, 37, 16, 94, 29], [53, 71, 44, 65, 25, 43, 91, 52, 97, 51, 14], [70, 11, 33, 28, 77, 73, 17, 78, 39, 68, 17, 57], [91, 71, 52, 38, 17, 14, 91, 43, 58, 50, 27, 29, 48], [63, 66, 4, 68, 89, 53, 67, 30, 73, 16, 69, 87, 40, 31], [4, 62, 98, 27, 23, 9, 70, 98, 73, 93, 38, 53, 60, 4, 23]] #the grid stuff
def spot_inc(triangle, row, spot)
    if triangle[row][spot+1].nil?
        return spot
    else
        return spot+1
    end
end

def small_paths(path, triangle, row, spot)
    2.times {|i| triangle[row+1][spot]>triangle[row+1][spot_inc(triangle, row, spot)] ? path << triangle[row+=1][spot] : path << triangle[row+=1][spot = spot_inc(triangle, row, spot)]}
end

def small_path_choice(triangle, row_start, spot_start)
    row = row_start*1
    spot = spot_start*1
    small_path1 = [triangle[row][spot]]
    small_path2 = Array(small_path1)
    small_path1 << triangle[row+=1][spot]
    small_paths(small_path1, triangle, row, spot)
    puts row_start, spot_start
    row2 = row_start*1
    spot2 = spot_start*1
    small_path2 << triangle[row2+=1][spot2 = spot_inc(triangle, row2, spot2)]
    small_paths(small_path2, triangle, row2, spot2)
    path1_sum = arr_sum(small_path1)
    path2_sum = arr_sum(small_path2)
    puts row_start, spot_start
    if path1_sum>path2_sum
        return path1_sum, row, spot
    else
        return path2_sum, row2, spot2
    end
end

def max_path_sum(triangle)
    sum = 0
    row = 0
    spot = 0
    until row==triangle.length-1 do
        path_choice = small_path_choice(triangle, row, spot)
        puts print "Row: #{row}   Spot: #{spot}"
        gets.chomp
        sum+=path_choice[0]
        row = path_choice[1]
        spot = path_choice[2]
    end
    sum
end

puts max_path_sum(triangle)