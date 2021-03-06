class CommentsController < ApplicationController
    get '/comments/:id' do
        if logged_in?
            @comment = Comment.find(params[:id])
            @form = Form.all.find{|f|f.comments.include?(@comment)}
            @company = Company.all.find{|c| c.forms.include?(@form)}
            erb :'/comments/show'
        else
            redirect '/login'
        end
    end   

    post '/comments' do
        @user = current_user
        if params[:text] && params[:form_id]
            @comment = Comment.new(text: params[:text], user_id: @user.id)
            if @comment.valid? && @comment.user_id == @user.id
                @form = Form.all.find{|f| f.id == params[:form_id].to_i}
                @company = Company.find{|c|c.forms.include?(@form)}
                @form.comments << @comment
                erb :'/comments/show'
            else
                redirect '/login'
            end
        end
    end

    get '/comments/:id/edit' do
        if logged_in?
            @user = current_user
            @comment = Comment.find(params[:id])
            if @comment.user_id == @user.id
                erb :'/comments/edit'
            else
                redirect '/companies'
            end
        else
            redirect '/login'
        end
    end

    patch '/comments/:id' do 
        @comment = Comment.find(params[:id])
        if logged_in?
            if @comment.user_id == current_user.id && !@comment.text.empty?
                @comment.update(text: params[:text])
                @comment.save if @comment.valid?
                @form = Form.all.find{|f|f.comments.include?(@comment)}
                redirect '/companies'
            else
                redirect '/companies'
            end
        else
            redirect '/login'
        end
    end

    delete '/comments/:id/delete' do
        @comment = Comment.find(params[:id])
        @user = current_user
        if logged_in? && @comment.user_id == @user.id
            @comment.destroy
            redirect '/companies'
        else
            redirect '/companies'
        end
    end
end