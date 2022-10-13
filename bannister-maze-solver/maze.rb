require_relative './maze_reader.rb'

class Maze
    DIRECTIONS = [:N, :E, :S, :W]

    def initialize(maze_file)
        @maze_array = MazeReader.read('./maze.txt')
        @width = @maze_array.length
        @height = @maze_array[0].length
    end

    def starting_position
        @maze_array.each_with_index do |row, i|
            row.each_with_index do |el, j|
                if el == "S"
                    return [i, j]
                end
            end
        end

        throw RuntimeError.new "starting_position not found"
    end

    def space_available?(position)
        row, col = position

        # Check for index out of bounds
        valid_row = row >= 0 && row < @width # Note: code should work without this
        valid_col = col >= 0 && col < @height # note: code should work without this
        if !valid_row || !valid_col
            throw RuntimeError("index out of bounds")
        end

        if @maze_array[row][col] == "*"
            return "wall"
        elsif @maze_array[row][col] == "S"
            return "wall" # seperated from above statement for potential functionality later
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

        h[:N] = space_available?([row + 1, col])
        h[:E] = space_available?([row, col + 1])
        h[:S] = space_available?([row - 1, col])
        h[:W] = space_available?([row, col - 1])

        h
    end

    def valid_moves(position)
        h = surroundings(position)

        h.select {|k, v| v}
    end

    def valid_move?(poition, direction)

    end

    def is_position?(position)

    end
end
