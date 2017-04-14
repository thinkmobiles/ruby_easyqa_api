$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'pry'
Dir['spec/shared_*/*.rb'].each { |file_path| require_relative file_path[%r{(?<=spec\/).*}] }
require 'simplecov'
require 'webmock/rspec'

WebMock.disable_net_connect!
SimpleCov.start do
  add_filter 'spec/'
end

require 'easyqa_api'

EasyqaApi.setup do |config|
  config.url = 'http://localhost:3000'
end

BASE_URL = (EasyqaApi.configuration.url + EasyqaApi.configuration.api_path).freeze
DATA = YAML.load_file('spec/data.yml').freeze
