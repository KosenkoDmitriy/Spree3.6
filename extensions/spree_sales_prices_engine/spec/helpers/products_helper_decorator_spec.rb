require 'spec_helper'

describe Spree::ProductsHelper do
  it "check helper name" do
    expect(helper.silly_helper).to eq("Just'abit silly")
  end
  it "get main price from product" do
    product = create(:product, price: 15)
    expect(helper.main_product_price(product)).to eq(product.price)
  end
  it "get main price from variant" do
    variant = create(:product, price: 15)
    expect(helper.main_product_price(variant)).to eq(variant.price)
  end
end
