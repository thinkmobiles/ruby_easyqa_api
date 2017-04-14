require 'spec_helper'

describe EasyqaApi::User do
  include_context 'shared user'

  context 'Success' do
    context 'Signed user' do
      subject { @current_user }

      it { should be_truthy }
      it('Must be valid auth token') { expect(subject.auth_token).to eq DATA['user']['attrs']['auth_token'] }
      it('Must be valid name') { expect(subject.name).to eq DATA['user']['attrs']['name'] }

      context '"set_default!"' do
        it('must return user') { expect(subject.set_default!).to eq(subject) }

        it 'must set default user' do
          subject.set_default!
          expect(EasyqaApi::Item.class_variable_get('@@default_user')).to eq(subject)
        end
      end
    end

    it 'must be signed_out' do
      sign_out_stub
      user = create_user_with_email_and_password
      expect(user.sign_out).to be_truthy
    end
  end

  context 'Error' do
    before(:each) { error_sign_in_stub }

    it 'should have error, if email invalid' do
      expect do
        EasyqaApi::User.new(email: 'stub@mail.com', password: DATA['user']['attrs']['password'])
      end.to raise_error(EasyqaApi::Exception::NotFoundError, 'Invalid email or password')
    end

    it 'should have error, if password invalid' do
      expect do
        EasyqaApi::User.new(email: DATA['user']['attrs']['email'], password: 'stub')
      end.to raise_error(EasyqaApi::Exception::NotFoundError, 'Invalid email or password')
    end
  end
end
