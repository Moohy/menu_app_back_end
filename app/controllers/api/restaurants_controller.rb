class Api::RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]

  # GET /restaurants
  # GET /restaurants.json
  def index
    @restaurants = Restaurant.all
    render json: { 
      status: 200,
      restaurants: @restaurants
    }
  end

  # GET /restaurants/1
  # GET /restaurants/1.json
  def show
    render json: { 
      status: 200,
      restaurant: @restaurant
    }
  end

  # GET /restaurants/new
  def new
    @restaurant = Restaurant.new
  end

  # GET /restaurants/1/edit
  def edit
    if current_user && @restaurant.user == current_user
    else
      render json: { 
        status: 401,
        errors: ['restaurant does not belong to you']
      }
    end
  end

  # POST /restaurants
  # POST /restaurants.json
  def create
    if current_user
      @restaurant = Restaurant.new(restaurant_params)
      
        if @restaurant.save
          render json: { status: 201,  message: 'restaurant created'}
        else
          render json: { status: 401,  errors: ['restaurant not created'] }
        end
      
    else
      render json: { 
        status: 401,
        errors: ['login to add your restaurant']
      }
    end
  end

  # PATCH/PUT /restaurants/1
  # PATCH/PUT /restaurants/1.json
  def update
    if current_user && @restaurant.user == current_user
      
        if @restaurant.update(restaurant_params)
          render json: {  status: 201,  message: 'restaurant edited'}
        else
          render json: { status: 401,  errors: ['restaurant not edited'] }
        end
      
    else
      render json: { 
        status: 401,
        errors: ['restaurant does not belong to you']
      }
    end
  end

  # DELETE /restaurants/1
  # DELETE /restaurants/1.json
  def destroy
    if current_user && @restaurant.user == current_user
      @restaurant.destroy
      
      render json: { status: 201,  message: 'restaurant deleted'}
      
    else
      render json: { 
        status: 401,
        errors: ['restaurant does not belong to you']
      }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def restaurant_params
      params.require(:restaurant).permit(:name, :address, :image, :description, :user_id)
    end
end
