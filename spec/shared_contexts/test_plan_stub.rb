shared_context 'test plan stub' do
  def all_action_stub
    action_stub_with_query(:test_plan, :all, 'test_plans')
  end

  def create_action_stub
    action_stub_with_body(:test_plan, :create, :post, 'test_plans')
  end

  def update_action_stub
    action_stub_with_body(:test_plan, :update, :put, "test_plans/#{DATA['test_plan']['attrs']['id']}")
  end

  def show_action_stub
    action_stub_with_query(:test_plan, :show, "test_plans/#{DATA['test_plan']['attrs']['id']}")
  end

  def delete_action_stub
    action_stub_with_body(:test_plan, :delete, :delete, "test_plans/#{DATA['test_plan']['attrs']['id']}")
  end
end
