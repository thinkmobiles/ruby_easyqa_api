require 'spec_helper'

describe EasyqaApi do
  it 'has a version number' do
    expect(EasyqaApi::VERSION).not_to be nil
  end

  it 'Api path must be 1 version' do
    expect(EasyqaApi.configuration.api_path).to eq('/api/v1/')
  end

  it 'Url must be localhost' do
    expect(EasyqaApi.configuration.url).to eq('http://localhost:3000/')
  end
end
