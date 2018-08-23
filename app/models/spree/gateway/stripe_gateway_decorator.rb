Spree::Gateway::StripeGateway.class_eval do
  # Override to add response.params['default_source'] to gateway_payment_profile_id
  def create_profile(payment)
    return unless payment.source.gateway_customer_profile_id.nil?

    options = {
      email: payment.order.email,
      login: preferred_login
    }.merge! address_for(payment)

    source = update_source!(payment.source)

    response = provider.store(source, options)
    if response.success?
      payment.source.update_attributes!({
        :cc_type => payment.source.cc_type, # side-effect of update_source!
        :gateway_customer_profile_id => response.params['id'],
        :gateway_payment_profile_id => response.params['default_source'] || response.params['default_card']
      })

    else
      payment.send(:gateway_error, response.message)
    end
  end
end
