class TasksController < ApplicationController
    #require 'date_time_attribute'
    before_action :set_task, only: %i[ show edit update destroy ]
    #before_action :onlySingnOut, only: [:new, :create]

    def index
      if params[:sort_deadline_on]
        @tasks = Task.deadline_on.page params[:page]
      elsif params[:sort_priority] && (conf != 1)
        @tasks = Task.priority.page params[:page]
          
      elsif
        @sess = session[:search]
        @tasks = Task.all.order(created_at: :desc).page params[:page]
        @title = session[:title]
        @status = session[:status]
        
        if ((@title != nil || @status != nil))
         
          if @title != '' && @status !=''
            if @status == "未着手" && @title != nil
              @tasks = Task.statuS(@title,0).page params[:page]
            elsif @status == "着手中" && @title != nil
              @tasks = Task.statuS(@title,1).page params[:page]
            elsif @status == "完了" && @title != nil
              @tasks = Task.statuS(@title,2).page params[:page]
            end
            
          elsif (@status == '' && @title.is_a?(String))
            @tasks = Task.title(@title).page params[:page]
          elsif @title == '' && @status != nil
            if @status == "未着手" 
              @tasks = Task.status(0).page params[:page]
            elsif @status == "着手中"
              @tasks = Task.status(1).page params[:page]
            elsif @status == "完了"
              @tasks = Task.status(2).page params[:page]
            end
          
          end
        
        end
        session.destroy
      else
        @tasks = Task.all.order(created_at: :desc).page params[:page]
      end
    end
  
    def new
      @task = Task.new
    end
  
    def create
      @task = Task.new(task_params)
      if @task.save
        flash[:success]= t("message.flash.success.type1") 
        redirect_to tasks_path
      else
        render :new
      end
    end
  
    def show
    end
  
    def edit
    end
  
    def update
      
      if @task.update(task_params)
        #session[:lab] = {label_ids: @task.label_ids}
        puts params[:task][:label_ids]
        params[:task][:label_ids].each do |i|
          #if i === task
          @task.labels << Label.find(i)
        end
        #session.delete(:lab)
        flash[:success]=t("message.flash.success.type2")
        redirect_to tasks_path
      else
        render :edit
      end
    end
  
    def destroy
      @task.destroy
      flash[:danger]=t("message.flash.danger")
      redirect_to tasks_path
    end
    def search
      session[:search] = params[:search]
      session[:search?] = 1
      session[:title] = params[:search][:title]
      session[:status] = params[:search][:status]
      redirect_to tasks_path
    end

  private
  
    def set_task
      @task = Task.find(params[:id])
    end
  
    def task_params
      params.require(:task).permit(:title, :content, :deadline_on,:priority, :status,:user_id,:label_ids)
    end

    def relative_time_in_time_zone(time, zone)
      p.created_at.in_time_zone('Asia/Tokyo')
      #Time.new(@f[0].to_i, @f[1].to_i,@f[2].to_i,@f[3].to_i,@f[4].to_i,@f[5].to_i, "+09:00")
      DateTime.parse(time.strftime("%d %b %Y %H:%M:%S +0900 #{time.in_time_zone(zone).formatted_offset}"))
    end

    def conf
      i = 0
      @tasks = Task.all
      @tasks.each do |task|
        if task.priority? == false
          break i = 1 
        end
      end
    end
    
end