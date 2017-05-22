shared_context 'issue attachment stub' do
  def create_action_stub
    action_stub_with_body(
      :issue_attachment, :create, :post, "issues/#{DATA['issue_attachment']['attrs']['attachable_id']}/attachments"
    )
  end

  def delete_action_stub
    action_stub_with_body(:issue_attachment, :delete, :delete, "attachments/#{DATA['issue_attachment']['attrs']['id']}")
  end
end
