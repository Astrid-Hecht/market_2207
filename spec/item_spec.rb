require 'rspec'
require './lib/item'

describe Item do
  context 'Iteration 1' do
    before :each do
      @item1 = Item.new({ name: 'Peach', price: "$0.75" })
      @item2 = Item.new({ name: 'Tomato', price: '$0.50' })
    end

    it 'Item exists' do
      expect(item).to be_an_instance_of Item
    end

    it 'Item has a name' do
      expect(item.name).to eq 'toilet paper'
    end
  end
end
