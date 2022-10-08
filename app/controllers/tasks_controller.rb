class TasksController < ApplicationController
    #require 'date_time_attribute'
    before_action :set_task, only: %i[ show edit update destroy ]
  
    def index
      if params[:sort_deadline_on]
        @tasks = Task.all.order(deadline_on: :asc).page params[:page]
      elsif 
        if params[:sort_priority] && (conf != 1)
          @tasks = Task.all.order(created_at: :desc).page params[:page]
        else
          @tasks = Task.all.order(priority: :desc).page params[:page]
        end
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
        session[:title] = params[:search][:title]
        session[:status] = params[:search][:status]
        #Task.where("title = ? AND status = ?", params[:search][:title], params[:search][:status])
        redirect_to tasks_path
    end
  
  private
  
    def set_task
      @task = Task.find(params[:id])
    end
  
    def task_params
      params.require(:task).permit(:title, :content, :deadline_on,:priority, :status)
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
        prio = task.priority
        if prio != nil && task.priority? == false
          break i = 1 
        end
      end
    end
    
end