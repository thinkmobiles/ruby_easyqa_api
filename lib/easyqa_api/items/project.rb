# @!macro project_with_attrs
#   @macro item_action_return
#   @param attrs [Hash] attributes for action
#   @option attrs [String] :title title of organization

# @!macro project_without_attrs
#   @macro item_action_return
#   @param id [Fixnum] project id on EasyQA website
module EasyqaApi
  # Project representation from EasyQA
  class Project < Item
    # @macro default_attributes
    # @!attribute [rw] title
    #   @return [String] Project title on EasyQA website
    attr_accessor :title, :id, :attributes

    install_class_methods!

    # Retrieve all projects from user
    # @macro auth_user_param
    # @return [Array] list of projects on EasyQA website
    # @macro see_default_user
    def self.all(user = @@default_user)
      send_request('projects', :get) do |req|
        req.params = {
          auth_token: user.auth_token
        }
      end
    end

    # Create project on EasyQA.
    # @macro project_with_attrs
    # @option attrs [String] :organization_id organization id on EasyQA website
    def create(attrs, user = @@default_user)
      @attributes = send_request('projects', :post) do |req|
        req.body = {
          organization_id: attrs[:organization_id],
          project: attrs.except(:organization_id),
          auth_token: user.auth_token
        }
      end
    end

    # Show project from EasyQA.
    # @macro project_without_attrs
    def show(id = @id, user = @@default_user)
      @attributes = send_request("projects/#{id}", :get) do |req|
        req.params = {
          auth_token: user.auth_token
        }
      end
    end

    # Update project on EasyQA.
    # @macro project_with_attrs
    # @option attrs [String] :id project id on EasyQA website
    def update(attrs, user = @@default_user)
      attrs = { id: @id }.merge(attrs)
      @attributes = send_request("projects/#{attrs[:id]}", :put) do |req|
        req.body = {
          project: attrs.except(:id),
          auth_token: user.auth_token
        }
      end
    end

    # Delete project on EasyQA.
    # @macro project_without_attrs
    def delete(id = @id, user = @@default_user)
      @attributes = send_request("projects/#{id}", :delete) do |req|
        req.body = {
          auth_token: user.auth_token
        }
      end
    end
  end
end
