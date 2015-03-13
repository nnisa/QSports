class GenresController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user, only: [:index, :edit, :update]

  def new
  	@genre = Genre.new
  end

  def create
    @genre = Genre.new(params[:genre])
    if @genre.save
      flash[:success] = "Genre Created"
      redirect_to genres_path
    else
      render 'new'
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def index
  	@genres = Genre.paginate(page: params[:page])
  end

  def destroy
    Genre.find(params[:id]).destroy
    flash[:success] = "Genre destroyed"
    redirect_to root_path
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update_attributes(params[:genre])
      flash[:success] = "Genre Updated"
      redirect_to @genre
    else
      render 'edit'
    end
  end

  def show
  	@genre = Genre.find(params[:id])
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
        redirect_to login_path, notice: "Please sign in."
      end
    end

    def correct_user
      if !current_user.admin?
        @genre = Genre.find(params[:id])
      end
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Unauthorized"
      redirect_to genres_path
    end
end
