shared_context 'role stub' do
  def all_action_stub
    action_stub_with_query(:role, :all, "organizations/#{DATA['role']['attrs']['organization_id']}/roles")
  end

  def create_action_stub
    action_stub_with_body(:role, :create, :post, "organizations/#{DATA['role']['attrs']['organization_id']}/roles")
  end

  def update_action_stub
    action_stub_with_body(:role, :update, :put, "roles/#{DATA['role']['attrs']['id']}")
  end

  def show_action_stub
    action_stub_with_query(:role, :show, "roles/#{DATA['role']['attrs']['id']}")
  end

  def delete_action_stub
    action_stub_with_body(:role, :delete, :delete, "roles/#{DATA['role']['attrs']['id']}")
  end
end
