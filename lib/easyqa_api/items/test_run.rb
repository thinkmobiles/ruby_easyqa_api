# @!macro test_run_with_attrs
#   @macro item_action_return
#   @param [Hash] attrs
#     * :project_token (String) [@project_token] Project token on EasyQA
#     * :title (String) test run title on EasyQA website
#     * :assigner_id (Fixnum) test run assigner id on EasyQA website
#     * :description (String) test run description on EasyQA website
#     * :test_run_result_attributes (Array<Hash>) attributes of test run results.
#       * :test_plan_id (Fixnum) id of test plan
#       * :test_case_id (Fixnum) test case id
#       * :id (Fixnum) test run result id
#       * :_destroy (TrueClass, FalseClass) if you set this
#         attribute true with attribute id, this test run result will be deleted
#   @note If you add test plan id to tes_run_result_attributes all test cases from this test plan
#     has been included to your test run

# @!macro test_run_without_attrs
#   @macro item_action_return
#   @macro project_token_param
#   @macro id_param
module EasyqaApi
  # Test Run representation from EasyQA website
  class TestRun < Item
    attr_accessor :title, :id, :attributes, :project_token

    install_class_methods!

    # List of all test runs in project
    # @macro auth_user_param
    # @macro project_token_param
    # @return [Array] list of test runs on EasyQA website
    # @macro see_default_user
    def self.all(project_token, user = @@default_user)
      send_request('test_runs', :get) do |req|
        req.params = {
          auth_token: user.auth_token,
          token: project_token
        }
      end
    end

    # Create test run on EasyQA website.
    # @macro test_run_with_attrs
    def create(attrs, user = @@default_user)
      attrs = { project_token: @project_token }.merge(attrs)
      @attributes = send_request('test_runs', :post) do |req|
        req.body = {
          test_run: attrs.except(:project_token),
          token: attrs[:project_token],
          auth_token: user.auth_token
        }
      end
    end

    # Show test run from EasyQA website.
    # @!macro test_run_without_attrs
    def show(project_token = @project_token, id = @id, user = @@default_user)
      @attributes = send_request("test_runs/#{id}", :get) do |req|
        req.params = {
          token: project_token,
          auth_token: user.auth_token
        }
      end
    end

    # Update test run on EasyQA website.
    # @macro test_run_with_attrs
    # @option attrs [Fixnum] :id (@id) test run id
    def update(attrs, user = @@default_user)
      attrs = { id: @id, project_token: @project_token }.merge(attrs)
      @attributes = send_request("test_runs/#{attrs[:id]}", :put) do |req|
        req.body = {
          test_run: attrs.except(:project_token, :id),
          token: attrs[:project_token],
          auth_token: user.auth_token
        }
      end
    end

    # Delete test run on EasyQA website.
    # @!macro test_run_without_attrs
    def delete(project_token = @project_token, id = @id, user = @@default_user)
      @attributes = send_request("test_runs/#{id}", :delete) do |req|
        req.params = {
          token: project_token,
          auth_token: user.auth_token
        }
      end
    end
  end
end
