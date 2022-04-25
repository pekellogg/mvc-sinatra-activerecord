class FormsController < ApplicationController
    get '/forms' do
        @forms = Form.all
        # @companies = 
        erb :'forms/show'
    end
end