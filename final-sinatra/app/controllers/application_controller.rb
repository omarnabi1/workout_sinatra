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

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end
  end

  get "/workouts/:id" do
    if logged_in?
      @workout = Workout.find_by(:id => params[:id])
      erb :"/workouts/show"
    else
      redirect to '/'
    end
  end

  get "/workouts/:id/edit" do
    if logged_in?
    workout = Workout.find_by(:id => params[:id])
    erb :"/workouts/edit"
    else
   redirect to redirect to "/workouts/#{workout.id}"
    end
  end

  patch "/workouts/:id" do
    workout = Workout.find(params[:id])
    if logged_in? && workout.user_id == current_user.id 
       workout.update(params[:workout])
       redirect "/workouts/#{workout.id}"
     
      else
      redirect "/workouts/new"
    end
  end


end