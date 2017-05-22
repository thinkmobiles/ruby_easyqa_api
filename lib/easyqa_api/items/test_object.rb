# @!macro test_object_params
#   @macro item_action_return
#   @macro project_token_param
#   @macro id_param
module EasyqaApi
  # Test object representation from EasyQA website
  class TestObject < Item
    # @macro default_attributes_with_project_token
    attr_accessor :id, :attributes, :project_token

    install_class_methods! except: [:update]

    # List of all test objects
    # @macro auth_user_param
    # @macro project_token_param
    # @return [Array] list of test objects on EasyQA website
    # @macro see_default_user
    def self.all(project_token, user = @@default_user)
      send_request('test_objects', :get) do |req|
        req.params = {
          auth_token: user.auth_token,
          token: project_token
        }
      end
    end

    # Create test object on EasyQA website
    # @macro item_action_return_with_attrs
    # @option attrs [String] :link link to your webiste for web object on EasyQA website
    # @option attrs [Faraday::UploadIO] :file your apk or ipa file
    def create(attrs, user = @@default_user)
      attrs = { project_token: @project_token }.merge(attrs)
      @attributes = send_request('test_objects', :post, :multipart) do |req|
        req.body = {
          token: attrs[:project_token],
          auth_token: user.auth_token
        }.merge(attrs.except(:project_token))
      end
    end

    # Show test object from EasyQA website
    # @macro test_object_params
    def show(project_token = @project_token, id = @id, user = @@default_user)
      @attributes = send_request("test_objects/#{id}", :get) do |req|
        req.params = {
          token: project_token,
          auth_token: user.auth_token
        }
      end
    end

    # Delete test object on EasyQA website
    # @macro test_object_params
    def delete(project_token = @project_token, id = @id, user = @@default_user)
      @attributes = send_request("test_objects/#{id}", :delete) do |req|
        req.body = {
          token: project_token,
          auth_token: user.auth_token
        }
      end
    end
  end
end
