require 'digest/sha1'

class HsbcOrderSignature

  attr_accessor :params
  attr_accessor :shared_secret

  # Order Params
  def initialize params, shared_secret
    self.params = params
    self.shared_secret = shared_secret
  end

  # Call to generate SHA1 Hash for sending Order to HSBC
  def sha1
    hash_values(
      params["TIMESTAMP"], 
      params["MERCHANT_ID"],
      params["ORDER_ID"],
      params["AMOUNT"],
      params["CURRENCY"]
    )
  end

  # Call to confirm the params are a valid response from HSBC
  def valid_response?
    params["SHA1HASH"] == hash_values(
      params["TIMESTAMP"],
      params["MERCHANT_ID"],
      params["ORDER_ID"],
      params["RESULT"],
      params["MESSAGE"],
      params["PASREF"],
      params["AUTHCODE"]
    )
  end

  private

  def hash_values *vals
    first_pass = Digest::SHA1.hexdigest contcat_values(*vals)
    second_pass = Digest::SHA1.hexdigest contcat_values(first_pass, shared_secret)
  end

  def contcat_values *vals
    [*vals].join(".")
  end

end
