class WorkoutsController < ApplicationController


    get "/workouts" do 
        if logged_in? 
            @workouts = Workout.all 
            erb :"/workouts/index.html"
        else
            redirect to '/'
        end
    end


    get "/workouts/new" do 
        if logged_in?
            erb :"/workouts/new.html"
        else
            redirect to '/'
        end
    end


    post "/workouts" do 
        if params[:name].empty? || params[:muscle_]