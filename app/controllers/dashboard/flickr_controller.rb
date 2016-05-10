class Dashboard::FlickrController < ApplicationController
  def search
    @tags = params[:flickr][:flickr_tags]
    @list = flickr.photos.search(tags: @tags).first(10)
    respond_to do |format|
      format.html
      format.js
    end
  end
end
