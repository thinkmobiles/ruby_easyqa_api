require 'spec_helper'

describe EasyqaApi::Role do
  include_context 'role stub'

  include_examples 'item specification',
                   EasyqaApi::Role,
                   all: [DATA['role']['attrs']['organization_id']],
                   create: [
                     DATA['role']['webmock']['create']['success']['request']['body']
                       .except('auth_token').merge(organization_id: DATA['role']['attrs']['organization_id'])
                   ],
                   show: [DATA['role']['attrs']['id']],
                   update: [DATA['role']['attrs']['role'], DATA['role']['attrs']['id']],
                   delete: [DATA['role']['attrs']['id']]
end
