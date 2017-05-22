require 'spec_helper'

describe EasyqaApi::TestCase do
  include_context 'test case stub'

  include_examples 'item specification',
                   EasyqaApi::TestCase,
                   all: [{
                     project_token: DATA['project']['attrs']['token'],
                     parent_name: :test_plan,
                     parent_id: DATA['test_case']['attrs']['test_plan_id']
                   }],
                   create: [{
                     project_token: DATA['project']['attrs']['token'],
                     module_id: DATA['test_case']['attrs']['module_id'],
                     title: DATA['test_case']['attrs']['title']
                   }],
                   show: [DATA['project']['attrs']['token'], DATA['test_case']['attrs']['id']],
                   update: [{
                     project_token: DATA['project']['attrs']['token'],
                     id: DATA['test_case']['attrs']['id'],
                     title: DATA['test_case']['attrs']['title']
                   }],
                   delete: [DATA['project']['attrs']['token'], DATA['test_case']['attrs']['id']]
end
