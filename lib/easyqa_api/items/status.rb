# @!macro status_with_attrs
#   @macro item_action_return_with_attrs_and_id
#   @option attrs [String] :name status name

# @!macro status_without_attributes
#   @macro item_action_return
#   @param id [Fixnum] status id on EasyQA website
#   @param project_token [Fixnum] project token on EasyQA website
module EasyqaApi
  # Status representation on EasyQA website
  class Status < Item
    # @macro default_attributes_with_project_token
    # @!attribute [rw] name
    #   @return [String] Status name on EasyQA
    attr_accessor :name, :id, :attributes, :project_token

    install_class_methods!

    # Retrieve all issues in project
    # @macro project_token_param
    # @macro auth_user_param
    # @return [Array] list of statuses on EasyQA website
    # @macro see_default_user
    def self.all(project_token, user = @@default_user)
      send_request('statuses', :get) do |req|
        req.params = {
          auth_token: user.auth_token,
          token: project_token
        }
      end
    end

    # Create status on EasyQA website
    # @macro status_with_attrs
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

    # Show status from EasyQA website
    # @macro status_without_attributes
    def show(project_token = @project_token, id = @id, user = @@default_user)
      @attributes = send_request("statuses/#{id}", :get) do |req|
        req.params = {
          token: project_token,
          auth_token: user.auth_token
        }
      end
    end

    # Update status on EasyQA website
    # @macro status_with_attrs
    # @option attrs [Fixnum] :id (@id) status id on EasyQA website
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

    # Delete status on EasyQA website
    # @macro status_without_attributes
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
