shared_context 'issue stub' do
  def all_action_stub
    action_stub_with_query(:issue, :all, 'issues')
  end

  def create_action_stub
    action_stub_with_body(:issue, :create, :post, 'projects/issues/create')
  end

  def update_action_stub
    action_stub_with_body(:issue, :update, :put, "issues/#{DATA['issue']['attrs']['id']}")
  end

  def show_action_stub
    action_stub_with_query(:issue, :show, "issues/#{DATA['issue']['attrs']['id']}")
  end

  def delete_action_stub
    action_stub_with_body(:issue, :delete, :delete, "issues/#{DATA['issue']['attrs']['id']}")
  end
end
