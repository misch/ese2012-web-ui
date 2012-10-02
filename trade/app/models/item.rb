module Models

  class Item
    attr_accessor :name, :price, :state, :owner
    @@items=[]

    def initialize( name, price, owner )
      self.name = name
      self.price = price
      self.state = "inactive"
      self.owner = owner
    end

    def active?
      state.eql?('active')
    end

    def can_be_bought?(buyer)
      return (active?() and buyer.amount_of_credits >= price and !buyer.eql?(owner))
    end

    def change_owner( new_owner)
      self.state = "inactive"
      self.owner = new_owner
    end

    def to_s
      "#{self.name} (#{self.price})"
    end

    def save
      @@items << self
    end

    def delete
      @@items.delete self
    end

    def self.all
      @@items
    end
  end
end