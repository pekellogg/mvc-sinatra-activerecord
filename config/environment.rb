ENV['SINATRA_ENV'] ||= "development"
require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])
require_all './app'

ActiveRecord::Base.establish_connection(ENV['SINATRA_ENV'].to_sym)

APIData.get_data