require 'rails_helper'

RSpec.describe TagsController, type: :controller do
	describe "tags#create" do
		before do
			@note = FactoryGirl.create(:note)
			post :create, params: { tag: { name: 'Extremely Nice' }, note_id: @note.id }
		end

		it "should return 200 status" do
			expect(response).to be_success
		end

		it "should create and save new tag" do
			expect(@note.tags.count).to eq(1)
		end
	end

	describe "tags#create validations" do
		before do
			note = FactoryGirl.create(:note)
			post :create, params: { tag: { name: '' }, note_id: note.id }
		end

		it "should properly deal with validation error" do
			expect(response).to have_http_status(:unprocessable_entity)
		end

		it "returns json error on validation error" do
			json = JSON.parse(response.body)
			expect(json['errors']['name'][0]).to eq("can't be blank")
		end
	end

  describe "tags#destroy" do
    before do
      note = FactoryGirl.create(:note)
      @tag = FactoryGirl.create(:tag, note_id: note.id)
      delete :destroy, params: { id: @tag.id }
    end

    it "should return a 200 status" do
      expect(response).to be_success
    end

    it "should be removed from the database" do
      deleted_tag = Tag.find_by_id(@tag.id)
      expect(deleted_tag).to eq nil
    end
  end
end
