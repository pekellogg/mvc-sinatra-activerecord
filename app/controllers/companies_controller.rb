class CompaniesController < ApplicationController
    # MAANG: meta, amazon, apple, netflix, google
    # MAANG_CIKS = [1326801, 1018724, 320193, 1065280, 1652044]
    get '/companies' do
        if logged_in?
            @user = current_user 
            @companies = Company.sorted_companies
            erb :'/companies/index'
        else
            redirect '/login'
        end
    end

    get '/companies/:id' do
        if logged_in?
            @user = current_user
            @company = Company.find{|c|c.id == params[:id].to_i}
            @forms = @company.forms
            erb :'/companies/show'
        else
            redirect '/login'
        end
    end
end