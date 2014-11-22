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
  
  private
  
  def note_params
    params.require(:note).permit(:body)
  end
end
