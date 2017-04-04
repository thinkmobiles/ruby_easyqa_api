module EasyqaApi
  class Organization < Item
    attr_accessor :title, :description, :id, :attributes

    install_class_methods!

    def self.all(user = @@default_user)
      send_request('organizations', :get) do |req|
        req.params = {
          auth_token: user.auth_token
        }
      end
    end

    def create(attrs, user = @@default_user)
      @attributes = send_request('organizations', :post) do |req|
        req.body = {
          organization: attrs,
          auth_token: user.auth_token
        }
      end
    end

    def show(id = @id, user = @@default_user)
      @attributes = send_request("organizations/#{id}", :get) do |req|
        req.params = {
          auth_token: user.auth_token
        }
      end
    end

    def update(attrs, user = @@default_user)
      attrs = { id: @id }.merge(attrs)
      @attributes = send_request("organizations/#{attrs[:id]}", :put) do |req|
        req.body = {
          organization: attrs.except(:id),
          auth_token: user.auth_token
        }
      end
    end

    def delete(id = @id, user = @@default_user)
      @attributes = send_request("organizations/#{id}", :delete) do |req|
        req.params = {
          auth_token: user.auth_token
        }
      end
    end
  end
end
