class SessionsController < ApplicationController
    def new
    end
  
    def create
      if user = User.authenticate_with_credentials(params[:email], params[:password])
        # Save the user id inside the browser cookie.
        session[:user_id] = user.id
        redirect_to :root
      else
        # if login fails, send to login form
        redirect_to '/sessions/new'
      end
  
    end
  
    def destroy
      session[:user_id] = nil
      redirect_to '/sessions/new'
    end
end
