shared_context 'organization stub' do
  def all_action_stub
    stub_request(:get, "#{BASE_URL}organizations")
      .with(query: hash_including(auth_token: DATA['user']['attrs']['auth_token']))
      .to_return(
        body: DATA['organization']['webmock']['all']['success']['response']['body'].to_json
      )

    stub_request(:get, "#{BASE_URL}organizations")
      .with(query: hash_excluding(auth_token: DATA['user']['attrs']['auth_token']))
      .to_return(
        body: DATA['organization']['webmock']['all']['error']['response']['body'].to_json,
        status: DATA['organization']['webmock']['all']['error']['response']['status']
      )
  end

  def create_action_stub
    stub_request(:post, "#{BASE_URL}organizations")
      .with(body: DATA['organization']['webmock']['create']['success']['request']['body'].to_json)
      .to_return(body: DATA['organization']['webmock']['create']['success']['response']['body'].to_json)

    stub_request(:post, "#{BASE_URL}organizations").with do |req|
      JSON.parse(req.body)['auth_token'] != DATA['user']['attrs']['auth_token']
    end.to_return(
      body: DATA['organization']['webmock']['create']['error']['response']['body'].to_json,
      status: DATA['organization']['webmock']['create']['error']['response']['status']
    )
  end
end
