class HomeController < ApplicationController
  def index
    @latest_recipes = Recipe.find_all_by_public(true, :limit => 5, :order => "updated_at DESC")
    
    respond_to do |format|
      format.html
      format.json { render json: @recipes }
    end
  end
end