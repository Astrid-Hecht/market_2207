require 'rspec'
require_relative '../lib/item'
require_relative '../lib/vendor'

describe Market do
  context 'Iteration 1' do
    before :each do
      @market = Market.new("South Pearl Street Farmers Market")
      @vendor = Vendor.new("Rocky Mountain Fresh")
      @item1 = Item.new({ name: 'Peach', price: "$0.75" })
      @item2 = Item.new({ name: 'Tomato', price: '$0.50' })
    end

    it 'exists' do
      expect(@vendor).to be_an_instance_of(Vendor)
    end

    it 'has a name' do
      expect(@vendor.name).to eq("Rocky Mountain Fresh")
    end

    it 'has an initially empty inventory hash' do
      expect(@vendor.inventory).to be_a(Hash)
      expect(@vendor.inventory).to eq({})
    end

    it 'counts stock of a certain ingredient' do
      expect(@vendor.check_stock(@item1)).to eq(0)
    end

    it 'can stock' do
      @vendor.stock(@item1, 30)
      expect(@vendor.check_stock(@item1)).to eq(30)
      @vendor.stock(@item1, 25)
      expect(@vendor.check_stock(@item1)).to eq(55)
      @vendor.stock(@item2, 12)
    end

    it 'correctly stores stock in inventory' do
      @vendor.stock(@item1, 30)
      expect(@vendor.inventory).to eq({ @item1 => 30 })
      @vendor.stock(@item1, 25)
      @vendor.stock(@item2, 12)
      expect(@vendor.inventory).to eq({ @item1 => 55, @item2 => 12 })
    end
  end
end
