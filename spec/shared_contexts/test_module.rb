shared_context 'test module stub' do
  def all_action_stub
    action_stub_with_query(
      :test_module, :all, "test_plans/#{DATA['test_module']['attrs']['test_plan_id']}/test_modules"
    )
  end

  def create_action_stub
    action_stub_with_body(
      :test_module, :create, :post, "test_plans/#{DATA['test_module']['attrs']['test_plan_id']}/test_modules"
    )
  end

  def update_action_stub
    action_stub_with_body(:test_module, :update, :put, "test_modules/#{DATA['test_module']['attrs']['id']}")
  end

  def show_action_stub
    action_stub_with_query(:test_module, :show, "test_modules/#{DATA['test_module']['attrs']['id']}")
  end

  def delete_action_stub
    action_stub_with_body(:test_module, :delete, :delete, "test_modules/#{DATA['test_module']['attrs']['id']}")
  end
end
