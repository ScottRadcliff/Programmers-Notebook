class NotesController < ApplicationController
  
  def index
  end


  def new
      
  end

  def create
    @note = Note.new(title: params[:title], content: params[:content])
    if @note.save
      render :text => true
    else
      render :text => false
    end
  end
end
