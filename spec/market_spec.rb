require 'rspec'
require_relative '../lib/item'
require_relative '../lib/market'

describe Market do
  context 'Iteration 2' do
    before :each do
      @market = Market.new("South Pearl Street Farmers Market")
      @item1 = Item.new({ name: 'Peach', price: "$0.75" })
      @item2 = Item.new({ name: 'Tomato', price: '$0.50' })
      @vendor1 = Vendor.new("Rocky Mountain Fresh")
      @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
      @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
      @vendor2 = Vendor.new("Ba-Nom-a-Nom")
      @vendor1.stock(@item1, 35)
      @vendor1.stock(@item2, 7)
      @vendor2.stock(@item4, 50)
      @vendor2.stock(@item3, 25)
      @vendor3 = Vendor.new("Palisade Peach Shack")
      @vendor3.stock(@item1, 65)
    end

    it 'exists' do
      expect(@market).to be_an_instance_of(Market)
    end

    it 'has a name' do
      expect(@market.name).to eq("South Pearl Street Farmers Market")
    end

    it 'has an initially empty array of vendors' do
      expect(@market.vendors).to be_a(Array)
      expect(@market.vendors).to eq([])
    end

    it 'can add vendors' do
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)
      expect(@market.vendors).to eq([@vendor1, @vendor2, @vendor3])
    end

    it 'can return vendor names' do
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)
      expect(@market.vendors).to eq([@vendor1.name, @vendor2.name, @vendor3.name])
    end

    it 'can find vendors that sell an item' do
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)
      expect(@market.vendors_that_sell('Peach')).to eq([@vendor1, @vendor3])
      expect(@market.vendors_that_sell("Banana Nice Cream")).to eq([@vendor2])
    end
  end
end
