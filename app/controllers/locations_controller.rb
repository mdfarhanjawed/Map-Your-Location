class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :friends_check, only: [:show, :edit, :update, :destroy]

  # GET /locations
  # GET /locations.json  
  def index      
    @locations = Location.near(params[:search]) if params[:search].present?    
    @locations = Location.where(user_id: current_user.friends.pluck(:id).push(current_user.id)) 
    @locations = Location.where(user_id: params[:locations] ) if params[:locations].present?
    @locations = Location.where(access_type: true)  if params[:profile]=="public"   
  end

  # GET /locations/1
  # GET /locations/1.json
  def show   
    @location = Location.find(params[:id])
  end

  # GET /locations/new
  def new    
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations
  # POST /locations.json
  def create      
    @location = current_user.locations.build(location_params)

    respond_to do |format|
      if @location.save
        format.html { redirect_to @location, notice: 'Location was successfully created.' }
        format.json { render :show, status: :created, location: @location }        
      else
        format.html { render :new }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { render :show, status: :ok, location: @location }
      else
        format.html { render :edit }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location.destroy
    respond_to do |format|
      format.html { redirect_to locations_url, notice: 'Location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    def friends_check       
      user = current_user.friends.pluck(:id).push(current_user.id)
      check_user = Location.find(params[:id]).user_id
      access_type = Location.find(params[:id]).access_type
     
      unless access_type || user.include?(check_user) 
        flash[:notice] = "Cannot Access others profile other than your friends"
        redirect_to root_url
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params       
      params.require(:location).permit(:address, :latitude, :longitude,:user_id, :access_type, :locate)
    end
end
