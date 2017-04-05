module EasyqaApi
  class TestRunResult < Item
    attr_accessor :id, :attributes, :project_token, :test_run_id

    install_class_methods!

    def self.all(project_token, test_run_id, user = @@default_user)
      send_request("test_runs/#{test_run_id}/test_run_results", :get) do |req|
        req.params = {
          auth_token: user.auth_token,
          token: project_token
        }
      end
    end

    def create(attrs, user = @@default_user)
      attrs = { project_token: @project_token, test_run_id: @test_run_id }.merge(attrs)
      @attributes = send_request("test_runs/#{attrs[:test_run_id]}/test_run_results", :post) do |req|
        req.body = {
          test_run_result: attrs.except(:project_token, :test_run_id),
          token: attrs[:project_token],
          auth_token: user.auth_token
        }
      end
    end

    def show(project_token = @project_token, id = @id, user = @@default_user)
      @attributes = send_request("test_run_results/#{id}", :get) do |req|
        req.params = {
          token: project_token,
          auth_token: user.auth_token
        }
      end
    end

    def update(attrs, user = @@default_user)
      attrs = { id: @id, project_token: @project_token }.merge(attrs)
      @attributes = send_request("test_run_results/#{attrs[:id]}", :put) do |req|
        req.body = {
          test_run_result: attrs.except(:project_token, :id),
          token: attrs[:project_token],
          auth_token: user.auth_token
        }
      end
    end

    def delete(project_token = @project_token, id = @id, user = @@default_user)
      @attributes = send_request("test_run_results/#{id}", :delete) do |req|
        req.params = {
          token: project_token,
          auth_token: user.auth_token
        }
      end
    end
  end
end
