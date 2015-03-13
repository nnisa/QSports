class StaticPagesController < ApplicationController
  def home
  	@sales = Sale.paginate(page:params[:page])
  end

  def help
  end

  def about
  end

  def contact
  end
end
