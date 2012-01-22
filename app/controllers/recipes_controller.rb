class RecipesController < ApplicationController
  
  before_filter :authenticate_user!, :except => [:index, :show]
  
  # GET /recipes
  # GET /recipes.json
  def index
    @recipes = Recipe.find_all_by_public(true)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @recipes }
    end
  end
  
  # GET /recipes/my
  def my
    @recipes = Recipe.find_all_by_user_id(current_user.id)

    respond_to do |format|
      format.html # my.html.erb
    end
  end

  # GET /recipes/1
  # GET /recipes/1.json
  def show
    @recipe = Recipe.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @recipe }
    end
  end

  # GET /recipes/new
  # GET /recipes/new.json
  def new
    @recipe = Recipe.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @recipe }
    end
  end

  # GET /recipes/1/edit
  def edit
    @recipe = Recipe.find(params[:id])
    
    unless @recipe.user_id == current_user.id
      respond_to do |format|
        format.html { redirect_to recipes_url, alert: 'Forbidden' }
        format.json { head :ok }
      end
      
    end
  end

  # POST /recipes
  # POST /recipes.json
  def create
    @recipe = Recipe.new(params[:recipe])
    @recipe.user_id = current_user.id

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to my_recipes_url, notice: 'Recipe was successfully created.' }
        format.json { render json: my_recipes_url, status: :created, location: @recipe }
      else
        format.html { render action: "new" }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /recipes/1
  # PUT /recipes/1.json
  def update
    @recipe = Recipe.find(params[:id])
    
    if @recipe.user_id == current_user.id
      respond_to do |format|
        if @recipe.update_attributes(params[:recipe])
          format.html { redirect_to my_recipes_url, notice: 'Recipe was successfully updated.' }
          format.json { head :ok }
        else
          format.html { render action: "edit" }
          format.json { render json: @recipe.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /recipes/1
  # DELETE /recipes/1.json
  def destroy
    @recipe = Recipe.find(params[:id])

    if @recipe.user_id == current_user.id
      
      @recipe.destroy
      
      respond_to do |format|
        format.html { redirect_to recipes_url, alert: 'Recipe was successfully destroyed.' }
        format.json { head :ok }
      end
    else  
      respond_to do |format|
        format.html { redirect_to recipes_url, alert: 'Forbidden' }
        format.json { head :ok }
      end
      
    end
  end
end
