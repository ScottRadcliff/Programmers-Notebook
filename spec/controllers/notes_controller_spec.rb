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

end
