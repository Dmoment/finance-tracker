# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  :user_name => ENV['SENDGRID_USERNAME'],
  :password => 'SENDGRID_PASSWORD',
  :domain => 'heroku.com',
  :address => 'smtp.sendgrid.net',
  :port => '578',
  :authentication => :plain,
  :enable_starttls_auto => true
}
