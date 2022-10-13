# ****************
# *         *   E*
# *    *    *  ***
# *    *    *    *
# *    *    *    *
# *    *    *    *
# *S   *         *
# ****************


class MazeReader

    def self.read(file_path)
        maze_array = []

        # Read file into 2-d array of chars, trimming edge columns
        File.open(file_path, "r") do |f|
            f.each_line do |line|
                sub_array = []
                line.chomp[0..-1].each_char { |char| sub_array.push(char) }
                maze_array << sub_array
            end
        end

        maze_array
    end
end
