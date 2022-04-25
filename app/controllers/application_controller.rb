require_relative '../../config/environment'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    # set :sessions, :domain => '.127.0.0.1'
    # set :sessions_secret, "y7vbK\"m;*8vsSH_c"
    # enable :sessions
    use Rack::Session::Cookie, :key => 'rack.session', :path => '/', :secret => 'y7vbK\"m;*8vsSH_c'
  end

  get '/' do
    erb :index
  end

  helpers do
    def logged_in?
      current_user ? true : false
    end

    def current_user
      User.find_by_id(session[:user_id])
    end
  end
end