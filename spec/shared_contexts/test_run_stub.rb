shared_context 'test run stub' do
  def all_action_stub
    action_stub_with_query(:test_run, :all, 'test_runs')
  end

  def create_action_stub
    action_stub_with_body(:test_run, :create, :post, 'test_runs')
  end

  def update_action_stub
    action_stub_with_body(:test_run, :update, :put, "test_runs/#{DATA['test_run']['attrs']['id']}")
  end

  def show_action_stub
    action_stub_with_query(:test_run, :show, "test_runs/#{DATA['test_run']['attrs']['id']}")
  end

  def delete_action_stub
    action_stub_with_body(:test_run, :delete, :delete, "test_runs/#{DATA['test_run']['attrs']['id']}")
  end
end
