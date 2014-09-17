require 'spec_helper'

describe OrderItemsController do

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'save'" do
    it "returns http success" do
      get 'save'
      response.should be_success
    end
  end

  describe "GET 'delete'" do
    it "returns http success" do
      get 'delete'
      response.should be_success
    end
  end

end
