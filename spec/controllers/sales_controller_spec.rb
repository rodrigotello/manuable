require 'spec_helper'

describe SalesController do

  describe "GET 'dashboard'" do
    it "returns http success" do
      get 'dashboard'
      response.should be_success
    end
  end

end
