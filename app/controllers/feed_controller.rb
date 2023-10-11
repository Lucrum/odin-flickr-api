class FeedController < ApplicationController
  def index
    if (flickr_params.present?)
      get_flickr_photos
    end
  end

  def get_flickr_photos
    flickr = Flickr.new(ENV["FLICKR_KEY"], ENV["FLICKR_SECRET"])
    response = flickr.people.getPublicPhotos(user_id: flickr_params[:id])
    @photos = []
    response.each do |info|
      server = info["server"]
      id = info["id"]
      secret = info["secret"]
      @photos.append("https://live.staticflickr.com/#{server}/#{id}_#{secret}_m.jpg")
    end
  end

  private

  def flickr_params
    params.permit(:id, :commit)
  end
end
