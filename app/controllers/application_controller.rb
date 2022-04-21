require_relative '../../config/environment'

class ApplicationController < Sinatra::Base
  configure do
    enable :sessions
    set :sessions_secret, 'y7vbK"m;*8vsSH_c'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  helpers do
    def logged_in?
      current_user ? true : false
    end

    def current_user
      session[:user_id] ? (User.find_by_id(session[:user_id])) : nil
    end
  end
end