class Api::V1::NotesController < ApplicationController
  before_action :authenticate_user!

  def create
    lead = Lead.find(params[:lead_id])
    authorize lead
    note = lead.notes.build(note_params)

    if note.save
      render status: 201, json: note
    else
      render status: 422, json: note.errors
    end
  end

  def update
    note = Note.find(params[:id])
    authorize note

    if note.update(note_params)
      render status: 200, json: note
    else
      render status: 422, json: note.errors
    end
  end

  def destroy
    note = Note.find(params[:id])
    authorize note
    note.delete
    render status: 204, nothing: true
  end

  private

  def note_params
    params.require(:note).permit(:body)
  end
end
