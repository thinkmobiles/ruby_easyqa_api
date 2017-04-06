module EasyqaApi
  class Issue < Item
    attr_accessor :id, :attributes, :project_token

    install_class_methods!

    def self.all(project_token, user = @@default_user)
      send_request('issues', :get) do |req|
        req.params = {
          auth_token: user.auth_token,
          token: project_token
        }
      end
    end

    def create(attrs, user = @@default_user)
      attrs = { project_token: @project_token }.merge(attrs)
      @attributes = send_request('projects/issues/create', :post, :multipart) do |req|
        req.body = {
          token: attrs[:project_token],
          auth_token: user.auth_token,
        }.merge(attrs.except(:project_token))
      end
    end

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
  end
end
