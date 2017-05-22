# @!macro role_with_attrs
#   @macro item_action_return
#   @param attrs [Hash] action attributes
#   @option attrs [String] :role role name

# @!macro role_without_attrs
#   @macro item_action_return
#   @param id [String] role id on EasyQA website
module EasyqaApi
  # Role representation from EasyQA website
  #   Project role can be 'developer', 'tester', 'viewer' or 'project_manager'
  #   Organization role can be 'user' or 'admin'
  class Role < Item
    # @macro default_attributes
    # @!attribute [rw] role
    #   @return [String] Role user in currentproject or organization
    attr_accessor :role, :id, :attributes

    install_class_methods!

    # Retrieve all roles from organization
    # @macro auth_user_param
    # @param organization_id [Fixnum] Organization id on EasyQA website
    # @return [Array] list of organization roles on EasyQA website
    # @macro see_default_user
    def self.all(organization_id, user = @@default_user)
      send_request("organizations/#{organization_id}/roles", :get) do |req|
        req.params = {
          auth_token: user.auth_token
        }
      end
    end

    # Create role on EasyQA website.
    # @!macro role_with_attrs
    # @option attrs [Fixnum] :organization_id organization id on EasyQA website
    # @option attrs [Fixnum] :user_id user id on EasyQA website.
    # @option attrs [String] :project_token Project token on EasyQA. Add this option if you want create project role
    def create(attrs, user = @@default_user)
      @attributes = send_request(
        "organizations/#{attrs[:organization_id] || attrs['organization_id']}/roles", :post
      ) do |req|
        req.body = {
          auth_token: user.auth_token
        }.merge(attrs.except(:organization_id, 'organization_id'))
      end
    end

    # Show role from EasyQA website.
    # @macro role_without_attrs
    def show(id = @id, user = @@default_user)
      @attributes = send_request("roles/#{id}", :get) do |req|
        req.params = {
          auth_token: user.auth_token
        }
      end
    end

    # Update role on EasyQA website.
    # @macro role_without_attrs
    # @param role [Fixnum] role name on EasyQA website
    def update(role, id = @id, user = @@default_user)
      @attributes = send_request("roles/#{id}", :put) do |req|
        req.body = {
          role: role,
          auth_token: user.auth_token
        }
      end
    end

    # Delete role on EasyQA website.
    # @macro role_without_attrs
    def delete(id = @id, user = @@default_user)
      @attributes = send_request("roles/#{id}", :delete) do |req|
        req.body = {
          auth_token: user.auth_token
        }
      end
    end
  end
end
