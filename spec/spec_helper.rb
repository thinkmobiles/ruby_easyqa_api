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

def action_stub_with_body(object_name, action_name, http_method, stubbing_url)
  stub_request(http_method, "#{BASE_URL}#{stubbing_url}")
    .with(body: hash_including(DATA[object_name.to_s]['webmock'][action_name.to_s]['success']['request']['body']))
    .to_return(body: DATA[object_name.to_s]['webmock'][action_name.to_s]['success']['response']['body'].to_json)

  stub_request(http_method, "#{BASE_URL}#{stubbing_url}").with do |req|
    JSON.parse(req.body)['auth_token'] != DATA['user']['attrs']['auth_token']
  end.to_return(
    body: DATA[object_name.to_s]['webmock'][action_name.to_s]['error']['response']['body'].to_json,
    status: DATA[object_name.to_s]['webmock'][action_name.to_s]['error']['response']['status']
  )
end

def action_stub_with_query(object_name, action_name, stubbing_url)
  stub_request(:get, "#{BASE_URL}#{stubbing_url}")
    .with(query: hash_including(auth_token: DATA['user']['attrs']['auth_token']))
    .to_return(
      body: DATA[object_name.to_s]['webmock'][action_name.to_s]['success']['response']['body'].to_json
    )

  stub_request(:get, "#{BASE_URL}#{stubbing_url}")
    .with(query: hash_excluding(auth_token: DATA['user']['attrs']['auth_token']))
    .to_return(
      body: DATA[object_name.to_s]['webmock'][action_name.to_s]['error']['response']['body'].to_json,
      status: DATA[object_name.to_s]['webmock'][action_name.to_s]['error']['response']['status']
    )
end
