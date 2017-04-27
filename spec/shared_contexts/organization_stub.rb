shared_context 'organization stub' do
  def all_action_stub
    action_stub_with_query(:organization, :all, 'organizations')
  end

  def create_action_stub
    action_stub_with_body(:organization, :create, :post, 'organizations')
  end

  def update_action_stub
    action_stub_with_body(:organization, :update, :put, "organizations/#{DATA['organization']['attrs']['id']}")
  end

  def show_action_stub
    action_stub_with_query(:organization, :show, "organizations/#{DATA['organization']['attrs']['id']}")
  end

  def delete_action_stub
    action_stub_with_body(:organization, :delete, :delete, "organizations/#{DATA['organization']['attrs']['id']}")
  end
end
