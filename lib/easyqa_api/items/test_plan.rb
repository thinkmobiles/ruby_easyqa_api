# @!macro test_plan_with_attrs
#   @macro item_action_return_with_attrs
#   @option attrs [String] :title test plan title on EasyQA website
#   @option attrs [String] :description test case pre steps

# @!macro test_plan_without_attrs
#   @macro item_action_return
#   @macro project_token_param
#   @macro id_param
module EasyqaApi
  # Test plan representation from EasyQA website
  class TestPlan < Item
    # @macro default_attributes_with_project_token
    # @!attribute [rw] title
    #   @return [String] Test plan title on EasyQA
    attr_accessor :title, :id, :attributes, :project_token

    install_class_methods!

    # List of all test plans in project
    # @macro auth_user_param
    # @macro project_token_param
    # @return [Array] list of test plans on EasyQA website
    # @macro see_default_user
    def self.all(project_token, user = @@default_user)
      send_request('test_plans', :get) do |req|
        req.params = {
          auth_token: user.auth_token,
          token: project_token
        }
      end
    end

    # Create test plan on EasyQA website.
    # @macro test_plan_with_attrs
    def create(attrs, user = @@default_user)
      attrs = { project_token: @project_token }.merge(attrs)
      @attributes = send_request('test_plans', :post) do |req|
        req.body = {
          test_plan: attrs.except(:project_token),
          token: attrs[:project_token],
          auth_token: user.auth_token
        }
      end
    end

    # Show test plan from EasyQA website.
    # @macro test_plan_without_attrs
    def show(project_token = @project_token, id = @id, user = @@default_user)
      @attributes = send_request("test_plans/#{id}", :get) do |req|
        req.params = {
          token: project_token,
          auth_token: user.auth_token
        }
      end
    end

    # Update test plan on EasyQA website.
    # @macro test_plan_with_attrs
    # @option attrs [Fixnum] :id (@id) test plan id on EasyQA website
    def update(attrs, user = @@default_user)
      attrs = { id: @id, project_token: @project_token }.merge(attrs)
      @attributes = send_request("test_plans/#{attrs[:id]}", :put) do |req|
        req.body = {
          test_plan: attrs.except(:project_token, :id),
          token: attrs[:project_token],
          auth_token: user.auth_token
        }
      end
    end

    # Delete test plan on EasyQA website.
    # @macro test_plan_without_attrs
    def delete(project_token = @project_token, id = @id, user = @@default_user)
      @attributes = send_request("test_plans/#{id}", :delete) do |req|
        req.body = {
          token: project_token,
          auth_token: user.auth_token
        }
      end
    end
  end
end
