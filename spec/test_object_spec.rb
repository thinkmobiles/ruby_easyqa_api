require 'spec_helper'

describe EasyqaApi::TestObject do
  include_context 'test object stub'

  include_examples 'item specification',
                   EasyqaApi::TestObject,
                   all: [DATA['project']['attrs']['token']],
                   create: [{
                     project_token: DATA['project']['attrs']['token'],
                     link: DATA['test_object']['attrs']['link']
                   }],
                   show: [DATA['project']['attrs']['token'], DATA['test_object']['attrs']['id']],
                   delete: [DATA['project']['attrs']['token'], DATA['test_object']['attrs']['id']]
end
