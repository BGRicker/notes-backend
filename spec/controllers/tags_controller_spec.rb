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
end
