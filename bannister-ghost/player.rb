class Player
    attr_reader :name

    def initialize(name)
        @name = name
    end

    def self.alert_invalid_guess
        puts "Guess invalid"
    end

    def guess(fragment, num_other_players)
        guess = ""

        guess = gets.chomp

        if guess.length != 1
            Player.alert_invalid_guess
            self.guess
        else
            guess
        end
    end

end
