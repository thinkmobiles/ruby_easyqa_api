# @!macro [new] issue_attributes_simple
#   @macro item_action_return_with_attrs_and_id
#   @option attrs [Fixnum] :id_in_project uniq issue identeficator in project

# @!macro [new] issue_attributes
#   @macro item_action_return
#   @param [Hash] attrs attributes for action
#   @option attrs [String] :project_token (@project_token) token of Project on EasyQA
#   @option attrs [String] :summary issue summary. This options required for create issue
#   @option attrs [Fixnum] :test_object_id test object uniq identefiactor on EasyQA
#   @option attrs [String] :description issue description
#   @option attrs [String] :issue_type Issue type.
#     Can be in 'no_type', 'documentation', 'task', 'feature', 'usability_problem', 'bug', 'crash'
#   @option attrs [String] :priority Issue priority.
#     Can be in 'low', 'medium', 'high', 'critical'
#   @option attrs [Fixnum] :assigner_id Issue assigner uniq identeficator on EasyQA
#   @option attrs [Array<Faraday::UploadIO>] :attachments Array of attachments
#   @see EasyqaApi::TestObject
module EasyqaApi
  # The class for representation EasyQA Issue object
  class Issue < Item
    # @!attribute [rw] id
    #   @return [Fixnum] The uniq identeficator issue in EasyQA website
    #   @return [String] The uniq identeficator issue in yuor project.
    #     In format "pid_your_id_"
    # @!attribute [rw] attributes
    #   @return [Hash] attributes item from response body in your requests
    # @!attribute [rw] project_token
    #   @return [String] your project token
    attr_accessor :id, :attributes, :project_token

    install_class_methods!

    # Retrieve all issues in project
    # @macro project_token_param
    # @macro auth_user_param
    # @return [Array] list of issues on EasyQA website
    # @macro see_default_user
    def self.all(project_token, user = @@default_user)
      send_request('issues', :get) do |req|
        req.params = {
          auth_token: user.auth_token,
          token: project_token
        }
      end
    end

    # Create new issue on EasyQA website.
    # @!macro issue_attributes
    def create(attrs, user = @@default_user)
      attrs = { project_token: @project_token }.merge(attrs)
      @attributes = send_request('projects/issues/create', :post, :multipart) do |req|
        req.body = {
          token: attrs[:project_token],
          auth_token: user.auth_token
        }.merge(attrs.except(:project_token, :attachments))
         .merge(retrieve_attachments(attrs[:attachments]))
      end
    end

    # Show issue attributes on EasyQA website.
    # @!macro issue_attributes_simple
    def show(attrs = {}, user = @@default_user)
      attrs = { id: @id, project_token: @project_token }.merge(attrs)
      attrs[:id] = "pid#{attrs.delete(:id_in_project)}" if attrs[:id_in_project]
      @attributes = send_request("issues/#{id}", :get) do |req|
        req.params = {
          token: attrs[:project_token],
          auth_token: user.auth_token
        }
      end
    end

    # Update issue on EasyQA website.
    # @!macro issue_attributes
    # @option attrs [Fixnum] :id_in_project uniq issue identeficator in project
    # @option attrs [Fixnum] :id uniq issue identeficator on EasyQA
    def update(attrs, user = @@default_user)
      attrs = { id: @id, project_token: @project_token }.merge(attrs)
      attrs[:id] = "pid#{attrs.delete(:id_in_project)}" if attrs[:id_in_project]
      @attributes = send_request("issues/#{attrs[:id]}", :put) do |req|
        req.body = {
          token: attrs[:project_token],
          auth_token: user.auth_token
        }.merge(attrs.except(:project_token))
      end
    end

    # Delete issue on EasyQA website.
    # @!macro issue_attributes_simple
    def delete(attrs = {}, user = @@default_user)
      attrs = { id: @id, project_token: @project_token }.merge(attrs)
      attrs[:id] = "pid#{attrs.delete(:id_in_project)}" if attrs[:id_in_project]
      @attributes = send_request("issues/#{attrs[:id]}", :delete) do |req|
        req.params = {
          token: attrs[:project_token],
          auth_token: user.auth_token
        }
      end
    end

    private

    def retrieve_attachments(attachments)
      iterator = 1
      attachments.each_with_object({}) do |attachment, hash|
        hash["attachment#{iterator += 1}"] = attachment
      end
    end
  end
end
