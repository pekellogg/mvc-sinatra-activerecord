class UsersController < ApplicationController
    get '/signup' do
      !logged_in? ? (erb :'/users/new') : (redirect '/forms')
    end

    post "/signup" do
      @user = User.new(params)
      if @user.save && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect '/forms'
      else
        redirect '/signup'
      end
    end

    get '/login' do
      !logged_in? ? (erb :'/users/login') : (redirect '/forms')
    end

    post '/login' do
      if @user = User.find_by(username: params[:username])&.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect '/forms'
      else
        redirect '/signup'
      end
    end

    get '/users/:slug' do
      @user = User.find_by_slug(params[:slug])
      erb :'users/show'
    end

    get '/logout' do
      if logged_in?
        session.clear
        redirect '/login'
      else
        redirect '/'
      end
    end
end