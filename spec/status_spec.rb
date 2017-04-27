require 'spec_helper'

describe EasyqaApi::Status do
  include_context 'status stub'

  include_examples 'item specification',
                   EasyqaApi::Status,
                   all: [DATA['project']['attrs']['token']],
                   create: [{
                     project_token: DATA['project']['attrs']['token'],
                     name: DATA['status']['attrs']['name']
                   }],
                   show: [DATA['project']['attrs']['token'], DATA['status']['attrs']['id']],
                   update: [{
                     project_token: DATA['project']['attrs']['token'],
                     name: DATA['status']['attrs']['name'],
                     id: DATA['status']['attrs']['id']
                   }],
                   delete: [DATA['project']['attrs']['token'], DATA['project']['attrs']['id']]
end
