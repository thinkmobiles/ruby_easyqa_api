require 'spec_helper'

describe EasyqaApi::Organization do
  include_context 'organization stub'

  include_examples 'item specification',
                   EasyqaApi::Organization,
                   all: [],
                   create: [{
                     title: DATA['organization']['attrs']['title'],
                     description: DATA['organization']['attrs']['description']
                   }],
                   show: [],
                   update: [],
                   delete: []
end
