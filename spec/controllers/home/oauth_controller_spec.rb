require "rails_helper"
require "helpers"

describe Home::OauthsController do


  describe "#callback" do
    it 'Sign up a new user' do
      allow_any_instance_of(Sorcery::Providers::Vk).to receive(:get_user_hash).and_return({uid: '1234', user_info: {email: "someemail@mail.ru"}})
      allow_any_instance_of(Sorcery::Providers::Vk).to receive(:process_callback).and_return('access_token')
      allow_any_instance_of(Sorcery::Controller::Submodules::External::InstanceMethods).to receive(:create_from).and_return(create(:user))
      get :callback, provider: 'vk', code: '123'
      expect(flash[:success]).to be_present
      expect(User.last.email).to eq 'someemail@mail.ru'
    end
    it 'Log in existing user' do
      allow_any_instance_of(Sorcery::Providers::Vk).to receive(:get_user_hash).and_return({uid: '1234', user_info: {email: 'someemail@mail.ru'  }})
      allow_any_instance_of(Sorcery::Providers::Vk).to receive(:process_callback).and_return('access_token')
      allow_any_instance_of(Sorcery::Model::Submodules::External::ClassMethods).to receive(:load_from_provider).and_return(build(:user))
      create(:user)
      get :callback, provider: 'vk', code: '123'
      expect(flash[:success]).to be_present
      expect(Authentication).to be_present
    end
  end
end