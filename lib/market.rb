require_relative 'vendor'

class Market
  attr_reader :name,
              :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map(&:name)
  end

  def vendors_that_sell(item)
    @vendors.find_all { |vendor| vendor.inventory.map { |stock_item| stock_item[0].name }.include?(item) }
  end
end
