# Load the Rails application.
require_relative 'application'

# environment variables for paperclip
app_environment_variables = File.join(Rails.root, 'config', 'app_environment_variables.rb')
load(app_environment_variables) if File.exists?(app_environment_variables)
# environment variables for paperclip 

# Initialize the Rails application.
Rails.application.initialize!
