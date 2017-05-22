require 'spec_helper'

describe EasyqaApi::TestModule do
  include_context 'test module stub'

  include_examples 'item specification',
                   EasyqaApi::TestModule,
                   all: [DATA['project']['attrs']['token'], DATA['test_module']['attrs']['test_plan_id']],
                   create: [{
                     project_token: DATA['project']['attrs']['token'],
                     test_plan_id: DATA['test_module']['attrs']['test_plan_id'],
                     title: DATA['test_module']['attrs']['title']
                   }],
                   show: [DATA['project']['attrs']['token'], DATA['test_module']['attrs']['id']],
                   update: [{
                     project_token: DATA['project']['attrs']['token'],
                     id: DATA['test_module']['attrs']['id'],
                     title: DATA['test_module']['attrs']['title']
                   }],
                   delete: [DATA['project']['attrs']['token'], DATA['test_module']['attrs']['id']]
end
