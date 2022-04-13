class TaskService < ApplicationService

    def create(project_id:, params:)
        task = Task.new(params)
        task.project_id = project_id

        task.save
        task
    end

    def update(task:, params:)
        task = find_task(task_id: task.id)
        task.assign_attributes(params)

        task.save
        task
    end

    def destroy(task:, project_id:)
        task = find_task(task_id: task.id)
        task.destroy 
    end
    
    def change_status(task_id:)
        task = find_task(task_id: task_id)

        raise TaskNotFoundException if task.blank?

        change_task_state(task)   
        task.save
    end

    private

    def find_task(task_id:)
        Task.find_by(id: task_id)
    end

    def change_task_state(task)
        task.state = !task.state
    end
end