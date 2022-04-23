class ApplicationController < ActionController::Base
  rescue_from Flickr::FailedResponse, with: :user_not_found

  private

  def user_not_found
    flash.now[:error] = "User not found"
    render 'static_pages/index' and return
  end
end
