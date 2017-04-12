require 'spec_helper'

describe EasyqaApi::User do
  context 'Success' do
    context 'Signed user' do
      before :all do
        @user = create_user_with_email_and_password
      end

      it 'User must be present' do
        expect(@user).to be_truthy
      end

      it 'User auth token must be present' do
        expect(@user.auth_token).to be_truthy
      end

      it 'User name must be present' do
        expect(@user.name).to be_truthy
      end

      context '"set_default!"' do
        it 'must return user' do
          expect(@user.set_default!).to eq(@user)
        end

        it 'must set default user' do
          @user.set_default!
          expect(EasyqaApi::Item.class_variable_get('@@default_user')).to eq(@user)
        end
      end
    end

    it 'must be signed_out' do
      user = create_user_with_email_and_password
      expect(user.sign_out).to be_truthy
    end
  end

  context 'Error' do
    it 'should have error, if email invalid' do
      expect do
        EasyqaApi::User.new(email: 'something_incorrect@mail.com', password: '1234567890')
      end.to raise_error(EasyqaApi::Exception::NotFoundError, 'Invalid email or password')
    end

    it 'should have error, if password invalid' do
      expect do
        EasyqaApi::User.new(email: 'test@mail.com', password: 'stub')
      end.to raise_error(EasyqaApi::Exception::NotFoundError, 'Invalid email or password')
    end
  end
end
