module EasyqaApi
  class Project < Item
    attr_accessor :title, :id, :attributes

    install_class_methods!

    def self.all(user = @@default_user)
      send_request('projects', :get) do |req|
        req.params = {
          auth_token: user.auth_token
        }
      end
    end

    def create(attrs, user = @@default_user)
      @attributes = send_request('projects', :post) do |req|
        req.body = {
          organization_id: attrs[:organization_id],
          project: attrs.except(:organization_id),
          auth_token: user.auth_token
        }
      end
    end

    def show(id = @id, user = @@default_user)
      @attributes = send_request("projects/#{id}", :get) do |req|
        req.params = {
          auth_token: user.auth_token
        }
      end
    end

    def update(attrs, user = @@default_user)
      attrs = { id: @id }.merge(attrs)
      @attributes = send_request("projects/#{attrs[:id]}", :put) do |req|
        req.body = {
          project: attrs.except(:id),
          auth_token: user.auth_token
        }
      end
    end

    def delete(id = @id, user = @@default_user)
      @attributes = send_request("projects/#{id}", :delete) do |req|
        req.params = {
          auth_token: user.auth_token
        }
      end
    end
  end
end
