class ObjectBuilder

	def self.create_new_user(params)
		User.create(
      :email => params[:user][:email],
      :password => params[:user][:password],
      :password_confirmation => params[:user][:password_confirmation],
      :first_name => params[:user][:first_name],
      :last_name => params[:user][:last_name],
      :phone => params[:user][:phone],
      :username => params[:user][:email]
    )
	end


end