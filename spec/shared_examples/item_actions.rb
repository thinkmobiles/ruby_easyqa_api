shared_examples 'item actions' do |described_class, attributes|
  if attributes[:all]
    context 'all' do
      before(:each) { all_action_stub }

      it_behaves_like 'action without logined user', :all do
        let(:item) { described_class }
      end

      it 'with logined user must be ok' do
        items = described_class.all(@current_user)
        expect(items).to be_instance_of(Array)
      end
    end
  end

  it_behaves_like 'item action', :create, described_class if attributes[:create]
  it_behaves_like 'item action', :update, described_class if attributes[:update]
end
