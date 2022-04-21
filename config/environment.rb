ENV['SINATRA_ENV'] ||= "development"
require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])
require_all './app'

ActiveRecord::Base.establish_connection(ENV['SINATRA_ENV'].to_sym)

# create CIK lookup table//Companies (cik, ticker, title)
APIData.get_companies

# get forms for ActiveRecord#import
APIData.get_forms