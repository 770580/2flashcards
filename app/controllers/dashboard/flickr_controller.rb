class Dashboard::FlickrController < ApplicationController
  def search
    text = params[:flickr_search]
    @list = text.empty? ? flickr.photos.getRecent(per_page: 10) : flickr.photos.search(text: text, per_page: 10)
    respond_to do |format|
      format.js
    end
  end
end
