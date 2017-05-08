class TagsController < ApplicationController
	def create
		note = Note.find(params[:note_id])
		tag = note.tags.create(tag_params)
		
		if tag.invalid?
			render json: render_errors(tag), status: :unprocessable_entity
		end
	end

  def destroy
    tag = Tag.find(params[:id])
    tag.destroy
    head :no_content
  end

	private

	def tag_params
		params.require(:tag).permit(:name)
	end

	def render_errors(tag)
		{ errors: tag.errors }
	end
end
