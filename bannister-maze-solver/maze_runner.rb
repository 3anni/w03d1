require_relative './maze.rb'

require 'byebug'

class MazeRunner
    DIRECTIONS = [:N, :E, :S, :W]
    NUM_D = 4 # NUMBER OF DIRECTIONS

    def initialize
        @maze = Maze.new('./maze.txt')
        @position = @maze.starting_position
        @facing = 1 # 0
        @tracking_wall = 2 # 3
    end

    def move(position, direction)       
        @maze[position] = "X"
        row, col = position

        # Move to position in that direction
        case direction
        when :N
            position[0] -= 1
        when :E
            position[1] += 1
        when :S
            position[0] += 1
        when :W
            position[1] -= 1
        end

        return position
    end

    def pick_direction
        surroundings = @maze.surroundings(@position)

        puts surroundings

        # exit if possible
        if surroundings.values.include?("exit")
            puts "picked #{surroundings.key("exit")} direction"
            return surroundings.key("exit")
        end

        # if wall is no longer there, step in that direction and then turn in the opposite direction
        if surroundings[DIRECTIONS[@tracking_wall]] == "open"
            @facing, @tracking_wall = @tracking_wall, (@tracking_wall - 1) % NUM_D
            return DIRECTIONS[@facing]
        end


        # continue in current direction if possible
        count = 0
        while count < 5 && surroundings[DIRECTIONS[@facing]] == "wall"
            @facing = (@facing + 1) % NUM_D
            @tracking_wall = (@tracking_wall + 1) % NUM_D
            count += 1
        end
        if count == 5
            throw RuntimeError.new("Stuck: No Available Directions (maze_runner.pick_direction")
            exit
        end

        return DIRECTIONS[@facing]
    end

    def gtfo
        while @maze.whats_in_position?(@position) != "exit"
            # debugger
            move(pick_direction)
            @maze.print # kill this row later
        end
        @maze.print
    end
end
