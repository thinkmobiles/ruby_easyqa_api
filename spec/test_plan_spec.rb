require 'spec_helper'

describe EasyqaApi::TestPlan do
  include_context 'test plan stub'

  include_examples 'item specification',
                   EasyqaApi::TestPlan,
                   all: [DATA['project']['attrs']['token']],
                   create: [{
                     project_token: DATA['project']['attrs']['token'],
                     title: DATA['test_plan']['attrs']['title']
                   }],
                   show: [DATA['project']['attrs']['token'], DATA['test_plan']['attrs']['id']],
                   update: [{
                     project_token: DATA['project']['attrs']['token'],
                     id: DATA['test_plan']['attrs']['id'],
                     title: DATA['test_plan']['attrs']['title']
                   }],
                   delete: [DATA['project']['attrs']['token'], DATA['test_plan']['attrs']['id']]
end
