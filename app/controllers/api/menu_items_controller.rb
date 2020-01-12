class Api::MenuItemsController < ApplicationController
  before_action :set_menu_item, only: [:show, :edit, :update, :destroy]

  # GET /menu_items
  # GET /menu_items.json
  def index
    @menu_items = MenuItem.where(restaurant_id: params[:restaurant_id])
    render json: { 
      status: 200,
      menu_items: @menu_items
    }
  end

  # GET /menu_items/1
  # GET /menu_items/1.json
  def show
  end

  # GET /menu_items/new
  def new
    @menu_item = MenuItem.new
  end

  # GET /menu_items/1/edit
  def edit
    if current_user && @menu_item.restaurant.user == current_user
    else
      render json: { 
        status: 401,
        errors: ['restaurant does not belong to you']
      }
    end
  end

  # POST /menu_items
  # POST /menu_items.json
  def create
    if current_user
      @menu_item = MenuItem.new(menu_item_params)
      if @menu_item.save
        format.json { render :show, status: :created, location: @menu_item }
      else
        format.json { render json: @menu_item.errors, status: :unprocessable_entity }
      end
    else
      render json: { 
        status: 401,
        errors: ['login to add your menu item']
      }
    end
  end

  # PATCH/PUT /menu_items/1
  # PATCH/PUT /menu_items/1.json
  def update
    if current_user && @restaurant.user == current_user
      if @menu_item.update(menu_item_params)
        render json: { status: 201,  message: 'menu item updated'}
      else
        render json: { status: 401,  errors: ['menu item not updated'] }
      end
    else
      render json: { 
        status: 401,
        errors: ['menu item does not belong to you']
      }
    end
    
  end

  # DELETE /menu_items/1
  # DELETE /menu_items/1.json
  def destroy
    if current_user && @restaurant.user == current_user
      @menu_item.destroy
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
    def set_menu_item
      @menu_item = MenuItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def menu_item_params
      params.require(:menu_item).permit(:name, :price, :image, :description, :restaurant_id)
    end
end
