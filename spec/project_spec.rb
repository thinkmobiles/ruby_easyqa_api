require 'spec_helper'

describe EasyqaApi::Project do
  include_context 'project stub'

  include_examples 'item specification',
                   EasyqaApi::Project,
                   all: [],
                   create: [{
                     title: DATA['project']['attrs']['title'],
                     organization_id: DATA['project']['attrs']['organization_id']
                   }],
                   show: [DATA['project']['attrs']['id']],
                   update: [{
                     title: DATA['project']['attrs']['title'],
                     id: DATA['project']['attrs']['id']
                   }],
                   delete: [DATA['project']['attrs']['id']]
end
