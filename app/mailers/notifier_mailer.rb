class NotifierMailer < Spree::BaseMailer
  helper "spree/base"

  # Spree Handles adding all the "From" and overriding "To" for Dev Envs

  def contact_email(params)
		@params = params
    message_id = "ID%0#{8}d" %[rand(99999999)]
		mail(:to => I18n.t('contact_email'),
         :from => from_address,
         :subject => "SoulPad Contact Message #{message_id}")
  end

end
