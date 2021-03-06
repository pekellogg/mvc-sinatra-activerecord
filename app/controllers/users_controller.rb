class UsersController < ApplicationController
  get '/signup' do
    if !logged_in?
      erb :'/users/new'
    else
      redirect '/companies'
    end
  end

  post "/signup" do
    if @user = User.create(params)
      @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/companies'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'/users/login'
    else
      redirect '/companies'
    end
  end

  post '/login' do
    if @user = User.find_by(email: params[:email])&.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/companies'
    else
      redirect '/signup'
    end
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