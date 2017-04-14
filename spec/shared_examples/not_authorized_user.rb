shared_examples 'action without logined user' do |action|
  it 'should be error' do
    expect do
      attrs = method_attrs[action].clone
      if attrs[-1].is_a? EasyqaApi::User
        attrs[-1] = EasyqaApi::User.new
      else
        attrs << EasyqaApi::User.new
      end

      item.send(action, *attrs)
    end.to raise_error(EasyqaApi::Exception::NotFoundError, 'User not found')
  end
end
