require 'rails_helper'

RSpec.describe 'TaskService' do

    before do
        @task_service = TaskService.new

        @project = Project.new(title: "Test")
        @project.save

        @task = Task.create(title: "Test", date_start: Time.now, date_end: Time.now + 2, project_id: @project.id)
    end

    describe '#create' do
    end

    describe '#destroy' do
    end

    describe '#update' do
    end

    describe '#change_status' do

        context 'Concluir tarefa' do

            it "Quando o state for nil" do
                @task_service.change_status(task_id: @task.id)
    
                expect(@task.reload.state).to eq(true)
            end
    
            it "Quando o state for false" do
                @task.update(state: false)
    
                @task_service.change_status(task_id: @task.id)
    
                expect(@task.reload.state).to be_truthy
            end
        end 
        
        context 'Transformar tarefa em pendente' do
            it "Quando o state for true" do
                @task.update(state: true)
    
                @task_service.change_status(task_id: @task.id)
    
                expect(@task.reload.state).to be_falsy
            end
        end

        it "Deve retornar erro para tarefa não encontrada" do
            expect {
                @task_service.change_status(task_id: 99999)
            }.to raise_error(TaskNotFoundException)
        end
    end
end