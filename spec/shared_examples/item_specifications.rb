shared_examples 'item specification' do |described_class, attributes|
  include_context 'shared user'

  context 'Without default user' do
    before(:all) { drop_default_user }

    it_behaves_like 'item actions', described_class, attributes do
      let(:method_attrs) { attributes }
    end
  end

  context 'With default user' do
    before(:all) { @current_user.set_default! }

    it_behaves_like 'item actions', described_class, attributes do
      let(:method_attrs) do
        attributes.each_with_object({}) do |(key, values), hash|
          hash[key] = values + [@current_user]
        end
      end
    end
  end
end
