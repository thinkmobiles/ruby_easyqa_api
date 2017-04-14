require 'spec_helper'

describe EasyqaApi::Organization do
  include_examples 'item specification',
                   EasyqaApi::Organization,
                   all: [],
                   create: [{
                     title: "Test #{rand(1..99_999)}",
                     description: 'Description'
                   }],
                   show: [],
                   update: [],
                   delete: []
end
