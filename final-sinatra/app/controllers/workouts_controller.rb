require './config/environment'
class WorkoutsController < ApplicationController

  
    get "/workouts" do
      if logged_in?
      workouts = Workout.all
      erb :"/workouts/index"
      else  
        redirect to '/'
      end
    end


    get "/workouts/new" do
      if logged_in?
      erb :"/workouts/new"
    else  
      redirect to '/'
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
    @workout = Workout.find_by(:id => params[:id])
    erb :"/workouts/edit"
    else
   redirect to "/workouts/#{@workout.id}"
    end
  end


  patch "/workouts/:id" do
    workout = Workout.find(params[:id])
    if logged_in? && workout.user_id == current_user.id 
      workout.update(name: params[:name],duration: params[:duration],notes: params[:notes], )
       redirect "/workouts/#{workout.id}"
      else
      redirect "/workouts/new"
    end
  end


  post "/workouts" do
      if logged_in?
        workout = Workout.new(name: params[:name], duration: params[:duration],  notes: params[:notes], user_id: current_user.id)
        if workout.save 
          redirect to "/workouts/#{workout.id}"
        else
          puts workout.errors
          redirect to '/workouts/new' 
        end
      else
        redirect to '/'
        end
      end
    end


  delete "/workouts/:id" do
      if logged_in?
        workout = Workout.find_by(:id => params[:id]) 
        if workout.user == current_user
        workout.destroy
        redirect to "/users/#{current_user.id}"
      else
        redirect to '/'
    end
  end
end