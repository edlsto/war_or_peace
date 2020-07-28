class Turn
    attr_reader :player1, :player2, :spoils_of_war

    def initialize(player1, player2)
        @player1 = player1
        @player2 = player2
        @spoils_of_war = []
    end

    def typeq
       player1_first_card = @player1.deck.rank_of_card_at(0)
       player2_first_card = @player2.deck.rank_of_card_at(0)
       if (player1_first_card == player2_first_card)
        return :war
       else 
        return :basic
       end  
    
    end

end