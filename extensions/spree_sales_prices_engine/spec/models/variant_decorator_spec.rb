require 'spec_helper'

describe Spree::Variant do
  describe "#price_in" do
    it "returns the sale price if it is present" do
      variant = create(:variant, sale_price: 8.00)
      expected = Spree::Price.new(variant_id: variant.id, currency: "USD", amount: variant.sale_price)

      result = variant.price_in("USD")

      expect(result.variant_id).to eq(expected.variant_id)
      expect(result.amount.to_f).to eq(expected.amount.to_f)
      expect(result.currency).to eq(expected.currency)

      expect(variant.sale_price.to_f).to eq(expected.amount.to_f)
    end

    it "returns the normal price if it is not on sale" do
      variant = create(:variant, price: 15.00)
      expected = Spree::Price.new(variant_id: variant.id, currency: "USD", amount: variant.price)

      result = variant.price_in("USD")

      expect(result.variant_id).to eq(expected.variant_id)
      expect(result.amount.to_f).to eq(expected.amount.to_f)
      expect(result.currency).to eq(expected.currency)
    end

    it "returns the main price if sale price is empty" do
      variant = create(:variant, main_price: 15.00, sale_price: '')
      expected = Spree::Price.new(variant_id: variant.id, currency: "USD", amount: variant.main_price)

      result = variant.price_in("USD")

      expect(result.variant_id).to eq(expected.variant_id)
      expect(result.amount.to_f).to eq(expected.amount.to_f)
      expect(result.currency).to eq(expected.currency)

      expect(variant.price.to_f).to eq(expected.amount.to_f)
      expect(variant.main_price.to_f).to eq(expected.amount.to_f)
      
      expect(variant.main_price.to_f).to eq(variant.price.to_f)
    end

    it "it is on sale ?" do
      variant = create(:variant, sale_price: 15.00)
      expected = Spree::Price.new(variant_id: variant.id, currency: "USD", amount: variant.main_price)

      result = variant.is_on_sale?
      expect(result).to eq(true)
    end


  end
end
