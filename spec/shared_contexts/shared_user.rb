shared_context 'shared user' do
  before(:all) do
    success_sign_in_stub
    @current_user = create_user_with_email_and_password
  end

  def create_user_with_email_and_password
    EasyqaApi::User.new(
      email: DATA['user']['attrs']['email'], password: DATA['user']['attrs']['password']
    )
  end

  def drop_default_user
    EasyqaApi::Item.class_variable_set('@@default_user', nil)
  end

  def success_sign_in_stub
    stub_request(:post, "#{BASE_URL}sign_in")
      .with(body: DATA['user']['webmock']['sign_in']['success']['request']['body'].to_json)
      .to_return(body: DATA['user']['webmock']['sign_in']['success']['response']['body'].to_json)
  end

  def error_sign_in_stub
    stub_request(:post, "#{BASE_URL}sign_in").with do |req|
      req.body != DATA['user']['webmock']['sign_in']['success']['request']['body'].to_json
    end.to_return(
      body: DATA['user']['webmock']['sign_in']['error']['response']['body'].to_json,
      status: DATA['user']['webmock']['sign_in']['error']['response']['status']
    )
  end

  def sign_out_stub
    stub_request(:delete, "#{BASE_URL}sign_out")
      .with(body: DATA['user']['webmock']['sign_out']['success']['request']['body'].to_json)
      .to_return(body: DATA['user']['webmock']['sign_out']['success']['response']['body'].to_json)
  end
end
