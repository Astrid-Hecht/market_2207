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

  def total_inventory
    # binding.pry
    @vendors.flat_map { |vendor| vendor.inventory.keys }.uniq.reduce(Hash.new) do |hash, item|
      hash[item] = {
        quantity: @vendors.sum { |vendor| vendor.check_stock(item) },
        vendors: vendors_that_sell(item.name)
      }
      hash
    end
  end

  def overstocked_items
    total_inventory.find_all { |item| (item[1][:quantity] > 50) && (item[1][:vendors].count > 1)}.map { |item| item[0] }
  end

  def sorted_item_list
    total_inventory.map { |item| item[0].name}.sort
  end
end
