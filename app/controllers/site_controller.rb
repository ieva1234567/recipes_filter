class SiteController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.js
    end
  end

  def sitemap
    @recipes = Recipe.all
  end
end
