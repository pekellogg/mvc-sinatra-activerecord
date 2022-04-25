class CompaniesController < ApplicationController
    # MAANG: meta, amazon, apple, netflix, google
    # MAANG_CIKS = [1326801, 1018724, 320193, 1065280, 1652044]
    get '/companies' do
        if logged_in?
            @user = current_user 
            companies = Company.all
            @companies = companies.sort
            @companies.each do |c|
                binding.pry
                c.forms.class.group("report_date").order('report_date desc')
            end
            erb :'/companies/index'
        else
            redirect '/login'
        end
    end
end