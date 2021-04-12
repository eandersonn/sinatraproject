class UserController < ApplicationController

    #show sign up form
    get '/signup' do
        erb :"user/signup"
    end

    #post sign up form
    post '/signup' do
        user = User.new(name: params["name"], email: params["email"], password: params["password"])

        if user.email.blank? && user.password.blank?
            redirect '/signup'
        else
            user.save
            session[:user_id] = user.id
            redirect '/assignments'
        end
    end


    #show login form
    get '/login' do
        erb :"/user/login"
    end

    #post login form
    post '/login' do
        u = User.find_by_email(params[:email])
        if u && u.authenticate(params[:password])
            session[:user_id] = u.id
            redirect '/assignments'
        else
            redirect '/login'
        end
    end

    #logout
    get '/logout' do
        session.clear 
        redirect '/login'
    end
end