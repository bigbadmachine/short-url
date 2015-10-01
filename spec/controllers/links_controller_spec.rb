require "rails_helper"

RSpec.describe LinksController do

  describe 'GET #new' do
    it "has a 200 status code" do
      get :new
      expect(response.status).to eq(200)
    end
  end

  describe 'GET #show' do
    context 'when token is invalid' do
      it 'renders the page with error' do
        link = FactoryGirl.create(:link)
        
        get :show, token: link.token

        response.should redirect_to(link.url)
      end
    end

    context 'when token is valid' do
      it 'sets the user in the session and redirects them to their dashboard' do
        link = FactoryGirl.create(:link)
        
        get :show, token: "INVALID"

        expect(response).to redirect_to LinkShortener.default_link
        expect(flash[:error]).to match(/^Invalid link/)
      end
    end
  end

  describe 'POST #create' do
    context 'when URL is invalid' do
      it 'renders the page with error' do
        post :create, link: { url: 'invalid' }

        expect(response).to render_template(:new)
        expect(flash[:error]).to match(/^Url must be in a valid format/)
      end
    end

    context 'when URL is valid' do
      it 'renders the page and shows shortened link' do
        post :create, link: { url: 'google.com' }

        expect(response).to render_template(:new)
        assigns(:recent_link).should_not be_nil
      end
    end
  end

end