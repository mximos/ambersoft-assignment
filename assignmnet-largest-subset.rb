# Object defining a sub-array of integer values
# The sub-array contains a start and end index
# defining a region of the master array
class SubArray
  def initialize
    @start = 0
    @end = 0
    @sum = 0
  end

  # Set boundaries of the sub-array
  def set_bounds(list_start, list_end)
    @start, @end = list_start, list_end
  end

  def length
    (@end - @start) if sum > 0
  end

  # Provide get/set accessors
  attr_reader :start, :end, :sum
  attr_writer :sum
end


class LargestSubArray
  # Finds the sub-array with the largest sum
  # Input: a list of integers

  attr_reader :list, :largest, :current

  def initialize(list)
    @list = list
    @largest = SubArray.new
    @current = SubArray.new
  end

  def find_subarray!

    #raise exceptio if no positive element
    raise Exception.new("Invalid list, need atleast one positive element.") if list.empty? || list.max < 1

    for i in 0...list.size
      current.sum = current.sum + list[i]

      if (current.sum > largest.sum)
        largest.sum = current.sum
        current.set_bounds(current.start, i)
        largest.set_bounds(current.start, i)
      elsif (current.sum < 0)
        # If sum goes negative, this region cannot have the largest sum
        current.sum = 0
        current.set_bounds(i + 1, i + 1)
      end
    end

    largest
  end

  def print_result
    puts "================"
    puts "Largest SubArray"
    puts "Start index: #{largest.start}"
    puts "Length: #{largest.length}"
    puts "Sum: #{largest.sum}"
    puts "Elements: #{list.slice(largest.start, largest.end - largest.start + 1)}"
    puts "================"
  end
end

begin
  puts 'Type in as many integers as you\'d like. When you\'re finished, press enter on an empty line'
  list = []
  input = ' '
  loop do
    input = gets.chomp
    break if input == ''
    list << input.to_i
  end
  master_array = LargestSubArray.new(list)
  master_array.find_subarray!
  master_array.print_result

  puts "Have another array y/N"
  yn = gets.chomp
 
end while(yn == 'y')
