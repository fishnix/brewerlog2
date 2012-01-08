class HomeController < ApplicationController
  def index
    @latest_recipes = Recipe.find(:all, :limit => 5, :order => "updated_at DESC")
  end
end