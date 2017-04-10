module EasyqaApi
  # Representation Issue attachment on EasyQA
  class IssueAttachment < Item
    # @macro default_attributes_with_project_token
    # @!attribute [rw] issue_id
    #   @return [Fixnum] The uniq identeficator issue in EasyQA website
    #   @return [String] The uniq identeficator issue in yuor project.
    #     In format "pid_your_id_"
    attr_accessor :id, :attributes, :project_token, :issue_id

    install_class_methods! only: [:create, :delete]

    # Create attachment on EasyQA website.
    # @macro item_action_return_with_attrs
    # @option attrs [Fixnum] :issue_id (@id) uniq issue identeficator
    # @option attrs [Fixnum] :issue_id_in_project (@id) uniq issue identeficator in project
    def create(attrs, user = @@default_user)
      attrs = { project_token: @project_token, issue_id: @issue_id }.merge(attrs)
      attrs[:issue_id] = "pid#{attrs.delete(:issue_id_in_project)}" if attrs[:issue_id_in_project]
      @attributes = send_request("issues/#{attrs[:issue_id]}/attachments", :post, :multipart) do |req|
        req.body = {
          token: attrs[:project_token],
          auth_token: user.auth_token
        }.merge(attrs.except(:project_token))
      end
    end

    # Delete attachment on EasyQA website.
    # @macro item_action_return_with_attrs_and_id
    def delete(attrs = {}, user = @@default_user)
      attrs = { id: @id, project_token: @project_token }.merge(attrs)
      @attributes = send_request("attachments/#{attrs[:id]}", :delete) do |req|
        req.params = {
          token: attrs[:project_token],
          auth_token: user.auth_token
        }
      end
    end
  end
end
