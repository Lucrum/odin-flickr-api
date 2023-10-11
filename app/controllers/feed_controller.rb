class FeedController < ApplicationController
  def index
    if (flickr_params.present?)
      get_flickr_photos
    end
  end

  def get_flickr_photos
    flickr = Flickr.new(ENV["FLICKR_KEY"], ENV["FLICKR_SECRET"])
    response = flickr.people.getPublicPhotos(user_id: flickr_params[:id], per_page: 10)
    @photos = []
    response.each do |info|
      data = flickr.photos.getInfo(photo_id: info["id"])
      @photos.append(Flickr.url_m(data))
    end
  end

  private

  def flickr_params
    params.permit(:id, :commit)
  end
end
