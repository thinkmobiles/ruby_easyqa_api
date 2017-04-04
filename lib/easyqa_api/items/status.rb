module EasyqaApi
  class Status < Item
    attr_accessor :name, :id, :attributes, :project_token

    install_class_methods!

    def self.all(project_token, user = @@default_user)
      send_request('statuses', :get) do |req|
        req.params = {
          auth_token: user.auth_token,
          token: project_token
        }
      end
    end

    def create(attrs, user = @@default_user)
      attrs = { project_token: @project_token }.merge(attrs)
      @attributes = send_request('statuses', :post) do |req|
        req.body = {
          status_object: attrs.slice(:name),
          token: attrs[:project_token],
          auth_token: user.auth_token
        }
      end
    end

    def show(project_token = @project_token, id = @id, user = @@default_user)
      @attributes = send_request("statuses/#{id}", :get) do |req|
        req.params = {
          token: project_token,
          auth_token: user.auth_token
        }
      end
    end

    def update(attrs, user = @@default_user)
      attrs = { id: @id, project_token: @project_token }.merge(attrs)
      @attributes = send_request("statuses/#{attrs[:id]}", :put) do |req|
        req.body = {
          status_object: attrs.slice(:name),
          token: attrs[:project_token],
          auth_token: user.auth_token
        }
      end
    end

    def delete(project_token = @project_token, id = @id, user = @@default_user)
      @attributes = send_request("statuses/#{id}", :delete) do |req|
        req.params = {
          token: project_token,
          auth_token: user.auth_token
        }
      end
    end
  end
end
