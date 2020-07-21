require './config/environment'
class WorkoutsController < ApplicationController

    get "/workouts" do
      if logged_in?
        binding.pry
      @workouts = current_user.workouts #this might be causing all of the workouts to show for any user.
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
      @workout = current_user.workouts.find_by(:id => params[:id])
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
    logged_in_else_redirect
        @workout = Workout.create(name: params[:name], duration: params[:duration],  notes: params[:notes], user_id: current_user.id) #this might not be persisting the workout with the workout id.
        @workout.save 
        if @workout.save
          redirect to "/workouts"
          redirect to '/workouts/new' 
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
end