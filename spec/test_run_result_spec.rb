require 'spec_helper'

describe EasyqaApi::TestRunResult do
  include_context 'test run result stub'

  include_examples 'item specification',
                   EasyqaApi::TestRunResult,
                   all: [DATA['project']['attrs']['token'], DATA['test_run_result']['attrs']['test_run_id']],
                   show: [DATA['project']['attrs']['token'], DATA['test_run_result']['attrs']['id']],
                   update: [{
                     project_token: DATA['project']['attrs']['token'],
                     id: DATA['test_run_result']['attrs']['id'],
                     result_status: DATA['test_run_result']['attrs']['status']
                   }],
                   delete: [DATA['project']['attrs']['token'], DATA['test_run_result']['attrs']['id']]
end
