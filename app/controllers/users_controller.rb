class UsersController < ApplicationController
	 before_action :authenticate_request, except: [:create,:index]
     before_action :set_user, only: [:show,:update, :destroy]

    
	def index
		# byebug
		@users = User.all
		render json: @users, each_serializer: UserSerializer
	end

	def show
		if @current_user == @user
		render json: @user, each_serializer: UserSerializer
	  else
	  render json: {error: "you can't show other user"}
	  end
	end

	def create
		# debugger
		@user = User.new(user_params)

		if @user.save
			render json: @user, each_serializer: UserSerializer, status: :created
		else
			render json: {errors: @user.errors.full_messages}, 
			status: :unprocessable_entity
		end
	end

	def update
		if @current_user == @user
			if @current_user&.update(user_params)
				render json:{notice: "user is updated successfully"}
			else
				render json:{notice: "something went wrong"}
	    end
	  else
	  	render json: {error: "you can't update other users"}
	  end
	end


	def destroy
	 if @current_user == @user
		if @current_user.destroy
			render json: {notice: "user is deleted successfully"}
    else
         	render json: {message: "something went wrong"}
    end
   else
   	render json: {error: "you can't delete other users"}
   end
	end

    private

    def user_params
    	params.permit(:first_name, :last_name, :email, :phone, :password, :password_confirmation)
    end

    def set_user
          @user = User.find(params[:id])
          rescue ActiveRecord::RecordNotFound
      render json: { errors: 'User not found' }, status: :not_found
    end
end
