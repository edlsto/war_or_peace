require './lib/turn'

class Game
    attr_reader :player1,
                :player2
    def initialize(player1, player2)
        @player1 = player1
        @player2 = player2
    end

    def start
        turn_count = 0
        while (@player1.deck.cards.length > 0 && @player2.deck.cards.length > 0) && (turn_count < 1000000)
            turn_count += 1
            puts("Round No. #{turn_count}\n")
            turn = Turn.new(@player1, @player2)
            type = turn.type
            winner = turn.winner
            turn.pile_cards
            
            if type == :basic
                puts("#{winner.name} won #{turn.spoils_of_war.length.to_s} cards")  
            elsif type == :war
                puts("WAR - #{winner.name} won #{turn.spoils_of_war.length.to_s} cards")
            elsif type == :mutually_assured_destruction
                puts("mutually assured destruction* 6 cards removed from play")
            end
            if type != :mutually_assured_destruction 
                turn.award_spoils(winner)
            end
            puts("\n")
        end
        puts("Game Over")
    end
end