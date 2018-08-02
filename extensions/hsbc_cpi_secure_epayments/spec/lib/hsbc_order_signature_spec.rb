require_relative "../../lib/hsbc_order_signature"

describe HsbcOrderSignature do

  let(:shared_secret) { "shared_secret" }

  let(:request_params) do
    {
      "TIMESTAMP" => "20160101111523", # yyyymmddhhmmss
      "MERCHANT_ID" => "10175401",
      "ORDER_ID" => "R12345678",
      "AMOUNT" => "12345", # £123.45
      "CURRENCY" => "GBP"
    }
  end

  let(:response_params) do
    {
      "SHA1HASH" => "8784d580a1a8b3987a81cc908b6f10dacf677bae",
      "TIMESTAMP" => "20160101111523", # yyyymmddhhmmss
      "MERCHANT_ID" => "10175401",
      "ORDER_ID" => "R12345678",
      "RESULT" => "00",
      "MESSAGE" => "Successful",
      "PASREF" => "123456789",
      "AUTHCODE" => "1234"
    }
  end

  it "Hashes the Request" do
    expect(HsbcOrderSignature.new(request_params, shared_secret).sha1).to eq("30c07dc97f46e6fba500f460255ce32449cee8af")
  end

  it "validates the response" do
    expect(HsbcOrderSignature.new(response_params, shared_secret).valid_response?).to be true
  end

end
