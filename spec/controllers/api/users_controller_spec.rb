require 'rails_helper'

describe Api::UsersController, type: :controller do
  before :each do
    @user1 = create(:user, name: 'User1', email: 'user1@email.com', password: 'userpass')
    @user2 = create(:user, name: 'User2', email: 'user2@email.com', password: 'userpass')
  end

  describe 'POST login' do
    it 'should return the token if valid username/password' do
      post :login, params: { email: 'user1@email.com', password: 'userpass' }

      expect(response).to have_http_status(:ok)
      response_hash = JSON.parse(response.body)
      user_data = response_hash['user']

      expect(user_data['token']).to be_present
    end

    it 'should return an error if invalid username/password' do
      post :login, params: { email: 'invalid', password: 'user' }

      expect(response).to have_http_status(401)
    end
  end

  describe 'GET show' do
    it 'should return the name if user is logged in' do
      sign_in(@user1)
      id = User.first.id

      get :show, params: { id: id }

      expect(response).to have_http_status(:ok)
      response_hash = JSON.parse(response.body)

      expect(response_hash['name']).to eq @user1.name

      id = User.second.id

      get :show, params: { id: id }

      expect(response).to have_http_status(:ok)
      response_hash = JSON.parse(response.body)

      expect(response_hash['name']).to eq @user2.name
    end
  end

  it 'should return an error if user is not logged in' do
    get :show, params: { id: @user1.id }

    expect(response).not_to have_http_status(:ok)
  end

  it 'should return an error if id is not valid' do
    sign_in(@user1)

    get :show, params: { id: 7 }

    expect(response).to have_http_status(:not_found)
  end
end
