module EasyqaApi
  class IssueAttachment < Item
    attr_accessor :id, :attributes, :project_token, :issue_id

    install_class_methods! only: [:create, :delete]

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
