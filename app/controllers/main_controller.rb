class MainController < ApplicationController
    def index
        if @current_user
            render 'main/loggedin_index'
        end
    end

    def about
        @post = Post.last
    end
end