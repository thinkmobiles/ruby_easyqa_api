# @!macro test_case_with_attrs
#   @macro item_action_return_with_attrs
#   @option attrs [String] :title test case title on EasyQA website
#   @option attrs [String] :pre_steps test case pre steps
#   @option attrs [String] :steps Test Case steps.
#   @option attrs [String] :expected_result Test Case expected result.
#   @option attrs [String] :case_type Type of test case.
#     Can be 'positive', 'negative', 'boundary', 'integration', 'ui' or 'localization'
#   @see EasyqaApi::TestModule

# @!macro test_case_without_attrs
#   @macro item_action_return
#   @macro project_token_param
#   @!macro id_param
module EasyqaApi
  # Test case representation from EasyQA website
  class TestCase < Item
    # @macro default_attributes_with_project_token
    # @!attribute [rw] title
    #   @return [String] Test case title on EasyQA
    # @!attribute [rw] module_id
    #   @return [String] Test module id on EasyQA
    attr_accessor :title, :id, :attributes, :project_token, :module_id

    install_class_methods!

    # List of all test cases
    # @param attrs [Hash] attributes for action
    # @option attrs [String] :project_token project_token on EasyQA website
    # @option attrs [String] :parent_name Can be "test_plan" or "test_module".
    # @option attrs [Fixnum] :parent_id Id of test plan and test module according
    # @macro auth_user_param
    # @return [Array] list of test_cases on EasyQA website
    # @macro see_default_user
    def self.all(attrs, user = @@default_user)
      send_request("#{attrs[:parent_name]}/#{attrs[:parent_id]}/test_cases", :get) do |req|
        req.params = {
          auth_token: user.auth_token,
          token: attrs[:project_token]
        }
      end
    end

    # Create test case on EasyQA website.
    # @macro test_case_with_attrs
    # @option attrs [Fixnum] :test_module_id Test module id
    def create(attrs, user = @@default_user)
      attrs = { project_token: @project_token, module_id: @module_id }.merge(attrs)
      @attributes = send_request("test_modules/#{attrs[:module_id]}/test_cases", :post) do |req|
        req.body = {
          test_case: attrs.except(:project_token, :module_id),
          token: attrs[:project_token],
          auth_token: user.auth_token
        }
      end
    end

    # Show Test Case from EasyQA website.
    # @!macro test_case_without_attrs
    def show(project_token = @project_token, id = @id, user = @@default_user)
      @attributes = send_request("test_cases/#{id}", :get) do |req|
        req.params = {
          token: project_token,
          auth_token: user.auth_token
        }
      end
    end

    # Update Test Case on EasyQA website.
    # @!macro test_case_with_attrs
    # @option attrs [Fixnum] :id (@id) item id
    def update(attrs, user = @@default_user)
      attrs = { id: @id, project_token: @project_token }.merge(attrs)
      @attributes = send_request("test_cases/#{attrs[:id]}", :put) do |req|
        req.body = {
          test_case: attrs.except(:project_token, :id),
          token: attrs[:project_token],
          auth_token: user.auth_token
        }
      end
    end

    # Delete Test Case on EasyQA website.
    # @!macro test_case_without_attrs
    def delete(project_token = @project_token, id = @id, user = @@default_user)
      @attributes = send_request("test_cases/#{id}", :delete) do |req|
        req.body = {
          token: project_token,
          auth_token: user.auth_token
        }
      end
    end
  end
end
