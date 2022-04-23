class StaticPagesController < ApplicationController
  def index
    if request.query_string.present?
      flickr = Flickr.new

      begin
        photostream = flickr.people.getPhotos(user_id: params[:flickr_id])
      rescue Flickr::FailedResponse => e
        flash.now[:error] = e.msg
        render :index and return
      end

      @img_urls = photostream_to_url(photostream)
    end
  end

  private

  def photostream_to_url(photostream)
    photostream.map do |photo|
      "https://live.staticflickr.com/#{photo['server']}/#{photo['id']}_#{photo['secret']}.jpg"
    end
  end
end
