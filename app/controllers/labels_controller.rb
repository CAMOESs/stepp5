class LabelsController < ApplicationController
    def index
        @labels = User.find(currentUser.id).labels.all.page params[:page]
    end
    def new
        @label = Label.new
    end
    def create
        label_params = params.require(:label).permit(:name)
        @label = Label.new(label_params)
        @user = User.find(currentUser.id)
        @label.user = @user
        if @label.valid?
            @label.save
            redirect_to labels_path, success: "ラベルを登録しました"
        else
            render :new
        end
    end
    def show
        @label = Label.find(params[:id])
    end
    def update
        @label = Label.find(params[:id])
        label_params = params.require(:label).permit(:name)
        if @label.update(label_params)
            redirect_to labels_path, success: "ラベルを更新しました"
        else
            render :edit
        end
    end
    def edit
        @label = Label.find(params[:id])
    end
    def destroy
        @label = Label.find(params[:id])
        @label.destroy
        redirect_to labels_path , danger: "ラベルを削除しました"
    end

end