require_relative 'item'

class Vendor
  attr_reader :name
  attr_accessor :inventory

  def initialize(name)
    @name = name
    @inventory = Hash.new(0)
  end

  def check_stock(item)
    @inventory[item]
  end

  def stock(item, quantity)
    @inventory[item] += quantity
  end

  def potential_revenue
    @inventory.map { |item| item[0].price * check_stock(item[0]) }.reduce(:+)
  end
end
