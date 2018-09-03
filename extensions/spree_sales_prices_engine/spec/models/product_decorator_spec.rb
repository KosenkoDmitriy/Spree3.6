require 'spec_helper'

describe Spree::Product do
  it "returns the price/master price if sale and main price are blank" do
    product = create(:product, price: 15.00, main_price: '', sale_price: '')
    expect(product.price).to eq(15)
    expect(product.is_on_sale?).to eq(false)
  end
  it "is on sale" do
    product = create(:product, sale_price: 15.00)
    expect(product.is_on_sale?).to eq(true)
    product = create(:product, sale_price: 0.00)
    expect(product.is_on_sale?).to eq(true)
    product = create(:product, sale_price: 15.00, deleted_at: DateTime.now())
    expect(product.is_on_sale?).to eq(true)
    product = create(:product, sale_price: 0.00, deleted_at: DateTime.now())
    expect(product.is_on_sale?).to eq(true)
    expect(Spree::Product.sales.count).to eq(2)
  end
  it 'is not on sale' do
    product = create(:product, sale_price: nil)
    expect(product.is_on_sale?).to eq(false)
    product = create(:product, sale_price: '')
    expect(product.is_on_sale?).to eq(false)

    product = create(:product, price: 15, deleted_at: Time.now())
    expect(product.is_on_sale?).to eq(false)
    expect(Spree::Product.sales.count).to eq(0)
  end
  it 'get a cheapest price'
  it 'get a cheapest main price'
end
