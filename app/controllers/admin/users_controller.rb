module Admin

    class UsersController < ApplicationController

        before_action :holla, only: [:destroy]
        before_action :priv, only: [:update]

        def index
            @users = User.all.page params[:page]
            
        end

        def new
            @user = User.new
        end

        def create
            session[:admin] = {admin: params[:admin]}
            if params[:user][:admin] == 0
                params[:user][:admin] = false
            else
                params[:user][:admin] = true
            end
            user_params = params.require(:user).permit(:name,:email,:password_digest,:admin)
            @user = User.new(user_params)
    
            if @user.save
                redirect_to admin_users_path, success: 'ユーザを登録しました'
            else
                render :new
            end
            
        end
    
        def edit
            @user =  User.find(params[:id])
        end
    
        def update
            @user = User.find(params[:id])
            user_params = params.require(:user).permit(:name, :email, :password_digest,:admin)
            if @user.update(user_params)
                redirect_to admin_users_path, success: "ユーザを更新しました"
            else
                render :edit
            end
        end
    
        def show
            @user = User.find(params[:id])
            @tasks = @user.tasks.page params[:page]
        end
    
        def destroy
            @user = User.find(params[:id])
            @user.destroy
            redirect_to admin_users_path, success: "ユーザを削除しました"
        end
        
        def holla
            if User.all.where(admin: :true).count == 1
                redirect_to admin_users_path, danger: "管理者が0人になるため削除できません"
            end
        end

        def priv
            if User.all.where(admin: :true).count == 1
                redirect_to admin_users_path, danger: "管理者が0人になるため権限を変更できません"
            end
        end

    end

end