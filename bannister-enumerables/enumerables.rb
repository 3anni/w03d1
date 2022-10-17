require 'byebug'


class Array

    def my_each
        i = 0
        while i < self.length
            yield(self[i])
            i += 1
        end
        self
    end

    def my_select
        selected = []
        self.my_each { |el| selected << el if yield(el) }
        selected
    end

    def my_reject
        selected = []
        self.my_each { |el| selected << el if !yield(el) }
        selected
    end

    def my_any?
        self.my_each { |el| return true if yield(el) }
        false
    end

    def my_all?
        self.my_each { |el| return false if !yield(el) }
        true
    end

    def my_flatten
        flattened = []
        self.my_each do |el|
            if el.is_a?(Array)
                flattened.concat(el.my_flatten)
            else
                flattened << el
            end
        end
        flattened
    end

    def my_zip(*arrs)
        zipped = Array.new(self.length) {|i| Array.new(arrs.length + 1, nil)}

        # Loop through chars in each array (based on how many chars are in self array)
        (0...self.length).each do |j|
            zipped[j][0] = self[j] || nil
            # iterate through each array
            (0...arrs.length).each do |i|
                zipped[j][i+1] = arrs[i][j] if arrs[i][j]
            end
        end

        zipped
    end

    def my_rotate(n=1)
        direction = n / n.abs
        arr = self.dup

        while n.abs > 0
            first, last = arr.first, arr.last

            if direction > 0
                (0...arr.length - 1).each { |i| arr[i] = arr[i+1] }
            else
                (1...arr.length).each { |i| arr[-i] = arr[-i-1] }
            end

            direction > 0 ? arr[-1] = first : arr[0] = last

            n -= direction
        end

        arr
    end

    def my_join(char="")
        str = ''
        (0...self.length - 1).each { |i| str += self[i] + char }
        str += self[-1]
    end

    def my_reverse
        reverse = []
        self.each { |el| reverse.unshift(el) }
        reverse
    end
end

# return_value = [1, 2, 3].my_each do |num|
#     puts num
# end.my_each do |num|
#     puts num
# end
   # => 1
    #    2
    #    3
    #    1
    #    2
    #    3

# p return_value  # => [1, 2, 3]

# a = [1, 2, 3]
# p a.my_select { |num| num > 1 } # => [2, 3]
# p a.my_select { |num| num == 4 } # => []


# a = [1, 2, 3]
# p a.my_reject { |num| num > 1 } # => [1]
# p a.my_reject { |num| num == 4 } # => [1, 2, 3]

# a = [1, 2, 3]
# p a.my_any? { |num| num > 1 } # => true
# p a.my_any? { |num| num == 4 } # => false
# p a.my_all? { |num| num > 1 } # => false
# p a.my_all? { |num| num < 4 } # => true

# p [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten # => [1, 2, 3, 4, 5, 6, 7, 8]

# a = [ 4, 5, 6 ]
# b = [ 7, 8, 9 ]
# p [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
# p a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
# p [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]

# c = [10, 11, 12]
# d = [13, 14, 15]
# p [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]


# a = [ "a", "b", "c", "d" ]
# p a.my_rotate         #=> ["b", "c", "d", "a"]
# p a.my_rotate(2)      #=> ["c", "d", "a", "b"]
# p a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
# p a.my_rotate(15)     #=> ["d", "a", "b", "c"]

# a = [ "a", "b", "c", "d" ]
# p a.my_join         # => "abcd"
# p a.my_join("$")    # => "a$b$c$d"


p [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
p [ 1 ].my_reverse               #=> [1]
