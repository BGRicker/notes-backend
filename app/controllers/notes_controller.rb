class NotesController < ApplicationController
  def index
		notes = Note.order(id: :asc)
		render json: notes
  end

  def create
    note = Note.create(note_params)
    if note.valid?
      render json: note, status: :created
    else
      render json: render_errors(note), status: :unprocessable_entity
    end
  end

  def show
    note = Note.find(params[:id])
    render json: note
  end

  private

  def note_params
    params.require(:note).permit(:title, :content)
  end

  def render_errors(note)
    { errors: note.errors }
  end
end
