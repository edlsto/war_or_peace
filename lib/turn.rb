class Turn
    attr_reader :player1, :player2, :spoils_of_war

    def initialize(player1, player2)
        @player1 = player1
        @player2 = player2
        @spoils_of_war = []
    end

    def type
       player1_first_card = @player1.deck.cards[0]
       player2_first_card = @player2.deck.cards[0]
       player1_third_card = @player1.deck.cards[2]
       player2_third_card = @player2.deck.cards[2]
       if (player1_first_card.rank == player2_first_card.rank && player1_third_card.rank == player2_third_card.rank)
        return :mutually_assured_destruction
       elsif (player1_first_card.rank == player2_first_card.rank)
        return :war
       else 
        return :basic
       end  
    end

    def winner
        if (type() == :basic && @player1.deck.rank_of_card_at(0) > @player2.deck.rank_of_card_at(0))
            return @player1
        elsif (type() == :basic && @player1.deck.rank_of_card_at(0) < @player2.deck.rank_of_card_at(0))
            return @player2
        elsif (type() == :war && @player1.deck.rank_of_card_at(2) < @player2.deck.rank_of_card_at(2))
            return @player2
        elsif (type() == :war && @player1.deck.rank_of_card_at(2) < @player2.deck.rank_of_card_at(2))
            return @player2
        elsif (type() == :mutually_assured_destruction)
            return 'No winner'
        end
    end

    def pile_cards
        if (type() == :basic)
            removed_card_player_1 = @player1.deck.cards.shift
            removed_card_player_2 = @player2.deck.cards.shift
            @spoils_of_war << removed_card_player_1 << removed_card_player_2
        end
        if(type() == :war)
            removed_cards_player1 = @player1.deck.cards.shift(3)
            removed_cards_player2 = @player2.deck.cards.shift(3)
            removed_cards = removed_cards_player1.concat(removed_cards_player2)
            @spoils_of_war = @spoils_of_war.concat(removed_cards)
        end
        if(type() == :mutually_assured_destruction)
            @player1.deck.shift(3)
            @player2.deck.shift(3)
        end
    end

    def award_spoils(winner)
        winner.deck.cards.concat(@spoils_of_war)
    end

end