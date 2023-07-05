class RecipesController < ApplicationController
    def index
      if current_user
        recipes = Recipe.all.includes(:user)
        render json: recipes, include: :user, status: :ok
      else
        render json: { errors: ['Unauthorized'] }, status: :unauthorized
      end
    end
  
    def create
      if current_user
        recipe = current_user.recipes.build(recipe_params)
  
        if recipe.save
          render json: recipe, include: :user, status: :created
        else
          render json: { errors: recipe.errors.full_messages }, status: :unprocessable_entity
        end
      else
        render json: { errors: ['Unauthorized'] }, status: :unauthorized
      end
    end
  
    private
  
    def recipe_params
      params.permit(:title, :instructions, :minutes_to_complete)
    end
end
