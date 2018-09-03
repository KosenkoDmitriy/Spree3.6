require 'spec_helper'

describe Spree::Product do
  it "returns the price/master price if sale and main price are blank" do
    variant = create(:variant, price: 15.00, main_price: '', sale_price: '')
  end
end
