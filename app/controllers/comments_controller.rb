class CommentsController < ApplicationController
    get '/comments' do
        if logged_in?
            @user = current_user
            @comments = Comment.all
            erb :'/comments/index'
        else
            redirect '/login'
        end
    end

    get '/comments/new' do
        logged_in? ? (erb :'/tweets/new') : (redirect '/login')
    end

    get '/comments/:id' do
        logged_in? ? ((@tweet = Tweet.find(params[:id])) && (erb :'/tweets/show')) : (redirect '/login')
    end   

    post '/comments' do
        if params[:content] == " " || params[:content] == ""
            redirect 'tweets/new'
        else
            @user = current_user
            @comment = Comment.new(content: params[:content], user_id: @user.id)
            if @comment.valid?
                @comment.save
                redirect "/comments/#{@comment.id}"
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
            end
        else
            redirect '/login'
        end
    end

    patch '/comments/:id' do 
        if params[:content] == " " || params[:content] == ""
            redirect back
        elsif logged_in?
            @user = current_user
            @comment = Comment.find(params[:id])
            @comment.update(content: params[:content])
            @comment.save if @comment.valid?
            redirect '/comments'
        else
            redirect '/login'
        end
    end

    delete '/comments/:id/delete' do
        if logged_in?
            @user = current_user
            @comment = Comment.find(params[:id])
            if @comment.user_id == @user.id
                @comment.destroy
                redirect '/comments'
            end
        else
            redirect '/login'
        end
    end

end