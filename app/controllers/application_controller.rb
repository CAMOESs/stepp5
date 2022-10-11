class ApplicationController < ActionController::Base
    before_action :onlySingnIn
    helper_method :currentUser, :userSingnIn
    add_flash_types :success, :danger
    
    private

    def onlySingnIn
        if !userSingnIn
            redirect_to new_session_path, danger: "ログイン し て"
        end 
    end

    def currentUser
        return nil if !session[:auth] || !session[:auth]['id']
        return @_user if @_user
        @_user = User.find_by_id(session[:auth]['id'])
    end

    def userSingnIn
        !currentUser.nil?
    end
    def onlySingnOut
        redirect_to tasks_path, danger: " ログアウト し て " if userSingnIn
    end
end
