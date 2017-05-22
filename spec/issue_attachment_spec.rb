require 'spec_helper'

describe EasyqaApi::IssueAttachment do
  include_context 'issue attachment stub'

  include_examples 'item specification',
                   EasyqaApi::IssueAttachment,
                   create: [{
                     project_token: DATA['project']['attrs']['token'],
                     attachment: Faraday::UploadIO.new('./spec/features/test.jpg', 'image/jpeg'),
                     issue_id: DATA['issue_attachment']['attrs']['attachable_id']
                   }],
                   delete: [{
                     project_token: DATA['project']['attrs']['token'],
                     id: DATA['issue_attachment']['attrs']['id']
                   }]
end
