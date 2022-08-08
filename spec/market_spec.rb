require 'rspec'
require_relative '../lib/market'

describe Market do
  before :each do
    @market = Market.new("South Pearl Street Farmers Market")
    @item1 = Item.new({ name: 'Peach', price: "$0.75" })
    @item2 = Item.new({ name: 'Tomato', price: '$0.50' })
    @vendor1 = Vendor.new("Rocky Mountain Fresh")
    @item3 = Item.new({ name: "Peach-Raspberry Nice Cream", price: "$5.30" })
    @item4 = Item.new({ name: "Banana Nice Cream", price: "$4.25" })
    @vendor2 = Vendor.new("Ba-Nom-a-Nom")
    @vendor1.stock(@item1, 35)
    @vendor1.stock(@item2, 7)
    @vendor2.stock(@item4, 50)
    @vendor2.stock(@item3, 25)
    @vendor3 = Vendor.new("Palisade Peach Shack")
    @vendor3.stock(@item1, 65)
  end

  context 'Iteration 2' do
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
      expect(@market.vendor_names).to eq([@vendor1.name, @vendor2.name, @vendor3.name])
    end

    it 'can find vendors that sell an item' do
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)
      expect(@market.vendors_that_sell('Peach')).to eq([@vendor1, @vendor3])
      expect(@market.vendors_that_sell('Banana Nice Cream')).to eq([@vendor2])
    end
  end

  context 'Iteration 3' do
    before :each do
      @vendor3.stock(@item3, 10)
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)
    end

    it 'can return list of total inventory' do
      expect(@market.total_inventory).to eq(
        {
          @item1 => {
            quantity: 100,
            vendors: [@vendor1, @vendor3]
          },
          @item2 => {
            quantity: 7,
            vendors: [@vendor1]
          },
          @item3 => {
            quantity: 35,
            vendors: [@vendor2, @vendor3]
          },
          @item4 => {
            quantity: 50,
            vendors: [@vendor2]
          }
        }
      )
    end

    it 'can find overstocked items' do
      expect(@market.overstocked_items).to eq([@item1])
    end

    it 'can return list of all items sold at market, sorted alphabetically' do 
      expect(@market.sorted_item_list).to eq(["Banana Nice Cream", "Peach", "Peach-Raspberry Nice Cream", "Tomato"])
    end
  end

  context 'Iteration 4' do
    before :each do
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)
      @item5 = Item.new({ name: 'Onion', price: '$0.25' })
    end

    it 'has a date' do
      expect(@market.date).to eq(Date.today.strftime("%d/%m/%Y"))
      allow_any_instance_of(Market).to receive(:date_gen) { Date.new(2015, 10, 7) }
      @market2 = Market.new('Test Foods')
      expect(@market2.date).to eq('07/10/2015')
    end

    it 'can sell' do
      expect(@market.sell(@item1, 200)).to eq false
      expect(@market.sell(@item5, 1)).to eq false
      expect(@market.sell(@item4, 5)).to eq true
      expect(@vendor2.check_stock(@item4)).to eq 45
      expect(@market.sell(@item1, 40)).to eq true
      expect(@vendor1.check_stock(@item1)).to eq 0
      expect(@vendor3.check_stock(@item1)).to eq 60
    end
  end
end
