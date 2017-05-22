require 'spec_helper'

describe EasyqaApi::TestRun do
  include_context 'test run stub'

  include_examples 'item specification',
                   EasyqaApi::TestRun,
                   all: [DATA['project']['attrs']['token']],
                   create: [{
                     project_token: DATA['project']['attrs']['token'],
                     title: DATA['test_run']['attrs']['title'],
                     assigner_id: DATA['test_run']['attrs']['assigner_id']
                   }],
                   show: [DATA['project']['attrs']['token'], DATA['test_run']['attrs']['id']],
                   update: [{
                     project_token: DATA['project']['attrs']['token'],
                     id: DATA['test_run']['attrs']['id'],
                     title: DATA['test_run']['attrs']['title'],
                     assigner_id: DATA['test_run']['attrs']['assigner_id']
                   }],
                   delete: [DATA['project']['attrs']['token'], DATA['test_run']['attrs']['id']]
end
