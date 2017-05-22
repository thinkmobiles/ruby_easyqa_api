require 'spec_helper'

describe EasyqaApi::Issue do
  include_context 'issue stub'

  include_examples 'item specification',
                   EasyqaApi::Issue,
                   all: [DATA['project']['attrs']['token']],
                   create: [{
                     project_token: DATA['project']['attrs']['token'],
                     summary: DATA['issue']['attrs']['summary'],
                     attachments: [Faraday::UploadIO.new('./spec/features/test.jpg', 'image/jpeg')]
                   }],
                   show: [{
                     project_token: DATA['project']['attrs']['token'],
                     id: DATA['issue']['attrs']['id']
                   }],
                   update: [{
                     project_token: DATA['project']['attrs']['token'],
                     summary: DATA['issue']['attrs']['summary'],
                     id: DATA['issue']['attrs']['id']
                   }],
                   delete: [{
                     project_token: DATA['project']['attrs']['token'],
                     id: DATA['issue']['attrs']['id']
                   }]
end
