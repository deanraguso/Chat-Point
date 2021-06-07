class RoomsController < ApplicationController
  before_action :set_room, only: %i[ edit update destroy add_user remove_user ]
  before_action :set_room_and_contents, only: [:show]
  before_action :unauthorized_redirect
  before_action :unauthorized_room_redirect, only: [:show]
  before_action :unauthorized_room_admin_redirect, only: [:edit, :update, :destroy, :add_user, :remove_user]

  # GET /rooms or /rooms.json
  def index
    @rooms = Room.all
  end

  # GET /rooms/1 or /rooms/1.json
  def show
    
  end

  # GET /rooms/new
  def new
    @room = Room.new
  end

  def add_user
    email = params.require(:user).dig(:email)
    @user_to_add = User.find_by(email: email)
    
    respond_to do |format|
      if @room.users.push(@user_to_add)
        format.html { redirect_to @room, notice: "#{@user_to_add.name} was successfully added." }
        format.json { render :show, status: :ok, location: @room }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def remove_user
    @user_to_delete = User.find(user_manipulation_params.dig(:user_id))

    respond_to do |format|
      if @room.users.delete(@user_to_delete)
        format.html { redirect_to @room, notice: "#{@user_to_delete.name} was successfully removed." }
        format.json { render :show, status: :ok, location: @room }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /rooms/1/edit
  def edit
  end

  # POST /rooms or /rooms.json
  def create
    @room = Room.new(room_params)
    @room.admin_id = current_user.id
    @room.users.push(current_user)

    respond_to do |format|
      if @room.save
        format.html { redirect_to @room, notice: "Room was successfully created." }
        format.json { render :show, status: :created, location: @room }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rooms/1 or /rooms/1.json
  def update
    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to @room, notice: "Room was successfully updated." }
        format.json { render :show, status: :ok, location: @room }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1 or /rooms/1.json
  def destroy
    @room.destroy
    respond_to do |format|
      format.html { redirect_to rooms_url, notice: "Room was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def user_manipulation_params
      params.permit(:id, :user_id, :_method, :authenticity_token)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

    def set_room_and_contents
      # @room = Room.includes({messages: [:content, :created_at, {user: [:name, :email]}]}, :admin, :users).find(params[:id])
      @room = Room.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def room_params
      params.require(:room).permit(:name, :topic, :admin_id)
    end

    # Only logged in users can access any room.
    def unauthorized_redirect
        unless current_user
            redirect_to new_user_session_path
        end
    end

    # To limit access to rooms.
    def unauthorized_room_redirect
      unless (current_user.rooms.include? @room) || (@room.admin == current_user)  
        respond_to do |format|
          format.html { redirect_to rooms_url, notice: "You are not authorized to access that room." }
          format.json { head :no_content }
        end
      end
    end

    def unauthorized_room_admin_redirect
      unless @room.admin == current_user  
        respond_to do |format|
          format.html { redirect_to @room, notice: "Only the room admin may update or delete the room." }
          format.json { head :no_content }
        end
      end
    end
end
