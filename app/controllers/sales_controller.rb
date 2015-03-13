class SalesController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update]
  before_filter :correct_user, only: [:edit, :update, :destroy]

  def show
  	@sale = Sale.find(params[:id])
  end

  def new
  	@sale = Sale.new
  end

  def create
    @sale = current_user.sales.build(params[:sale])
    if @sale.save
      @sale.users << current_user
      @sale.owner = current_user.id
      @sale.save
      flash[:success] = "Sale created!"
      redirect_to @sale
    else
      render 'new'
    end
  end

  def edit
    @sale = Sale.find(params[:id])
  end

  def update
    @sale = Sale.find(params[:id])
    if @sale.update_attributes(params[:sale])
      flash[:success] = "Sale Updated"
      redirect_to @sale
    else
      render 'edit'
    end
  end

  def index
  	@sales = Sale.paginate(page: params[:page])
  end

  def destroy
    Sale.find(params[:id]).destroy
    flash[:success] = "Sale destroyed"
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
        @sale = current_user.sales.find(params[:id])
      end
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Unauthorized"
      redirect_to root_path
    end
end
