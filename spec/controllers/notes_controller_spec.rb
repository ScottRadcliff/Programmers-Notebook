require 'spec_helper'

describe NotesController do


  describe "New note" do
    it "loads the new form" do
      get :new
     response.should redirect_to('/login')
    end
  end

  describe "#create" do
    it "creates a new record" do
      post :create, :title => "Something", :content => "Some content"
      response.code.should eq("302") # Just a redirect. Pretty dumb test
    end
  end

  describe "#search" do
    it "returns an array of json objects" do
      Note.create!(:title => "Using nginx")
      get :search, :title => "ng"
      notes = assigns(:notes)
      notes.should_not be_nil
    end
  end

  describe "#all" do
    it "returns all notes" do
      Note.delete_all
      5.times {Note.create!(:title => "Title", :content => "content")}
      session[:user] = true
      get :all
      assigns(:notes).count.should == 5
    end
  end

  describe "#update" do
    it "updates a note" do
      note =  Note.create!(title: "Something", content: "Something else")
      session[:user] = true
      post :update, :id => note.id, :note => {title: "Foo", content: "Something else too"}
      assigns(:note).title.should == "Foo"
    end
  end

end
