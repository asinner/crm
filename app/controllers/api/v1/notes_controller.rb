class Api::V1::NotesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    event = Event.find(params[:event_id])
    authorize event
    notes = event.notes
    render status: 200, json: notes
  end
  
  def create
    event = Event.find(params[:event_id])
    authorize event
    note = Note.new(note_params)
    
    if note.save(note_params)
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
    params.require(:note).permit(:body, :event_id)
  end
end
