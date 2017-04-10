# @!macro test_module_with_attrs
#   @macro item_action_return_with_attrs
#   @option attrs [String] :title test module title on EasyQA website
#   @option attrs [String] :description test module description
#   @option attrs [Fixnum] :parent_id id of parent test module.
#     If you give this parameter, this test module will be nested in parent test module.
#   @see EasyqaApi::TestPlan

# @!macro test_module_without_attrs
#   @macro item_action_return
#   @macro project_token_param
#   @!macro id_param
module EasyqaApi
  # Test module representation from EasyQA website
  class TestModule < Item
    # @macro default_attributes_with_project_token
    # @!attribute [rw] title
    #   @return [String] Test module title on EasyQA
    # @!attribute [rw] test_plan_id
    #   @return [String] Test plan id on EasyQA
    attr_accessor :title, :id, :attributes, :project_token, :test_plan_id

    install_class_methods!

    # List of all test modules
    # @param test_plan_id [Fixnum] Test plan id on EasyQA website
    # @macro project_token_param
    # @macro auth_user_param
    # @return [Array] list of test modules on EasyQA website
    # @macro see_default_user
    def self.all(project_token, test_plan_id, user = @@default_user)
      send_request("test_plans/#{test_plan_id}/test_modules", :get) do |req|
        req.params = {
          auth_token: user.auth_token,
          token: project_token
        }
      end
    end

    # Create test module on EasyQA website.
    # @macro test_module_with_attrs
    # @option attrs [Fixnum] :test_plan_id (@test_plan_id) Test plan id
    def create(attrs, user = @@default_user)
      attrs = { project_token: @project_token, test_plan_id: @test_plan_id }.merge(attrs)
      @attributes = send_request("test_plans/#{attrs[:test_plan_id]}/test_modules", :post) do |req|
        req.body = {
          test_module: attrs.except(:project_token, :test_plan_id),
          token: attrs[:project_token],
          auth_token: user.auth_token
        }
      end
    end

    # Show Test Case from EasyQA website.
    # @!macro test_module_without_attrs
    def show(project_token = @project_token, id = @id, user = @@default_user)
      @attributes = send_request("test_modules/#{id}", :get) do |req|
        req.params = {
          token: project_token,
          auth_token: user.auth_token
        }
      end
    end

    # Update Test Case on EasyQA website.
    # @!macro test_module_with_attrs
    # @option attrs [Fixnum] :id (@id) item id
    def update(attrs, user = @@default_user)
      attrs = { id: @id, project_token: @project_token }.merge(attrs)
      @attributes = send_request("test_modules/#{attrs[:id]}", :put) do |req|
        req.body = {
          test_module: attrs.except(:project_token),
          token: attrs[:project_token],
          auth_token: user.auth_token
        }
      end
    end

    # Delete Test Case on EasyQA website.
    # @!macro test_module_without_attrs
    def delete(project_token = @project_token, id = @id, user = @@default_user)
      @attributes = send_request("test_modules/#{id}", :delete) do |req|
        req.params = {
          token: project_token,
          auth_token: user.auth_token
        }
      end
    end
  end
end
