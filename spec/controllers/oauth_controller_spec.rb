require "rails_helper"
require "helpers"

describe OauthsController do


  describe "#callback" do
    it 'Sign up a new user' do
      allow_any_instance_of(Sorcery::Providers::Vk).to receive(:get_user_hash).and_return({uid: '1234', user_info: {email: 'someemail@mail.ru', full_name: "somename"}})
      #allow_any_instance_of(Sorcery::Controller::Submodules::External::InstanceMethods).to receive(:login_from).and_return({uid: '1234', user_info: {email: 'someemail@mail.ru'}})
      #allow_any_instance_of(Sorcery::Model::Submodules::External).to receive(:load_from_provider).and_return({uid: '1234', user_info: {email: 'someemail@mail.ru'}})

      #create(:user)
      get :callback, provider: 'vk', code: '123'
      expect(flash[:success]).to be_present
      expect(User.last.email).to eq 'someemail@mail.ru'
      #expect(Authentication).to be_present
    end
  end
end
