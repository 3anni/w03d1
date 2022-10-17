require_relative './maze_reader.rb'

class Maze

    def initialize(maze_file)
        @maze_array = MazeReader.read(maze_file)
        @height = @maze_array.length
        @width = @maze_array[0].length
    end

    def print
        @maze_array.each do |row|
            puts row.join("")
        end
    end

    def valid_maze_indices?(position)
        # Check for index out of bounds
        if !position.is_a?(Array) || position.length != 2
            puts " not a pos 20"
            return false
        end

        # Check that row/col indices are valid
        row, col = position
        valid_row = (row >= 0) && (row < @height)
        valid_col = (col >= 0) && (col < @width)
        if !(valid_row && valid_col)
            return false
        end

        true
    end

    def [] (pos)
        # throw RuntimeError.new("index out of bounds") if !valid_maze_indices??(position)
        row, col = pos
        @maze_array[row][col]
    end

    def []=(pos, char)
        # throw RuntimeError.new("index out of bounds") if !valid_maze_indices??(position)
        row, col = pos
        @maze_array[row][col] = char
    end

    # def drop_X(position)
    #     @maze_array[row][col] = char
    # end

    def starting_position
        (0...@height).each { |i| (0...@width).each { |j| return [i, j] if @maze_array[i][j] == "S" } }
        throw RuntimeError.new "starting_position not found"
    end

    def whats_in_position?(position)
        row, col = position
        puts position.join(" ")
        puts row
        puts col
        puts "-----"

        if @maze_array[row][col] == "*"
            return "wall"
        elsif @maze_array[row][col] == "S"
            return "wall" # seperated from above statement for potential functionality later
        elsif @maze_array[row][col] == "X"
            return "wall"
        elsif @maze_array[row][col] == "E"
            return "exit"
        else
            return "open"
        end
    end

    # Returns hash with availability of surrounding positions
    def surroundings(position)
        h = Hash.new()
        row, col = position

        h[:N] = whats_in_position?([row - 1, col])
        h[:E] = whats_in_position?([row, col + 1])
        h[:S] = whats_in_position?([row + 1, col])
        h[:W] = whats_in_position?([row, col - 1])

        h
    end

    def valid_moves(position)
        h = surroundings(position)

        h.select {|k, v| v == "open" || v == "exit"}
    end

end



# Testing Suite
test_maze = Maze.new('./maze.txt')

test_maze.print

puts test_maze.valid_maze_indices?([0,0]) # true
puts test_maze.valid_maze_indices?([7,15]) # true
puts test_maze.valid_maze_indices?([0,16]) # false
puts test_maze.valid_maze_indices?([8,0]) # false
puts test_maze.valid_maze_indices?([-1,0]) # false
puts test_maze.valid_maze_indices?([0,-1]) # false

puts test_maze[[0,0]] # "*"
puts test_maze[[7,15]] # "*"
puts test_maze[[6,2]] # " "
puts test_maze.starting_position.join(" ") #" [6, 2]"
puts test_maze[test_maze.starting_position] # "S"

pos_start = test_maze.starting_position
pos00 = [0,0]
pos12 = [1,2]
pos44 = [4,4]
pos55 = [5,5]
pos715 = [7, 15]

puts test_maze.whats_in_position?(pos00)
puts test_maze.whats_in_position?(pos12)
puts test_maze.whats_in_position?(pos44)
puts test_maze.whats_in_position?(pos55)
puts test_maze.whats_in_position?(pos715)

puts test_maze.surroundings(pos_start)
puts test_maze.surroundings(pos_start)

puts self
