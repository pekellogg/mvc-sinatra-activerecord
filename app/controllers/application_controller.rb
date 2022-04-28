require_relative '../../config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    use Rack::Session::Cookie, :key => 'rack.session', :path => '/', :secret => 'y7vbK\"m;*8vsSH_c'
    use Rack::Flash
  end

  get '/' do
    erb :index
  end

  helpers do
    def logged_in?
      current_user
    end

    def current_user
      User.find_by_id(session[:user_id])
    end
  end
end