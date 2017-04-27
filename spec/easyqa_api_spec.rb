require 'spec_helper'

describe EasyqaApi do
  it('has a version number') { expect(EasyqaApi::VERSION).not_to be nil }
  it('Api path must be 1 version') { expect(EasyqaApi.configuration.api_path).to eq('/api/v1/') }
  it('Url must be localhost') { expect(EasyqaApi.configuration.url).to eq('http://localhost:3000') }
end
