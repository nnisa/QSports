class BandsController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update]
  before_filter :correct_user, only: [:edit, :update, :destroy]

  def show
  	@band = Band.find(params[:id])
  end

  def new
  	@band = Band.new
  end

  def create
    @band = current_user.bands.build(params[:band])
    if @band.save
      @band.users << current_user
      flash[:success] = "Band created!"
      redirect_to @band
    else
      render 'new'
    end
  end

  def edit
    @band = Band.find(params[:id])
  end

  def update
    @band = Band.find(params[:id])
    if @band.update_attributes(params[:band])
      flash[:success] = "Band Updated"
      redirect_to @band
    else
      render 'edit'
    end
  end

  def index
  	@bands = Band.paginate(page: params[:page])
  end

  def destroy
    Band.find(params[:id]).destroy
    flash[:success] = "Band destroyed"
    redirect_to users_path
  end

  private

    def admin_user
      if signed_in?
        redirect_to(root_path) unless current_user.admin?
      else
        redirect_to(root_path)
      end
    end

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to root_path, notice: "Please sign in."
      end
    end

    def correct_user
      if !current_user.admin?
        @band = current_user.bands.find(params[:id])
      end
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Unauthorized"
      redirect_to root_path
    end
end
