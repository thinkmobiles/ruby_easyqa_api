shared_context 'project stub' do
  def all_action_stub
    action_stub_with_query(:project, :all, 'projects')
  end

  def create_action_stub
    action_stub_with_body(:project, :create, :post, 'projects')
  end

  def update_action_stub
    action_stub_with_body(:project, :update, :put, "projects/#{DATA['project']['attrs']['id']}")
  end

  def show_action_stub
    action_stub_with_query(:project, :show, "projects/#{DATA['project']['attrs']['id']}")
  end

  def delete_action_stub
    action_stub_with_body(:project, :delete, :delete, "projects/#{DATA['project']['attrs']['id']}")
  end
end
