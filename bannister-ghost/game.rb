require_relative './dictionary.rb'
require_relative './player.rb'
require_relative './ai_player.rb'

require 'set'

class Game


    def self.new_game(n)
        puts "Enter player names one at a time:"
        players = []
        n.times do
            players << Player.new(gets.chomp)
        end
        # ai_n.times do
        #     players << AiPlayer.new("AI #{ai_n + 1}")
        # end
        Game.new(players)
    end

    def initialize(players)
        @players = players
        @current_player_idx = 0
        @losses = Hash.new(0)
        @fragment = ''
        @dict = Dictionary.new_dict("./dictionary.txt")
    end

    def current_player
        @players[@current_player_idx]
    end

    def previous_player
        prev_player_idx = (@current_player_idx - 1) % @players.length
        @players[prev_player_idx]
    end

    def next_player
        next_player_idx = (@current_player_idx + 1) % @players.length
        @players[next_player_idx]
    end

    def take_turn
        active_player = current_player

        puts "#{active_player.name} enter a move:"

        guess = active_player.guess(@fragment, @players.length - 1)
        until valid_play?(guess)
            Player.alert_invalid_guess
            guess = active_player.guess(@fragment, @players.length - 1)
        end

        @current_player_idx = (@current_player_idx + 1) % @players.length
        @fragment += guess
        puts "Fragment: #{@fragment}"
        @fragment
    end

    def hypothetical_word(str)
        (@fragment + str).each_char.map(&:downcase).join("")
    end

    def valid_play?(str)
        alphabet = ("a".."z").to_set
        return false if !alphabet.include?(str.downcase)
        return false if @dict.words_starting_with?(hypothetical_word(str)).length == 0
        true
    end

    def play_round
        # Print "Ghost Vol. 1"
        take_turn

        until @dict.has_key?(@fragment)
            take_turn
        end

        loser = previous_player

        @losses[loser] += 1

        puts "#{loser.name} loses the round"

    end

    def record(player)
        "GHOST"[0...@losses[player]]
    end

    def display_standings
        @players.each do |player|
            puts "#{player.name}: #{record(player)}"
        end
    end

    def remove_losers
        @losses.each do |player, losses|
            if losses >= 5
                @players.delete(player)
            end
        end
    end

    def run
        until @players.length == 1
            @fragment = ''
            play_round
            display_standings
            remove_losers
        end
        puts "#{@players[0].name} wins the game!"
    end


end
