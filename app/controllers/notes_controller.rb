class NotesController < ApplicationController
  require 'coderay'
  respond_to :json

  def index
    @note = Note.new
  end

  def search
    @notes = Note.fulltext_search(params[:title])
    @notes.each do |n|
      n.content = CodeRay.scan(n.content, :ruby).div(:css => :class)
    end
    respond_with @notes
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
