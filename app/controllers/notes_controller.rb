class NotesController < ApplicationController
  
  def index
    @note = Note.new
  end

  def search
    
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
