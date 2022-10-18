require_relative './dictionary.rb'

class AiPlayer

    attr_reader :name

    def initialize(name)
        @name = name
        @dict = Dictionary.new_dict("./dictionary.txt")
    end

    def self.alert_invalid_guess
        puts "Guess invalid"
    end

    def guess(fragment, num_other_players)
        current_length = fragment.length

        potential_words = @dict.words_starting_with?(fragment).keys

        ideal_words = potential_words.select do |word|
            word.length - current_length > 1 && word.length - current_length <= num_other_players
        end

        if ideal_words.length > 0
            return ideal_words.sample[current_length]
        else
            return potential_words.sample[current_length]
        end
    end
end
