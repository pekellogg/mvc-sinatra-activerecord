class UsersController < ApplicationController
  get '/signup' do
    if !logged_in?
      erb :'/users/new'
    else
      redirect '/companies'
    end
  end

  post "/signup" do
    if User.valid_username?(params[:username])
      @user = User.new(params)
      if @user.save && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        flash[:notice] = "Thanks for signing up!"
        redirect '/companies'
      else
        redirect '/signup'
      end
    else
      flash[:error] = "Invalid format for username - please don't use special characters or spaces."
      redirect back
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
      flash[:notice] = "Welcome back!"
      session[:user_id] = @user.id
      redirect '/companies'
    else
      redirect '/signup'
    end
  end

  get '/logout' do
    if logged_in?
      flash[:notice] = "Thanks using MAANG Employers Audit!"
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end
end