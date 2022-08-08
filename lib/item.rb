class Item
  attr_reader :info

  def initialize(info)
    @info = info
  end

  def name
    @info[:name]
  end

  def price
    @info[:price].gsub('$', '').to_f
  end
end
