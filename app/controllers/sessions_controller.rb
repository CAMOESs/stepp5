class SessionsController < ApplicationController
    
    skip_before_action :onlySingnIn, only: [:new, :create]
    before_action :onlySingnOut, only: [:new, :create]

    def new

    end

    def create
        user_params = params.require(:user)
        @user = User.where(email: user_params[:email]).first
        if @user
            session[:auth] = {id: @user.id}
            redirect_to tasks_path, success:"ログインしました", status: 302
        else
            redirect_to new_session_path, danger:"メールアドレスまたはパスワードに誤りがあります"
        end
    end

    def destroy
        session.destroy
        redirect_to new_session_path, success: "ログアウトしました"
    end
    
end