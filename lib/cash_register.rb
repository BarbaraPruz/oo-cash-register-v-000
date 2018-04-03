require "pry"

class CashRegister
  attr_reader   :transactions
  # in "real" CashRegister, it doesn't seem like there should be writer for total. But test requires it.
  # The problem with having writer for total is that it can be changed without updating transactions
  attr_accessor :discount, :total

  def initialize (discount=0)
    @discount = discount
    @total = 0.0
    # transactions is array of hashes.  Each hash is :item and :price.  This is more than is needed
    # for test spec but thinking of cash register, it seems common to want to do something like
    # print out the whole list (items + price + quantity)
    @transactions = []
  end

  def add_item (item, price, quantity=1)
    quantity.times do
      @transactions << { :Item => item, :Price => price}
      @total += price
    end
  end

  def apply_discount
    if discount != 0
      @total -= @total * discount.to_f/100.0
    end
    discount == 0 ? "There is no discount to apply." : "After the discount, the total comes to $#{total.to_i}."
  end

  def items
    @transactions.map { | transaction | transaction[:Item] }
  end

  def void_last_transaction
    last = @transactions.pop
    # note: this is not the opposite of add_item!  This will just remove the last single item from the list
    @total -= last[:Price]
  end
end
