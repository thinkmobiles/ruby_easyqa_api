shared_context 'organization stub' do
  def all_action_stub
    action_all_stub(:organization, 'organizations')
  end

  def create_action_stub
    action_stub(:organization, :create, :post, 'organizations')
  end

  def update_action_stub
    action_stub(:organization, :update, :put, "organizations/#{DATA['organization']['attrs']['id']}")
  end
end
