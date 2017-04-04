module EasyqaApi
  class TestModule < Item
    attr_accessor :title, :id, :attributes, :project_token, :test_plan_id

    install_class_methods!

    def self.all(project_token, test_plan_id, user = @@default_user)
      send_request("test_plans/#{test_plan_id}/test_modules", :get) do |req|
        req.params = {
          auth_token: user.auth_token,
          token: project_token
        }
      end
    end

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

    def show(project_token = @project_token, id = @id, user = @@default_user)
      @attributes = send_request("test_modules/#{id}", :get) do |req|
        req.params = {
          token: project_token,
          auth_token: user.auth_token
        }
      end
    end

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
