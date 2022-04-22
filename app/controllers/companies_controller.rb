class CompaniesController < ApplicationController
    get '/companies' do
        binding.pry
        if logged_in?
            @user = current_user
            @companies = Companies.all.find_all{|c|Company::MAANG_CIKS.include?(c.cik)}
            erb :'/companies/index'
        else
            redirect '/login'
        end
    end
end