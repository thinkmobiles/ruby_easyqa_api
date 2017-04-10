# @!macro test_run_results_without_attrs
#   @macro item_action_return
#   @macro project_token_param
#   @macro id_param
module EasyqaApi
  # Test run result representation from EasyQA website
  class TestRunResult < Item
    # @macro default_attributes_with_project_token
    # @!attribute [rw] test_run_id
    #   @return [String] Test run id on EasyQA
    attr_accessor :id, :attributes, :project_token, :test_run_id

    install_class_methods!

    # List of all test run results in test run
    # @macro auth_user_param
    # @macro project_token_param
    # @param test_run_id [Fixnum] test run id on EasyQA website
    # @return [Array] list of test run results
    # @macro see_default_user
    def self.all(project_token, test_run_id, user = @@default_user)
      send_request("test_runs/#{test_run_id}/test_run_results", :get) do |req|
        req.params = {
          auth_token: user.auth_token,
          token: project_token
        }
      end
    end

    # Show test run result from EasyQA website
    # @macro test_run_results_without_attrs
    def show(project_token = @project_token, id = @id, user = @@default_user)
      @attributes = send_request("test_run_results/#{id}", :get) do |req|
        req.params = {
          token: project_token,
          auth_token: user.auth_token
        }
      end
    end

    # @macro item_action_return_with_attrs_and_id
    # @option attrs [Fixnum] :test_case_id test case id on EasyQA website
    # @option attrs [String] :result_status test run result status
    # @note test_run_result_status can be 'pass', 'block', 'untested' or 'fail'
    def update(attrs, user = @@default_user)
      attrs = { id: @id, project_token: @project_token }.merge(attrs)
      @attributes = send_request("test_run_results/#{attrs[:id]}", :put) do |req|
        req.body = {
          test_run_result: attrs.except(:project_token, :id),
          token: attrs[:project_token],
          auth_token: user.auth_token
        }
      end
    end

    # Delete test run result on EasyQA website
    # @macro test_run_results_without_attrs
    def delete(project_token = @project_token, id = @id, user = @@default_user)
      @attributes = send_request("test_run_results/#{id}", :delete) do |req|
        req.params = {
          token: project_token,
          auth_token: user.auth_token
        }
      end
    end
  end
end
