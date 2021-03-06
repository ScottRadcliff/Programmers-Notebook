 class NotesController < ApplicationController
  require 'coderay'
  respond_to :json
  before_filter :is_logged_in?, :only => [:new, :create, :all, :edit, :update]

  def is_logged_in?
    if session[:user]
      return true
    else
      redirect_to :login
    end
  end

  def login
    if request.post?
      if params[:password] == SECRET
        session[:user] = true
        redirect_to :action => :new
      else
        redirect_to :login
      end
    end
  end

  def index
    @note = Note.new
  end

  def new
    @note = Note.new
  end

  def search
    @notes = Note.fulltext_search(params[:title])
    @notes.each do |n|
      n.content = CodeRay.scan(n.content, :ruby).div(:css => :class)
    end
    respond_with @notes
  end

  def create
    @note = Note.new(title: params[:title], content: params[:content])
    if @note.save
      render :text => true
    else
      render :text => false
    end
  end

  # Returns all code snippets for view and editing
  def all
    @notes = Note.order_by([:title, :desc])
  end

  def edit
    @note = Note.find(params[:id])
  end

  def update
    @note = Note.find(params[:id])
    if @note.update_attributes!(params[:note])
      flash[:notice] = "Updated Successfully"
      redirect_to :action => :all
    else
      logger.debug "Updating #{@note.id} failed."
    end
  end
end
