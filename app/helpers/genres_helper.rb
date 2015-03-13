module GenresHelper
	def admin?
    current_user.admin?
  end
end
