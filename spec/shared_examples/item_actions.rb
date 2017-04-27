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

  if attributes[:create]
    context 'create' do
      before(:each) { create_action_stub }

      context 'class method' do
        it_behaves_like 'action without logined user', :create do
          let(:item) { described_class }
        end
        subject { described_class.create(*method_attrs[:create]) }

        it { should be_truthy }
        it { should be_instance_of(described_class) }
      end

      context 'instance method' do
        subject do
          item = described_class.new
          item.create(*method_attrs[:create])
          item
        end

        it { should be_truthy }
        it { should be_instance_of(described_class) }

        it_behaves_like 'action without logined user', :create do
          let(:item) { subject }
        end
      end
    end
  end
end
