require 'rails_helper'

RSpec.describe NotesController, type: :controller do
	describe "notes#index action" do
		it "should successfully respond" do
			get :index
			expect(response).to have_http_status(:success)
		end

		it "should show all the notes in order from smallsies to bigsies" do
			2.times do
				FactoryGirl.create(:note)
			end

			get :index
			json = JSON.parse(response.body)
			expect(json[0]['id'] < json[1]['id']).to be true
		end
	end

  describe "notes#create action" do
    before do
      post :create, params: { note: { title: "One objective truth", content: 'The Autozone commercial guy is creepy as hell' } }
    end
    it "should return 200 status code" do
      expect(response).to be_success
    end

    it "should successfully create and save a new note" do
      note = Note.last
      expect(note.title).to eq('One objective truth')
      expect(note.content).to eq('The Autozone commercial guy is creepy as hell')
    end

    it "should return the created note in response body" do
      json = JSON.parse(response.body)
      expect(json['title']).to eq('One objective truth')
      expect(json['content']).to eq('The Autozone commercial guy is creepy as hell')
    end
  end

  describe "notes#create validations" do
    before do
      post :create, params: { note: { title: '', content: '' } }
    end

    it "should not take empty values" do
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "should show validation errors" do
      json = JSON.parse(response.body)
      expect(json["errors"]["title"][0]).to eq("can't be blank")
      expect(json["errors"]["content"][0]).to eq("can't be blank")
    end
  end
end
