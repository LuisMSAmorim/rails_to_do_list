require 'rails_helper'

RSpec.describe 'TaskService' do

    before do
        @task_service = TaskService.new

        @project = Project.new(title: "Test")
        @project.save

        @task = Task.create(title: "Test", date_start: Time.now, date_end: Time.now + 2, project_id: @project.id)
    end
    
    describe '#create' do

        it "Deve criar uma nova tarefa" do
            @params = { title: "Test0", date_start: Time.now, date_end: Time.now + 2, project_id: @project.id }

            task = @task_service.create(params: @params, project_id: @project.id)
            expect(task.title).to eq("Test0")
        end
    end

    describe '#destroy' do
        
        it "Deve deletar uma tarefa" do   
            @task_service.destroy(task: @task, project_id: @project.id)

            expect(Task.all.count).to eq(0)
        end
    end

    describe '#update' do

        it "Deve atualizar os dados de uma tarefa" do
            task = @task_service.update(task: @task, params: { title: "Test1" })

            expect(task.title).to eq("Test1")
        end
    end

    describe '#change_status' do

        context 'Concluir tarefa' do

            it "Quando o state for nil" do
                @task_service.change_status(task_id: @task.id)
    
                expect(@task.reload.state).to be_truthy
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