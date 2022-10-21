class UsersController < ApplicationController

    skip_before_action :onlySingnIn, only: [:new, :create]
    def new
        @user = User.new
        
    end

    def create
        user_params = params.require(:user).permit(:name,:email,:password_digest)
        @user = User.new(user_params)
        if @user.valid?
            @user.admin = false
            @user.save
            session[:auth] = {id: @user.id}
            redirect_to tasks_path, success: 'アカウントを登録しました'
        else
            render 'new', status: 404
        end
        
    end

    def edit
        @user = currentUser
    end

    def update
        @user = currentUser
        user_params = params.require(:user).permit(:name, :email, :password_digest)
        if @user.update(user_params)
            redirect_to user_path, success: "アカウントを更新しました"
        else
            render :edit
        end
    end

    def show
        @user = User.find(session[:auth]['id'])
    end

    def destroy
        @user = User.find(session[:auth]['id'])
        @user.destroy
        redirect_to new_session_path, success: "compte supprimé", head: no_content
    end

end