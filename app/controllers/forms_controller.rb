class FormsController < ApplicationController
    get '/forms/:id' do
        if logged_in?
            @user = current_user
            @form = Form.all.find{|f|f.id == params[:id].to_i}
            @commenters = {}
            @form.comments.each do |comment|
                user = User.all.find{|user|user.id == comment.user_id}
                if user && !@commenters[comment.user_id]
                    @commenters[comment.user_id] = user.username
                end
            end
            @company = Company.find{|c|c.forms.include?(@form)}
            erb :'/forms/show'
        else
            redirect '/login'
        end
    end
end