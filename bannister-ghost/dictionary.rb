require 'set'

class Dictionary
    def self.new_dict(file_path)
        dict = Hash.new(0)
        File.open(file_path, "r") do |f|
            f.each_line do |line|
                dict[line.chomp[0..-1]] += 1
            end
        end
        dict

        Dictionary.new(dict)
    end

    def initialize(dict)

        @dict = dict if dict.is_a?(Hash)

    end


    def words_starting_with?(str)
        @dict.select { |word, count| word.start_with?(str) }
    end


    def has_key?(str)
        @dict.has_key?(str)
    end
        # 180 Geary
        # Bring ID
        # Directions: once you get badge, you can acces 830am to 839p on days you have access
        # Check in on Eden and have your information up to date
        # Emails from we work
        # Register on wework
        # Email tonight about it

end
