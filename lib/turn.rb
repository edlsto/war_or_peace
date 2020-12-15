class Turn
    attr_reader :player1, :player2, :spoils_of_war

    def initialize(player1, player2)
        @player1 = player1
        @player2 = player2
        @spoils_of_war = []
        @current_winner = winner

    end

    def type
        player1_first_card = @player1.deck.cards[0]
        player2_first_card = @player2.deck.cards[0]
        player1_third_card = @player1.deck.cards[2]
        player2_third_card = @player2.deck.cards[2]
        if (player1_first_card.rank != player2_first_card.rank)
            return :basic
        elsif player1_first_card.rank == player2_first_card.rank && (player1.deck.cards.length < 3 || player2.deck.cards.length < 3) 
            return :war
        elsif player1_first_card.rank == player2_first_card.rank && player1_third_card.rank != player2_third_card.rank
            return :war
        else 
            return :mutually_assured_destruction
        end  
    end

    def winner
        if (@player1.deck.rank_of_card_at(0) > @player2.deck.rank_of_card_at(0))
            return @player1
        elsif (@player2.deck.rank_of_card_at(0) > @player1.deck.rank_of_card_at(0))
            return @player2
        elsif (type == :war && @player1.deck.cards.length < 3)
            return @player2
        elsif (type == :war && @player2.deck.cards.length < 3)
            return @player1
        elsif (type == :war && @player1.deck.rank_of_card_at(2) > @player2.deck.rank_of_card_at(2))
            return @player1
        elsif (type == :war && @player2.deck.rank_of_card_at(2) > @player1.deck.rank_of_card_at(2))
            return @player2
        elsif (type == :war && @player1.deck.rank_of_card_at(2) > @player2.deck.rank_of_card_at(2))
            return @player1
        elsif (type == :mutually_assured_destruction)
            return 'No winner'
        end
    end

    def pile_cards
        if (type == :basic)
            removed_card_player_1 = @player1.deck.cards.shift
            removed_card_player_2 = @player2.deck.cards.shift
            @spoils_of_war = @spoils_of_war.concat([removed_card_player_1]).concat([removed_card_player_2])
            @spoils_of_war.shuffle!
        elsif(type == :war)
            war_removed_cards_player_1 = @player1.deck.cards.shift(3)
            war_removed_cards_player_2 = @player2.deck.cards.shift(3)
            @spoils_of_war = @spoils_of_war.concat(war_removed_cards_player_1).concat(war_removed_cards_player_2)
            @spoils_of_war.shuffle!
        elsif(type == :mutually_assured_destruction)
            @player1.deck.cards.shift(3)
            @player2.deck.cards.shift(3)
        end
    end

    def award_spoils(winner)
        winner.deck.cards.concat(@spoils_of_war)
    end

end