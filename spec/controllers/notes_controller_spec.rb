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
      response.code.should eq("200")
    end
  end

  describe "#create" do
    it "creates a new record" do
      post :create, :title => "Something", :content => "Some content"
      response.code.should eq("200")
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

end
