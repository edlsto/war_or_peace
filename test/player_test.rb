require 'minitest/autorun'
require 'minitest/pride'
require './lib/deck'
require './lib/card'
require './lib/player'

class PlayerTest < Minitest::Test
  def setup
    @card1 = Card.new(:diamond, 'Queen', 12)
    @card2 = Card.new(:spade, '3', 3) 
    @card3 = Card.new(:heart, 'Ace', 14) 
    @cards = [@card1, @card2, @card3]
    @deck = Deck.new(@cards)
    @player = Player.new('Clarisa', @deck)
  end

  def test_it_exists
    assert_instance_of Player, @player
  end   

  def test_it_has_a_name
    assert_equal 'Clarisa', @player.name
  end   

  def test_has_a_deck
    assert_equal [@card1, @card2, @card3], @player.deck.cards
  end

  def test_can_remove_card
    @player.deck.remove_card
    assert_equal  [@card2, @card3], @player.deck.cards
  end

  def test_hasnt_lost_game
    @player.deck.remove_card
    assert_equal @player.hasLost?, false
  end

  def test_hasnt_lost_game
    @player.deck.remove_card
    @player.deck.remove_card
    assert_equal @player.hasLost?, false
  end

  def test_hasnt_lost_game
    @player.deck.remove_card
    @player.deck.remove_card
    @player.deck.remove_card
    assert_equal @player.hasLost?, true
  end


end
