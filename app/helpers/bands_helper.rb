module BandsHelper
  def admin?
    current_user.admin?
  end

  	def current_band
    	@current_band ||= current_user.bands.all
  	end

    def current_band(user)
      @current_band ||= user.bands.all
    end
end
