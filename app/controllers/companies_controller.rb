class CompaniesController < ApplicationController
    get '/companies' do
        if logged_in?
            @user = current_user 
            @companies = Company.all.find_all do |c|
                binding.pry
                Company::MAANG_CIKS.include?(c.cik)
            end
            erb :'/companies/index'
        else
            redirect '/login'
        end
    end
end