module My
  class ProfilesController < ApplicationController
    layout 'my'

    def show
      @my_section = "profile"
    end

    def edit
      @my_section = "settings"
    end

  end
end
