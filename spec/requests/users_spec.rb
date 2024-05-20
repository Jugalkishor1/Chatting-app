require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }

  before do
    sign_in user  # Devise helper to sign in the user
  end

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #dashboard' do
    let!(:friend) { create(:user) }
    let!(:friend_ship) { create(:friend_ship, user: user, friend: friend, status: true) }
    let!(:post) { create(:post, user: friend) }

    it 'assigns @posts with posts from friends' do
      get :dashboard
      expect(assigns(:posts)).to match_array([post])
    end
  end

  describe 'GET #show' do
    context 'when user exists' do
      it 'assigns the requested user to @user' do
        get :show, params: { id: user.id }
        expect(assigns(:user)).to eq(user)
      end
    end

    context 'when user does not exist' do
      it 'redirects to the dashboard with a notice' do
        get :show, params: { id: 'unknown-id' }
        expect(response).to redirect_to(users_dashboard_path)
        expect(flash[:notice]).to eq('Record not found')
      end
    end
  end

  context 'when user is not authenticated' do
    before do
      sign_out user
    end

    it 'redirects to the sign-in page' do
      get :dashboard
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
