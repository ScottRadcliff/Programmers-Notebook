require 'spec_helper'

describe NotesController do

  describe "Index" do
    it "loads the the index page" do
      get :index
      response.code.should eq("200")
    end
  end

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
      5.times {Note.create!(:title => "Title", :content => "content")}
      get :all
      assigns(:notes).should_not be_nil
    end
  end

  describe "#update" do
    it "updates a note" do
      note =  Note.create!(title: "Something", content: "Something else")
      post :update, :id => note.id, :note => {title: "Foo", content: "Something else too"}
      assigns(:note).title.should == "Foo"
    end
  end

end
