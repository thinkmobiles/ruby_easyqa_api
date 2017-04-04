module EasyqaApi
  class Role < Item
    attr_accessor :role, :id, :attributes

    install_class_methods!

    def self.all(organization_id, user = @@default_user)
      send_request("organizations/#{organization_id}/roles", :get) do |req|
        req.params = {
          auth_token: user.auth_token
        }
      end
    end

    def create(attrs, user = @@default_user)
      @attributes = send_request("organizations/#{attrs[:organization_id]}/roles", :post) do |req|
        req.body = {
          auth_token: user.auth_token
        }.merge(attrs.except(:organization_id))
      end
    end

    def show(id = @id, user = @@default_user)
      @attributes = send_request("roles/#{id}", :get) do |req|
        req.params = {
          auth_token: user.auth_token
        }
      end
    end

    def update(role, id = @id, user = @@default_user)
      @attributes = send_request("roles/#{id}", :put) do |req|
        req.body = {
          role: role,
          auth_token: user.auth_token
        }
      end
    end

    def delete(id = @id, user = @@default_user)
      @attributes = send_request("roles/#{id}", :delete) do |req|
        req.params = {
          auth_token: user.auth_token
        }
      end
    end
  end
end
