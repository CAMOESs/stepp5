module Admin

    class ApplicationController < ::ApplicationController
        
        before_action :onlyAdmin

        private 
            def onlyAdmin
                if !userSingnIn || currentUser.admin === false
                    redirect_to tasks_path, danger: "管理者以外はアクセスできません"
                end
            end
    end

end