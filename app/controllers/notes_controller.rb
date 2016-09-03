class NotesController < ApplicationController

  before_action :find_note, only: [:edit, :update, :destroy, :show]
  before_action :authenticate_user!

  def index
    @notes = Note.where(user_id: current_user).order("created_at DESC")
  end

  def new
    @note = current_user.notes.build
  end

  def create
    @note = current_user.notes.build(note_params)
    if @note.save
      redirect_to @note
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @note.update(note_params)
      redirect_to @note
    else
      render "edit"
    end
  end

  def show
  end

  def destroy
    @note.destroy
    redirect_to root_path
  end

  private
  def note_params
    params.require(:note).permit(:title, :content)
  end

  def find_note
    @note = Note.find(params[:id])
  end

end
