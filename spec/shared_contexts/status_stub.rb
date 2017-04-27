shared_context 'status stub' do
  def all_action_stub
    action_stub_with_query(:status, :all, 'statuses')
  end

  def create_action_stub
    action_stub_with_body(:status, :create, :post, 'statuses')
  end

  def update_action_stub
    action_stub_with_body(:status, :update, :put, "statuses/#{DATA['status']['attrs']['id']}")
  end

  def show_action_stub
    action_stub_with_query(:status, :show, "statuses/#{DATA['status']['attrs']['id']}")
  end

  def delete_action_stub
    action_stub_with_body(:status, :delete, :delete, "statuses/#{DATA['status']['attrs']['id']}")
  end
end
