require './config/environment'
class UsersController < ApplicationController

    get '/login' do 
      erb :"/users/login" 
    end

    post '/login' do
      user = User.find_by(:username => params[:username])

      if user && user.authenticate(params[:password])
        session[:user_id] = user.id 
        redirect to "/users/#{user.id}"
      else
        redirect to '/'
      end
    end

    
    get '/signup' do 
      erb :"/users/signup"
    end 
  
    post '/signup' do
      if params[:username] == "" || params[:email] == "" || params[:password] == "" || params[:name] == ""
          redirect to '/signup'     
        else
         user = User.create(:username => params[:username], :email => params[:email], :password => params[:password], :name => params[:name])         
          if user.save
              session[:user_id] = user.id
              redirect to "/users/#{user.id}"
         else
              redirect to '/signup'
         end         
      end
  end


    get '/logout' do 
      if session[:user_id] != nil 
        session.clear
      redirect to '/'
      end
    end
    
    post "/users" do
      @user = User.find_by(params[:user_id])
      @user.save
      if @user 
        session[:user_id] = @user.id
      redirect "/users/#{@user.id}"
      end
    end
  
    
    get "/users/:id" do
      if logged_in?
      @user = User.find_by(:id => params[:id])
      erb :"/users/show"
      else  
        redirect to '/'
      end
    end
  
    get "/users/:id/edit" do 
      if logged_in?
        @user = User.find_by(:id => params[:id])
        erb :"/users/edit"
      else
        redirect to '/'
      end
    end
  
    patch "/users/:id" do 
        @user = User.find_by(:id => params[:id])
        if  logged_in? && @user == current_user
          @user.update(:name => params[:name], :username => params[:username])
          redirect to "/users/#{@user.id}"
        else
          redirect to "/users/#{@user.id}/edit"
        end
    end
  
    delete "/users/:id" do 
      if logged_in?
      @user = User.find(params[:id])
      if @user == current_user
          @user.destroy
          session.clear
          redirect to '/'
      else 
        redirect to '/'
      end
      
    end
  end
end


  