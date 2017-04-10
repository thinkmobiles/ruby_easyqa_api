# @!macro organization_with_attrs
#   @macro item_action_return
#   @param attrs [Hash] attributes for action
#   @option attrs [String] :title title of organization
#   @option attrs [String] :description description of organization

# @!macro organization_without_attrs
#   @macro item_action_return
#   @param id [Fixnum] organization id on EasyQA website
module EasyqaApi
  # Organization representation from EasyQA
  class Organization < Item
    # @macro default_attributes
    # @!attribute [rw] title
    #   @return [String] Title of organization on EasyQA
    attr_accessor :title, :id, :attributes

    install_class_methods!

    # Retrieve all organizations from user
    # @macro auth_user_param
    # @return [Array] list of organizations on EasyQA website
    # @macro see_default_user
    def self.all(user = @@default_user)
      send_request('organizations', :get) do |req|
        req.params = {
          auth_token: user.auth_token
        }
      end
    end

    # Create organization on EasyQA website
    # @!macro organization_with_attrs
    def create(attrs, user = @@default_user)
      @attributes = send_request('organizations', :post) do |req|
        req.body = {
          organization: attrs,
          auth_token: user.auth_token
        }
      end
    end

    # Show a organization on EasyQA website
    # @!macro organization_without_attrs
    def show(id = @id, user = @@default_user)
      @attributes = send_request("organizations/#{id}", :get) do |req|
        req.params = {
          auth_token: user.auth_token
        }
      end
    end

    # Update organization on EasyQA website
    # @!macro organization_with_attrs
    # @option attrs [Fixnum] :id (@id) organization id on EasyQA website
    def update(attrs, user = @@default_user)
      attrs = { id: @id }.merge(attrs)
      @attributes = send_request("organizations/#{attrs[:id]}", :put) do |req|
        req.body = {
          organization: attrs.except(:id),
          auth_token: user.auth_token
        }
      end
    end

    # Delete organization on EasyQA website
    # @!macro organization_without_attrs
    def delete(id = @id, user = @@default_user)
      @attributes = send_request("organizations/#{id}", :delete) do |req|
        req.params = {
          auth_token: user.auth_token
        }
      end
    end
  end
end
