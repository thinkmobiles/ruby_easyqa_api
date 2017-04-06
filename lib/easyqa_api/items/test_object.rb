module EasyqaApi
  class TestObject < Item
    attr_accessor :id, :attributes, :project_token

    install_class_methods! except: [:update]

    def self.all(project_token, user = @@default_user)
      send_request('test_objects', :get) do |req|
        req.params = {
          auth_token: user.auth_token,
          token: project_token
        }
      end
    end

    def create(attrs, user = @@default_user)
      attrs = { project_token: @project_token }.merge(attrs)
      @attributes = send_request('test_objects', :post, :multipart) do |req|
        req.body = {
          token: attrs[:project_token],
          auth_token: user.auth_token
        }.merge(attrs.except(:project_token))
      end
    end

    def show(project_token = @project_token, id = @id, user = @@default_user)
      @attributes = send_request("test_objects/#{id}", :get) do |req|
        req.params = {
          token: project_token,
          auth_token: user.auth_token
        }
      end
    end

    def delete(project_token = @project_token, id = @id, user = @@default_user)
      @attributes = send_request("test_objects/#{id}", :delete) do |req|
        req.params = {
          token: project_token,
          auth_token: user.auth_token
        }
      end
    end
  end
end
