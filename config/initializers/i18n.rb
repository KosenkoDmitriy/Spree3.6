require "i18n/backend/fallbacks"
I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)
I18n.fallbacks.map('en-AU' => 'en')
I18n.fallbacks.map('en-GB' => 'en')
