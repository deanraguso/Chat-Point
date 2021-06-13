class PagesController < ApplicationController
  def index
  end
  def demo_login
    sign_in User.find_by(email: "demouser@gmail.com")
    redirect_to root_path
  end
end
