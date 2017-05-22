shared_context 'test case stub' do
  def all_action_stub
    action_stub_with_query(:test_case, :all, "test_plan/#{DATA['test_case']['attrs']['test_plan_id']}/test_cases")
  end

  def create_action_stub
    action_stub_with_body(
      :test_case, :create, :post, "test_modules/#{DATA['test_case']['attrs']['module_id']}/test_cases"
    )
  end

  def update_action_stub
    action_stub_with_body(:test_case, :update, :put, "test_cases/#{DATA['test_case']['attrs']['id']}")
  end

  def show_action_stub
    action_stub_with_query(:test_case, :show, "test_cases/#{DATA['test_case']['attrs']['id']}")
  end

  def delete_action_stub
    action_stub_with_body(:test_case, :delete, :delete, "test_cases/#{DATA['test_case']['attrs']['id']}")
  end
end
