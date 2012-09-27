require "test/unit"
require '../app/trade_market/user'
require '../app/trade_market/item'

#noinspection ALL
class TradeMarketTest < Test::Unit::TestCase

#  def setup
#    jane = TradeMarket::User.new('Jane')
#    chair = TradeMarket::Item.new('chair',200,jane)
#  end
# The setup-method seems not to work as we'd expected it to,
# so we wrote the tests without it.

  def test_user_has_name
    user = TradeMarket::User.new('Jane')
    name = user.name
    assert_not_equal(name,"", 'User has no name!')
  end


  def test_user_has_right_name
    user = TradeMarket::User.new('Jim')
    assert(user.name.eql?('Jim'), 'User has wrong name!')
  end

  def test_user_has_credits
    user = TradeMarket::User.new('Jim')
    assert(user.amount_of_credits>0, 'User should have credits!')
  end

  def test_original_credits
    user = TradeMarket::User.new('Jim')
    assert(user.amount_of_credits.eql?(100), 'The set up amount of credits should be 100!')
  end

  def test_item_has_name
    user = TradeMarket::User.new('Jim')
    item = TradeMarket::Item.new('table', 300, user)
    assert_not_equal(item.name,"", 'Item has no name' )
  end

  def test_item_has_right_name
    user = TradeMarket::User.new('Jim')
    item = TradeMarket::Item.new('piano black', 300, user)
    assert_equal(item.name, 'piano black', 'Item has not the right name')

  end

  def test_item_has_price
    item = TradeMarket::Item.new('guitar', 243, TradeMarket::User.new('Hendrix'))
    assert(item.price.eql?(243),'Price of item should be 243!')
  end

  def test_item_has_owner
    user = TradeMarket::User.new('Jim')
    item = TradeMarket::Item.new('table', 300, user)
    assert_equal(item.owner, user, 'Item has not the right owner!')
  end

  def test_item_has_state
    user = TradeMarket::User.new('Jim')
    item = TradeMarket::Item.new('table', 300, user)
    assert_not_equal(item.state, '', 'Item has no state')
  end

  def test_user_add_item_to_system
    user = TradeMarket::User.new('Jim')
    user.add_new_item_to_system('pizza', 11)
    assert(!user.items.empty?(), 'No item added')

    item = user.items.pop
    assert(!item.active?, 'Item should be inactive!')

  end

  def test_user_active_item_list
    user = TradeMarket::User.new('Jim')
    user.add_new_item_to_system('pizza', 11)
    user.add_new_item_to_system('piano', 400)
    user.add_new_item_to_system('apple pie', 5)

    items = user.items
    items[0].state = 'active'
    items[1].state = 'active'

    assert(user.list_active_items.include?(items[0]),"The item #{items[0].name} should be in the list!")
    assert(user.list_active_items.include?(items[1]),"The item #{items[1].name} should be in the list!")
    assert(!user.list_active_items.include?(items[2]), "The item #{items[2].name} should not be in the list!")
  end

  def test_not_enough_credits
    hendrix = TradeMarket::User.new('Hendrix')
    bobby = TradeMarket::User.new('Bobby')

    guitar = TradeMarket::Item.new("guitar",243,hendrix)
    guitar.state = 'active'
    assert(!guitar.can_be_bought?(bobby),"Bobby has not enough credits to buy Jimi's guitar!")
  end





  def test_buy_active_item
    hendrix = TradeMarket::User.new('Hendrix')
    bobby = TradeMarket::User.new('Bobby')

    rainbow_guitar = TradeMarket::Item.new("rainbow guitar",50,hendrix)
    rainbow_guitar.state = 'active'

    bobby.buy_item(hendrix,rainbow_guitar)

    assert(rainbow_guitar.owner.eql?(bobby), "It should be Bobby's guitar by now!")
   assert(bobby.amount_of_credits.eql?(50), "Bobby should have 50 credits left.")
    assert(hendrix.amount_of_credits.eql?(150), "Hendrix should have 150 credits now.")
    assert(!rainbow_guitar.active?, "The rainbow guitar should be inactive.")
  end

  def cannot_buy_inactive_item
    harry = TradeMarket::User.new("Harry Potter")
    hermione = TradeMarket::User.new("Hermione Granger")

    snatch = TradeMarket::Item.new("snatch",0)

    assert(!snatch.can_be_bought?(hermione),"Hermione cannot buy the snatch because it's inactive!")
  end
end

