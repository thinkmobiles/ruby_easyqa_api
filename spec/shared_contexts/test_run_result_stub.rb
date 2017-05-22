shared_context 'test run result stub' do
  def all_action_stub
    action_stub_with_query(
      :test_run_result, :all, "test_runs/#{DATA['test_run_result']['attrs']['test_run_id']}/test_run_results"
    )
  end

  def update_action_stub
    action_stub_with_body(:test_run_result, :update, :put, "test_run_results/#{DATA['test_run_result']['attrs']['id']}")
  end

  def show_action_stub
    action_stub_with_query(:test_run_result, :show, "test_run_results/#{DATA['test_run_result']['attrs']['id']}")
  end

  def delete_action_stub
    action_stub_with_body(
      :test_run_result, :delete, :delete, "test_run_results/#{DATA['test_run_result']['attrs']['id']}"
    )
  end
end
