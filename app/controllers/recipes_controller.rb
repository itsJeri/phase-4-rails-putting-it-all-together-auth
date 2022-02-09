class RecipesController < ApplicationController
  def index
    recipe = Recipe.all
    render json: recipe
  end

  def show
    recipe = User.find(session[:user_id]).recipes.create!(recipe_params)
    render json: recipe, status: :created
  end

  private

  def recipe_params
    params.permit(:title, :instructions, :minutes_to_complete)
  end

end
