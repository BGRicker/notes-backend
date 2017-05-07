class TagsController < ApplicationController
	def create
		note = Note.find(params[:note_id])
		note.tags.create(tag_params)
	end

	private

	def tag_params
		params.require(:tag).permit(:name)
	end
end
