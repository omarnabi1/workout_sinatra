require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get "/" do
    erb :welcome
  end

  helpers do 
    def logged_in? 
      !!session[:user_id]
    end

    def logged_in_else_redirect 
      if logged_in?
      else
        redirect to '/'
      end
    end



    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end
  end
  


#   delete "/workouts/:id" do #This same controller will not work in the workouts controller but will work in the application controller
#     if logged_in?
#       workout = Workout.find_by(:id => params[:id]) 
#       if workout.user == current_user
#       workout.destroy
#       redirect to "/users/#{current_user.id}"
#     else
#       redirect to '/'
#   end
# end
# end

end 
