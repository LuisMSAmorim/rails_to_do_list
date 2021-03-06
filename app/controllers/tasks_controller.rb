class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]
  before_action :set_project
  after_action :update_project_percent_complete, only: [:create, :update, :destroy, :change_status]

  # GET /tasks or /tasks.json
  def index
    @tasks = Task.where(project_id: @project.id)
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @task = task_service.create(project_id: @project.id, params: task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to project_tasks_url(@project), notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    @task = task_service.update(task: @task, params: task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to project_tasks_url(@project), notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    task_service.destroy(task: @task, project_id: @project.id)

    respond_to do |format|
      format.html { redirect_to project_task_url(@task), notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # PUT /projects/:project_id/tasks/:task_id/change_status(.:format)
  def change_status
    begin
      @task = task_service.change_status(task_id: params[:task_id].to_i)
      
      respond_to do |format|
        if @task
          format.html { redirect_to project_tasks_url(@project), notice: "Task was successfully updated." }
          format.json { render :no_content }
        end
      end
    
    rescue TaskNotFoundException => e
      respond_to do |format|
        format.html { redirect_to project_tasks_url(@project), notice: e.message }
        format.json { render :no_content }
      end
      
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:title, :date_start, :date_end, :state)
    end

    def set_project
      @project ||= Project.find_by(id: params[:project_id].to_i)
    end

    def task_service
      @task_service ||= TaskService.new
    end

    def project_service
      @project_service ||= ProjectService.new 
    end

    def update_project_percent_complete
      project_service.update_percent_complete(@project.id)
    end
end
