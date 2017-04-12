$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'simplecov'
require 'pry'

SimpleCov.start do
  add_filter 'spec/'
end

require 'easyqa_api'

EasyqaApi.setup do |config|
  config.url = 'http://localhost:3000/'
end

def create_user_with_email_and_password
  EasyqaApi::User.new(email: 'test@mail.com', password: '1234567890')
end
