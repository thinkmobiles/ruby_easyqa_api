module EasyqaApi
  class TestCase < Item
    attr_accessor :title, :id, :attributes, :project_token, :module_id

    install_class_methods!

    def self.all(attrs, user = @@default_user)
      send_request("#{attrs[:parent_name]}/#{attrs[:parent_id]}/test_cases", :get) do |req|
        req.params = {
          auth_token: user.auth_token,
          token: attrs[:project_token]
        }
      end
    end

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

    def show(project_token = @project_token, id = @id, user = @@default_user)
      @attributes = send_request("test_cases/#{id}", :get) do |req|
        req.params = {
          token: project_token,
          auth_token: user.auth_token
        }
      end
    end

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

    def delete(project_token = @project_token, id = @id, user = @@default_user)
      @attributes = send_request("test_cases/#{id}", :delete) do |req|
        req.params = {
          token: project_token,
          auth_token: user.auth_token
        }
      end
    end
  end
end
