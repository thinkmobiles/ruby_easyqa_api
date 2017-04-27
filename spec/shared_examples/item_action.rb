shared_examples 'item action' do |action_name, described_class|
  context action_name do
    before(:each) { send("#{action_name}_action_stub") }

    context 'class method' do
      it_behaves_like 'action without logined user', action_name do
        let(:item) { described_class }
      end
      subject { described_class.send(action_name, *method_attrs[action_name]) }

      it { should be_truthy }
      it { should be_instance_of(described_class) }
      it { expect(subject.attributes).to be_instance_of(Hash) }
      it { expect(subject.id).to be_instance_of(Fixnum) }
    end

    context 'instance method' do
      subject do
        item = described_class.new
        item.send(action_name, *method_attrs[action_name])
        item
      end

      it { should be_truthy }
      it { should be_instance_of(described_class) }
      it { expect(subject.attributes).to be_instance_of(Hash) }

      it_behaves_like 'action without logined user', action_name do
        let(:item) { subject }
      end
    end
  end
end
