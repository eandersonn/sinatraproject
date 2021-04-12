class AssignmentController < ApplicationController

    #show all assignments
    get '/assignments' do
        @assignments = Assignment.all
        erb :"/assignment/index"
    end

    #new assignemnt form
    get '/assignments/new' do
        if !logged_in?
            redirect '/login'
        end
        erb :'assignment/new'
    end

    #post assignment form
    post '/assignments' do
        redirect_if_not_logged_in
        @assignment = current_user.assignments.build(params)
        @assignment.save
        redirect "/assignments"
    end

    #show one assignment
    get '/assignments/:id' do
        redirect_if_not_logged_in
        @assignment = Assignment.find(params["id"])
        erb :"assignment/show"
    end

    #edited form assignment
    get '/assignments/:id/edit' do
        @assignment = Assignment.find(params["id"])
        redirect_if_not_authorized
        erb :"assignment/edit"
    end

    #post edited assignment form
    put '/assignments/:id' do
        @assignment = Assignment.find(params["id"])
        redirect_if_not_authorized
        @assignment.update(params["assignment"])
        redirect "/assignments/#{@assignment.id}"
    end

    delete '/assignments/:id' do
        @assignment = Assignment.find(params["id"])
        redirect_if_not_authorized
        @assignment.destroy
        redirect'/assignments'
    end

    private 
    def redirect_if_not_authorized
        if @assignment.user != current_user
            redirect '/assignments'
        end
    end
end