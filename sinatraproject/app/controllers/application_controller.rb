require './config/environment'

class ApplicationController < Sinatra::Base
  
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'kefnlsdklnmn'
  end

  get "/" do
    erb :welcome
  end

  helpers do 
    def current_user
      if @current_user 
        @current_user
      else
        @current_user = User.find(session[:user_id])
      end
    end

    def logged_in?
      !!current_user
    end
  end

  private 
  def redirect_if_not_logged_in
    if !logged_in?
      redirect '/login'
    end
  end

end
