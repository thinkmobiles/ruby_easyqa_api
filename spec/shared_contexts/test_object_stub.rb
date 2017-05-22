shared_context 'test object stub' do
  def all_action_stub
    action_stub_with_query(:test_object, :all, 'test_objects')
  end

  def create_action_stub
    action_stub_with_body(:test_object, :create, :post, 'test_objects')
  end

  def show_action_stub
    action_stub_with_query(:test_object, :show, "test_objects/#{DATA['test_object']['attrs']['id']}")
  end

  def delete_action_stub
    action_stub_with_body(:test_object, :delete, :delete, "test_objects/#{DATA['test_object']['attrs']['id']}")
  end
end
