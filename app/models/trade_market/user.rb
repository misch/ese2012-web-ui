module TradeMarket

  class User
    attr_accessor :name, :amount_of_credits, :items

    def initialize (name)
      self.name = name
      self.amount_of_credits = 100
      self.items = Array.new
    end

  # @param [String] name
  # @param [String] price
  # @return [Item]
    def add_new_item_to_system(name, price)
      new_item = Item.new( name, price, self )
      items.push(new_item)
    end

    def add_Item(item)
      item.push(item)
    end
    def remove_item(item)
      items.delete(item)
    end


    def list_active_items()
      active_items = Array.new
      items.each do |item|
        if item.active?()
          active_items.push(item)
        end
      end
      active_items
    end

  # @param [User] seller
  # @param [Item] item
    def buy_item(seller, item)
      if item.can_be_bought?(self)
        transact_credits(self,seller, item.price)

        item.change_owner(self)

        self.items.push(item)
        seller.items.delete(item)
      else
        "#{self.name}, you cannot buy this item!"
      end
    end

    def transact_credits(giver, taker, amount)
      giver.amount_of_credits -= amount
      taker.amount_of_credits += amount
    end
  end
end