module SalesHelper
  def admin?
    current_user.admin?
  end

  	def current_sale
    	@current_sale ||= current_user.sales.all
  	end

    def current_sale(user)
      @current_sale ||= user.sales.all
    end
end
