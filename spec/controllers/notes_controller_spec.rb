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

		it "should include associated tags in response" do
			note = FactoryGirl.create(:note)
			tag = FactoryGirl.create(:tag, note_id: note.id)
			get :index
			json = JSON.parse(response.body)
			expect(json[0]['tags'][0]['name']).to eq(tag.name)
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

  describe "notes#show" do
		before do
      @note = FactoryGirl.create(:note)
		end

    it "should show you a note" do
      get :show, params: { id: @note.id }
      json = JSON.parse(response.body)
      expect(json['id']).to eq(@note.id)
    end

    it "should include associated tags in response" do
      tag = FactoryGirl.create(:tag, note_id: @note.id)
      get :show, params: { id: @note.id }
      json = JSON.parse(response.body)
      expect(json['tags'][0]['name']).to eq(tag.name)
    end
  end

	describe "notes#update" do
		before do
			@note = FactoryGirl.create(:note)
		end

		it "should receive the updated note in response" do
			put :update, params: { id: @note.id, note: { title: 'Wow cool note', content: 'Hot dang what a note this is' } }
			json = JSON.parse(response.body)
			expect(json['title']).to eq('Wow cool note')
			expect(json['content']).to eq('Hot dang what a note this is')
			expect(response).to be_success
		end

		it "should properly deal with validation errors" do
			put :update, params: { id: @note.id, note: { title: '', content: '' } }
			expect(response).to have_http_status(:unprocessable_entity)
		end

		it "should return error json on validation error" do
			put :update, params: { id: @note.id, note: { title: '', content: '' } }
			json = JSON.parse(response.body)
			expect(json["errors"]["content"][0]).to eq("can't be blank")
			expect(json["errors"]["title"][0]).to eq("can't be blank")
		end
	end

	describe "notes#destroy action" do
		before do
			@note = FactoryGirl.create(:note)
			delete :destroy, params: { id: @note.id }
		end

		it "should destroy a saved note" do
			note = Note.find_by_id(@note.id)
			expect(note).to eq nil
		end

		it "should return no_content status" do
			expect(response).to have_http_status(:no_content)
		end
	end
end
