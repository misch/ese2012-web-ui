module Models
class User
    attr_accessor :name, :amount_of_credits, :items, :password
    @@users = []

    def initialize (name, password)
      self.name = name
      self.amount_of_credits = 100
      self.items = Array.new
      self.password = password
    end

  # @param [String] name
  # @param [String] price
  # @return [Item]
    def add_new_item_to_system(name, price)
      new_item = Item.new( name, price, self)
      items.push(new_item)
    end

    def add_Item(item)
      item.push(item)
    end

    def remove_item(item)
      items.delete(item)
    end

    def list_active_items()
      active_items = []
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
        true
      else
        false
      end
    end

#   @param [User] giver
#   @param[User] taker
#   @param [Integer] amount of credits
    def transact_credits(giver, taker, amount)
      giver.amount_of_credits -= amount
      taker.amount_of_credits += amount
    end

    def save
      @@users << self
    end

    def delete
      @@users.delete self
    end

    def self.all
      @@users
    end

    def self.login(name, password)
       user = @@users[name]

      return false if user.nil?

      user.password == password
    end

    def authenticate? (password)
      self.password.eql?(password)
    end

    def self.by_name(name)
    @@users.detect{|user| user.name == name}
    end

    def activate_items
      items.each do |item|
        item.state = 'active'
      end
    end
  end
end
